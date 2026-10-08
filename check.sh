#!/usr/bin/env bash
# Needs bash 3.2 and POSIX tools only for its own code, so behaviour mode runs unchanged
# under the bash a macOS runner has; the lint half calls actionlint, shellcheck, shfmt, jq,
# statix, deadnix and nixfmt, which come from the flake's dev shell and never from the
# runner's PATH. check-sh.sh holds this list to the calls below.
# The vendored checkers are run, never tested here: their logic lives at their sources
set -euo pipefail

usage() {
  cat <<'EOF'
check.sh — the gate for this repository: lint what it ships, prove the generator builds
a whole theme, and prove each of the generator's guards able to fail

  check.sh [lint|behaviour|all]

lint needs the linters pinned in the flake's dev shell and names any that are missing.
behaviour needs only bash and POSIX tools, so it runs under the bash 3.2 macOS ships.
all, the default, is both

  nix develop -c ./check.sh
  /bin/bash ./check.sh behaviour        # on a macOS runner, CHECK_BASH32=1

Environment: CHECK_BASH32=1 says this bash is the 3.2 under proof, and adds the probes
only that bash can fail
Nothing here touches the network, so it is safe on pull requests
Exit 0 when everything holds, 1 on a failure, 2 on an unknown mode
EOF
}

fail() { # the thing asked about is wrong
  printf 'check: %s\n' "$1" >&2
  exit 1
}

die() { # the request itself is wrong
  printf 'check: %s\n' "$1" >&2
  exit 2
}

HERE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd "$HERE"

# One source of truth for what this repository's own shell code is; the vendored
# scripts are checked at their sources
scripts=(generate.sh check.sh)

WORK=$(mktemp -d "${TMPDIR:-/tmp}/ddlc-check.XXXXXX")
trap 'rm -rf "$WORK"' EXIT

# check-sh.sh reads a script as a tree through shfmt and jq; a runner without them, the
# macOS one included, gets the bash-only half rather than a call that cannot succeed
checker() {
  local tree_flag=()
  { command -v shfmt && command -v jq; } >/dev/null 2>&1 || tree_flag=(--bash-only)
  "$BASH" "$HERE/check-sh.sh" ${tree_flag[@]+"${tree_flag[@]}"} "$@"
}

