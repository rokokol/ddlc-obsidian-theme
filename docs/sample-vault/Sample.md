---
tags:
  - sample
---
# The club's notebook

Plain text with [[Another note]], **bold**, *italics*, ==a highlight==, `inline code` and an external [link](https://ddlc.moe). Formula $E[X] = \sum_i x_i p_i$ inline

## This week's poems

> [!note] Monika
> Just Monika. A callout looks like the game's dialogue box, and its title like a name tag

> [!tip] Sayori
> A tip with **bold** inside and a list:
> - one
> - two

> [!warning]- Folded Yuri
> Hidden content

> [!danger] Natsuki
> An error

### A table

| Member  | Poems | Tea |
| ------- | ----- | --- |
| Sayori  | 12    | 4   |
| Natsuki | 9     | 7   |
| Yuri    | 15    | 2   |

#### Code

```python
import matplotlib.pyplot as plt

plt.style.use("ddlc")  # a code block on its own ground


class Member:
    def __init__(self, name: str, poems: int = 0) -> None:
        self.name = name
        self.poems = poems

    def poem(self) -> str:
        return f"{self.name} wrote {self.poems} poems"


for girl in [Member("Sayori", 12), Member("Yuri", 15)]:
    print(girl.poem())
```

```bash
#!/usr/bin/env bash
set -euo pipefail
for f in "$HOME"/poems/*.txt; do
  [[ -s "$f" ]] && printf '%s\n' "$(wc -l <"$f") lines in $f"
done
```

```nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [ obsidian ];
  programs.git.enable = true; # just monika
}
```

```js
const club = ["Sayori", "Natsuki", "Yuri"];
club.forEach((name, i) => console.log(`${i}: ${name}`));
```

```
plain block without a language
```

> The quote of the week, about the depth and the strangeness of the sea
> Just Monika

- [ ] Write a poem
- [x] Come to the club
- [/] Half done
- [-] Cancelled
- [>] Moved on
- [<] Scheduled
- [?] A question
- [!] Important
- [*] A star
- ["] A quote
- [l] A place
- [b] A bookmark
- [i] Information
- [S] Money
- [I] An idea
- [p] For
- [c] Against
- [f] Fire
- [k] A key
- [w] A win
- [u] Up
- [d] Down

1. The first item
2. The second item

---

$$
P(A \mid B) = \frac{P(B \mid A) P(A)}{P(B)}
$$

##### Fifth level
###### Sixth level
