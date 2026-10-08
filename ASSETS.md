# Assets and third-party content

`LICENSE` (MIT) covers the **code** in this repository: `src/ddlc.css`, `generate.sh`, `check.sh` and the Nix expression. It does **not** cover the colours, which are Team Salvato's, or the icons, which are Lucide's

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
| `docs/cover.png`, `screenshot.png` | the chibi Monika in the corner is `images/sticker_m.png` from [ddlc.moe](https://ddlc.moe/), scaled up. The rest of the image is screenshots of this theme |

The other images in `docs/` are screenshots of this theme in my own Obsidian

The `Doki` font family is Team Salvato's and is **not** shipped here. The theme asks for it by name, so headings use it only where it is already installed

Use here follows [Team Salvato's IP guidelines](https://teamsalvato.com/ip-guidelines): this is non-commercial fan content, nothing containing official assets is sold, and no claim of affiliation is made. If you reuse any of it, the same conditions apply to you

Team Salvato reserves the right to act on copyright or trademark infringement; nothing here grants a licence to their intellectual property

## Lucide

The task-state and copy icons are [Lucide](https://lucide.dev) icons, vendored under `vendor/lucide/` and embedded in `theme.css`. They are under the ISC licence, and some of them under the MIT licence of the Feather project. Both texts are in [`vendor/lucide/LICENSE`](vendor/lucide/LICENSE), and `theme.css` carries them in its header