check_lint() {
  local tool missing=() version
  for tool in actionlint shellcheck shfmt jq statix deadnix nixfmt; do
    command -v "$tool" >/dev/null || missing+=("$tool")
  done
  ((${#missing[@]} == 0)) ||
    fail "missing: ${missing[*]} — they are pinned in the flake, so run this as: nix develop -c ./check.sh"

  echo "== the shell scripts lint and keep their help honest"
  shellcheck "${scripts[@]}"
  shfmt -d -i 2 -ci "${scripts[@]}"
  checker generate.sh
  CHECK_SH_NESTED=1 checker check.sh

  echo "== the workflows parse, and take their tools from the lock"
  actionlint
  ./check-pins.sh

  echo "== the flake holds to the nix standard"
  ./check-nix.sh

  echo "== the documents keep the prose rules"
  ./check-prose.sh README.md ASSETS.md CHANGELOG.md

  echo "== the changelog holds, and its newest release is the manifest's version"
  ./check-changelog.sh CHANGELOG.md
  version=$(jq -er .version manifest.json) || fail "manifest.json has no version"
  grep -qF "## [$version] - " CHANGELOG.md ||
    fail "manifest.json says $version but CHANGELOG.md has no ## [$version] heading"
}

# A throwaway copy of what the generator reads, so a planted defect never touches the tree
copy_repo() { # copy_repo NAME -> prints the copy's path
  local dest="$WORK/$1"
  mkdir -p "$dest"
  cp -R generate.sh src vendor assets "$dest/"
  printf '%s\n' "$dest"
}

# expect_fail NAME STATUS FRAGMENT COMMAND... -> the command must exit STATUS and say FRAGMENT
expect_fail() {
  local name="$1" want="$2" fragment="$3" status=0 out
  shift 3
  out=$("$@" 2>&1) || status=$?
  ((status == want)) || fail "$name: expected exit $want, got $status: $out"
  [[ "$out" == *"$fragment"* ]] || fail "$name: failed for another reason than '$fragment': $out"
  echo "   caught: $name"
}

# The names a stylesheet gives its @keyframes and @property rules. One stylesheet that
# loads later replaces such a rule of the same name in another, so the snippet's names
# must stay apart from the theme's
at_names() { # at_names FILE -> "keyframes NAME" and "property NAME" lines, sorted
  sed -n -e 's/^@keyframes \([^ {]*\).*/keyframes \1/p' -e 's/^@property \([^ {]*\).*/property \1/p' "$1" | sort -u
}

check_behaviour() {
  local repo built snippet colours slots icons stickers shared
  if [[ -n "${CHECK_BASH32:-}" ]]; then
    echo "== this bash is the 3.2 under proof"
    ((BASH_VERSINFO[0] == 3)) || fail "CHECK_BASH32 is set, but this bash is $BASH_VERSION"
    ! "$BASH" -c 'declare -A m' 2>/dev/null || fail "this bash accepts declare -A, so it is not 3.2"
  fi

  echo "== the vendored copies are byte-equal to their sources"
  "$BASH" ./vendor-sync.sh check

  echo "== the generator keeps its help honest under this bash"
  checker generate.sh >/dev/null

  echo "== the theme carries every palette colour, every base16 slot and every icon"
  mkdir -p "$WORK/built"
  "$BASH" ./generate.sh build -o "$WORK/built"
  built="$WORK/built/theme.css"
  snippet="$WORK/built/ddlc-stickers.css"
  colours=$(grep -c -- '--ddlc-[a-z-]*: #' vendor/palette.css)
  slots=$(grep -c 'base0[[:xdigit:]]:' vendor/base16-ddlc-dark.yaml)
  icons=$(find vendor/lucide -name '*.svg' | wc -l | tr -d ' ')
  (($(grep -c -- '--ddlc-[a-z-]*-rgb: ' "$built") == colours)) || fail "the theme lost a palette colour's triple"
  (($(grep -c -- '--ddlc-base0[[:xdigit:]]: #' "$built") == slots)) || fail "the theme lost a base16 slot"
  (($(grep -c -- '--ddlc-icon-[a-z-]*: url(' "$built") == icons)) || fail "the theme lost an icon"
  grep -qF "$(sed -n 1p vendor/lucide/LICENSE)" "$built" || fail "the theme lost the icons' licence notice"
  grep -q 'build-stamp\|#[0-9A-Fa-f]\{6\}' src/ddlc.css && fail "src/ddlc.css holds a literal colour or a stamp"

  echo "== the snippet carries every sticker frame, and the theme carries none"
  stickers=$(find assets -name '*-sticker-*.png' | wc -l | tr -d ' ')
  (($(grep -c -- '--ddlc-[a-z]*-sticker-[a-z]*: url("data:image/png;base64,' "$snippet") == stickers)) ||
    fail "the snippet lost a sticker frame"
  grep -q 'data:image/png' "$built" && fail "theme.css carries a sticker, which belongs to the snippet alone"

  echo "== the snippet names no animation or property the theme names"
  shared=$(comm -12 <(at_names "$built") <(at_names "$snippet"))
  [[ -z "$shared" ]] || fail "the snippet would replace the theme's $(printf '%s' "$shared" | tr '\n' ',')"

  echo "== an untouched copy passes, so every red below is the defect's own"
  repo=$(copy_repo clean)
  "$BASH" "$repo/generate.sh" build || fail "an untouched copy fails to build"

  echo "== each guard of the generator turns red for its own defect"
  repo=$(copy_repo short-hex)
  printf ':root { --ddlc-broken: #12345; }\n' >>"$repo/vendor/palette.css"
  expect_fail "a palette colour that is not six digits" 1 "not a six-digit colour for broken" "$BASH" "$repo/generate.sh" build

  repo=$(copy_repo no-colours)
  printf ':root {}\n' >"$repo/vendor/palette.css"
  expect_fail "a palette with no colours" 1 "no --ddlc-* colours" "$BASH" "$repo/generate.sh" build

  repo=$(copy_repo short-base16)
  grep -v 'base0F:' vendor/base16-ddlc-dark.yaml >"$repo/vendor/base16-ddlc-dark.yaml"
  expect_fail "a base16 scheme missing a slot" 1 "expected 16 base16 slots" "$BASH" "$repo/generate.sh" build

  repo=$(copy_repo no-icons)
  rm -f "$repo"/vendor/lucide/*.svg
  expect_fail "no icons to embed" 1 "no icons" "$BASH" "$repo/generate.sh" build

  repo=$(copy_repo licence-closes-comment)
  printf 'a stray */ here\n' >>"$repo/vendor/lucide/LICENSE"
  expect_fail "an icon licence that would close its comment" 1 "cannot sit in a comment" "$BASH" "$repo/generate.sh" build

  repo=$(copy_repo no-template)
  rm -f "$repo/src/ddlc.css"
  expect_fail "a missing template" 1 "missing" "$BASH" "$repo/generate.sh" build

  repo=$(copy_repo short-calm)
  rm -f "$repo/assets/yuri-sticker-calm.png"
  expect_fail "a calm frame short" 1 "expected 8 sticker frames" "$BASH" "$repo/generate.sh" build

  repo=$(copy_repo short-excited)
  rm -f "$repo/assets/natsuki-sticker-excited.png"
  expect_fail "an excited frame short" 1 "expected 8 sticker frames" "$BASH" "$repo/generate.sh" build

  repo=$(copy_repo no-sticker-template)
  rm -f "$repo/src/stickers.css"
  expect_fail "a missing sticker template" 1 "missing" "$BASH" "$repo/generate.sh" build

  echo "== a request it cannot serve is a usage error, not a finding"
  expect_fail "an unknown subcommand" 2 "no such subcommand" "$BASH" ./generate.sh bogus
  expect_fail "-o with no directory" 2 "-o needs a directory" "$BASH" ./generate.sh build -o
  expect_fail "-o naming no directory" 2 "is not a directory" "$BASH" ./generate.sh build -o "$WORK/not-a-dir"
  expect_fail "build with a stray argument" 2 "unexpected argument" "$BASH" ./generate.sh build extra
}

mode="${1:-all}"
case "$mode" in
  lint) check_lint ;;
  behaviour) check_behaviour ;;
  all)
    check_lint
    check_behaviour
    ;;
  -h | --help | help) usage ;;
  *)
    printf 'check: no such mode: %s\n\n' "$mode" >&2
    usage >&2
    exit 2
    ;;
esac
[[ "$mode" == -h || "$mode" == --help || "$mode" == help ]] || echo "check: everything holds"
