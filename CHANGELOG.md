# Changelog

All notable changes to this theme are documented in this file. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the theme uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html)

## Unreleased

### Added

- The theme carries its own fonts, so they need no installing, on a phone too: Nunito for prose and Departure Mono for code, both under the SIL Open Font License
- `ddlc-nerd.css`, an optional snippet in each release that draws code in Departure Mono with the Nerd Fonts icons. It carries the font, and it works with any theme

### Changed

- Prose is Nunito Medium, and bold is Nunito Black instead of the text's colour alone
- A heading, a callout's title and the properties' heading are Doki where it is installed, as before, and Nunito Black otherwise
- A link on the dark sheet is a lighter pink, so it no longer looks dim beside the white text
- The sheet rules a heading and a list item, one line along the foot of each, and leaves prose bare. Before, a rule under every line of a paragraph made dense text hard to read
- A callout's title has a thinner outline, as thin as a heading's, and more space between its lines, so a long title no longer closes up into one block
- The fold of `---` on the light sheet casts a faint plum shade instead of a grey one, which looked dirty on the white sheet

### Fixed

- A nested callout has its sticker on the margin, in the column of its parent's sticker, and in a narrow window on its own frame's corner. Before, the parent's content cut the sticker off, wholly or in part
- A nested callout's title is white inside its outline, as the parent's is. Before, it blended into the parent's pale ground and looked faded
- A formula in a large heading or in a callout's title is drawn plain in the lettering's colour. Before, the outline closed up its thin strokes and indices
- A bold word in a heading or in code keeps its letters clean. Before, the browser thickened the one-weight Doki and Departure Mono itself and smeared them

## [0.4.0] - 2026-10-09

### Added

- Each callout has a sticker in its type's colour on the margin, with the type's icon on it. The stickers are cut and stuck a little differently for each type. Where the margin is too narrow, the sticker sits on the callout's frame
- An `experiment` callout type, with a flask icon

### Changed

- A callout is centred: its title, its text, and its lists and tables as whole blocks
- A table in a callout has a pink head with dark text in both variants
- The arrow of a foldable callout is darker and heavier

### Fixed

- A link in a callout's title keeps the title's white letters
- In the dark variant, a done task in a callout is readable

## [0.3.0] - 2026-10-08

### Changed

- The theme takes its shared colour roles from [ddlc-themes](https://github.com/rokokol/ddlc-themes), so the text, links, borders, the pop-up, the board, the tape and the code window match the DDLC web pages and reports. The theme looks the same, except for the next entry
- In a code block, the `important` token is pink (`natsuki`) instead of red (`bow`). The red read at 2.8:1 on the window's dark ground

## [0.2.0] - 2026-10-08

### Added

- `ddlc-still.css`, an optional snippet in each release that stops the drift of the polka-dot background to save power

### Fixed

- A switch that is off is grey, so it no longer looks like one that is on

## [0.1.1] - 2026-10-08

### Fixed

- The polka-dot background drifts again while `ddlc-stickers.css` is on. The snippet replaced the background's animation with its own
- A link in a large heading keeps the heading's white letters. Before, the link filled them with the outline's colour and the word became unreadable
- The girls of `ddlc-stickers.css` walk smoothly, without small jerks

## [0.1.0] - 2026-10-08

### Added

- Light and dark variants in the Doki Doki Literature Club colours, taken from ddlc-palette
- A drifting polka-dot background, and the note written on a ruled poem sheet
- Callouts drawn as the game's "Just Monika." pop-up, one look for every callout type
- Properties on a signboard of their own, quotes as notes taped onto the sheet, and `---` as the fold of an exercise book
- Code blocks as small terminal windows in the kitty and nvim colours, with the language and a copy button in the title bar and a block cursor in Live Preview
- Icons for the task states `/ - > < ? ! * " l b i S I p c f k w u d`
- `ddlc-stickers.css`, an optional snippet in each release: the four club members walk along the foot of an empty tab

[0.2.0]: https://github.com/rokokol/ddlc-obsidian-theme/releases/tag/0.2.0
[0.1.1]: https://github.com/rokokol/ddlc-obsidian-theme/releases/tag/0.1.1
[0.1.0]: https://github.com/rokokol/ddlc-obsidian-theme/releases/tag/0.1.0
