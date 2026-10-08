#!/usr/bin/env bash
# Needs bash 3.2, POSIX tools and ImageMagick 7, which the flake's dev shell carries.
# The cover keeps the layout the readme has always shown: the light shot above the
# diagonal from the top left corner to the bottom right one, the dark shot below it, and
# the calm Monika sticker from assets/ in the dark corner. The catalog shot is the cover
# at the size the Obsidian theme directory asks for
set -euo pipefail

usage() {
  cat <<'EOF'
cover.sh — make the readme's cover and the catalog's screenshot out of two full-window
screenshots of the theme, one light and one dark

  cover.sh build [-c FILE] [-s FILE] LIGHT DARK   compose the cover and the catalog shot

  -c FILE   where the cover goes, 1280x720 (default: docs/cover.png beside this script)
  -s FILE   where the catalog shot goes, 512x288 (default: screenshot.png beside this script)

The shots should be the same window in both variants; each is scaled to fill 16:9 and
cropped at its centre. docs/sample-vault is the vault they are taken in
Nothing here reaches the network
Exit 0 done, 1 when a shot is missing or unreadable, 2 on a usage error
EOF
}

fail() { # the thing asked about is wrong
  printf 'cover.sh: %s\n' "$1" >&2
  exit 1
}

die() { # the request itself is wrong
  printf 'cover.sh: %s\n' "$1" >&2
  exit 2
}

HERE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

cmd_build() {
  local cover="$HERE/docs/cover.png" shot="$HERE/screenshot.png" light dark
  while (($#)); do
    case "$1" in
      -c)
        (($# >= 2)) || die "-c needs a file"
        cover="$2"
        shift 2
        ;;
      -s)
        (($# >= 2)) || die "-s needs a file"
        shot="$2"
        shift 2
        ;;
      -*) die "no such flag: $1" ;;
      *) break ;;
    esac
  done
  (($# == 2)) || die "build takes two shots, the light one and the dark one"
  light="$1"
  dark="$2"
  [[ -f "$light" ]] || fail "no such shot: $light"
  [[ -f "$dark" ]] || fail "no such shot: $dark"

  # The light shot keeps the triangle above the diagonal through a mask of the same size
  magick \
    \( "$dark" -resize '1280x720^' -gravity center -extent 1280x720 \) \
    \( "$light" -resize '1280x720^' -gravity center -extent 1280x720 \
    \( -size 1280x720 xc:black -fill white -draw 'polygon 0,0 1280,0 1280,720' \) \
    -alpha off -compose copy-opacity -composite \) \
    -compose over -composite \
    \( "$HERE/assets/monika-sticker-calm.png" -resize x260 \) \
    -gravity southwest -geometry +28+28 -composite \
    "$cover" || fail "ImageMagick could not compose the cover"
  magick "$cover" -resize 512x288 "$shot" || fail "ImageMagick could not scale the catalog shot"
}

cmd="${1:-}"
(($# == 0)) || shift
case "$cmd" in
  build) cmd_build "$@" ;;
  -h | --help | help) usage ;;
  '')
    usage >&2
    exit 2
    ;;
  *)
    printf 'cover.sh: no such subcommand: %s\n\n' "$cmd" >&2
    usage >&2
    exit 2
    ;;
esac
