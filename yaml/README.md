This directory contains source YAML files for color schemes.

## Theme naming

Name the file exactly as the theme should be displayed. Use the human-readable
name — spaces, capitalization, and punctuation are all fine.

- Good: `Catppuccin Mocha.yml`, `Black Metal (Mayhem).yml`
- Avoid: `Catppuccin_Mocha.yml`, `black-metal-mayhem.yml`

Do not slugify filenames or replace spaces with underscores. Some older themes
use underscores in filenames; that pattern is legacy — do not copy it for new
contributions.

The optional `name:` field must match the filename if you include it. When the
filename is already the display name, you can omit `name:`.

```yaml
# yaml/Catppuccin Mocha.yml
name: "Catppuccin Mocha"   # optional when it matches the filename
color_01: "#..."
```

Quote theme names in shell commands when they contain spaces:

```sh
python3 tools/gen.py -s "Catppuccin Mocha"
```

Generated outputs use this name as-is. Individual format templates may derive
slug variants (e.g. dashes instead of spaces) for targets that require them —
contributors do not need to do this manually.

If a file is specified here, these specifications override
those that would be specified in the similarly named `itermscheme`
file.

The YAML format is an extension of the YAML format
used by [Gogh](https://github.com/Gogh-Co/Gogh/),
with the optional extra keys:

* `badge`
* `bold` (defaults to `foreground`)
* `cursor_guide` (defaults to `cursor`)
* `cursor_text` (defaults to `foreground`)
* `link`
* `selection_text` (defaults to `background`)
* `selection` (defaults to `foreground`)
* `tab`
* `underline`
