# Assets and third-party content

`LICENSE` (MIT) covers the **code** in this repository: `src/ddlc.css`, `generate.sh`, `check.sh` and the Nix expression. It does **not** cover the colours, which are Team Salvato's, the icons, which are Lucide's, or the fonts below

## Doki Doki Literature Club

Doki Doki Literature Club and Doki Doki Literature Club Plus are the property of [Team Salvato](https://teamsalvato.com/). This project is **unaffiliated with and not endorsed by Team Salvato**

The following are derived from official DDLC material:

| Path | What |
| --- | --- |
| `vendor/palette.css`, `vendor/base16-ddlc-dark.yaml`, `vendor/ddlc-tokens.css`, `theme.css` | the colours come from [ddlc-palette](https://github.com/rokokol/ddlc-palette), which measures them off [ddlc.moe](https://ddlc.moe/). Where each colour goes in Obsidian is mine, the values are theirs |
| `src/ddlc.css` | the polka-dot background, the "Just Monika." pop-up and the poem sheet are drawn after the game's menu, pop-up and poem screen. They are drawn in CSS, and no game artwork is copied |

The following official artwork is bundled:

| Path | What |
| --- | --- |
| `assets/*-sticker-calm.png`, `assets/*-sticker-excited.png` | the four chibi stickers in their calm and excited poses, copied unchanged from `theme/assets/` in [ddlc-sddm-theme](https://github.com/rokokol/ddlc-sddm-theme), which documents where they come from. `generate.sh` embeds them in `ddlc-stickers.css`, the optional snippet a release carries; `theme.css` carries none of them |
| `docs/cover.png`, `screenshot.png` | the chibi Monika in the corner is `assets/monika-sticker-calm.png`, scaled up by `cover.sh`. The rest of the image is screenshots of this theme |

The other images in `docs/` are screenshots of this theme in my own Obsidian, most of them of the notes in `docs/sample-vault/`, which are mine

Use here follows [Team Salvato's IP guidelines](https://teamsalvato.com/ip-guidelines): this is non-commercial fan content, nothing containing official assets is sold, and no claim of affiliation is made. If you reuse any of it, the same conditions apply to you

Team Salvato reserves the right to act on copyright or trademark infringement; nothing here grants a licence to their intellectual property

## Fonts

| Path | Font | Author | Licence |
| --- | --- | --- | --- |
| `vendor/fonts/Nunito.woff2`, `vendor/fonts/Nunito-Italic.woff2` | [Nunito](https://github.com/googlefonts/nunito) | The Nunito Project Authors | [SIL OFL 1.1](vendor/fonts/Nunito-LICENSE.txt) |
| `vendor/fonts/DepartureMono-Regular.woff2` | [Departure Mono](https://github.com/rektdeckard/departure-mono) | Helena Zhang | [SIL OFL 1.1](vendor/fonts/DepartureMono-LICENSE.txt) |
| `vendor/nerd/DepartureMonoNerdFontMono-Regular.woff2` | Departure Mono patched by [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) with their icon sets | Helena Zhang; the icon sets' authors | the font under [SIL OFL 1.1](vendor/nerd/DepartureMonoNerdFont-LICENSE.txt), each icon set under the licence the [Nerd Fonts README](vendor/nerd/DepartureMonoNerdFont-README.md) names |

The copies come from [ddlc-themes](https://github.com/rokokol/ddlc-themes), which takes them from their sources and packs them into WOFF2 without changing a glyph. `generate.sh` embeds Nunito and Departure Mono in `theme.css` under the names `DDLC Nunito` and `DDLC Departure Mono`, and `theme.css` carries both licences in its header. It embeds the Nerd Fonts face in `ddlc-nerd.css` alone, the optional snippet a release carries, under the name `DDLC Departure Mono Nerd`, and the snippet carries its licence and the Nerd Fonts README in its header

The headings name `Doki`, a font by 538Fonts from 2015, which is not part of the game. It is free for personal use only, so it is **not** shipped here. The theme asks for it by name, so headings use it only where it is already installed, and Nunito Black elsewhere

## Lucide

The task-state and copy icons are [Lucide](https://lucide.dev) icons, vendored under `vendor/lucide/` and embedded in `theme.css`. They are under the ISC licence, and some of them under the MIT licence of the Feather project. Both texts are in [`vendor/lucide/LICENSE`](vendor/lucide/LICENSE), and `theme.css` carries them in its header
