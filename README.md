## Ghostty

As of the release of Ghostty 1.2.0 the bundled themes have been updated. Some theme names have changed, popular examples:

```
catppuccin-mocha -> Catppuccin Mocha
rose-pine -> Rose Pine
```

If you receieve a theme not found error on Ghostty startup, verify the new theme name with `ghostty +list-themes`.

# iTerm Color Schemes

- [Intro](#intro)
- [Installation Instructions](#installation-instructions)
- [Contribute](#contribute)
- [Screenshots](#screenshots)
- [Credits](#credits)
- [Extra](#extra)
  - [Previewing color schemes](#previewing-color-schemes)
  - [X11 Installation](#x11-installation)
  - [Konsole color schemes](#konsole-color-schemes)
  - [Terminator color schemes](#terminator-color-schemes)
  - [Mac OS Terminal color schemes](#terminal-color-schemes)
  - [PuTTY color schemes](#putty-color-schemes)
  - [Xfce Terminal color schemes](#xfce-terminal-color-schemes)
  - [FreeBSD vt(4) color schemes](#freebsd-vt-color-schemes)
  - [MobaXterm color schemes](#mobaxterm-color-schemes)
  - [LXTerminal color schemes](#lxterminal-color-schemes)
  - [Visual Studio Code color schemes](#visual-studio-code-color-schemes)
  - [Windows Terminal color schemes](#windows-terminal-color-schemes)
  - [Alacritty color schemes](#alacritty-color-schemes)
  - [Ghostty color schemes](#ghostty-color-schemes)
  - [Termux color schemes](#termux-color-schemes)
  - [Generic color schemes](#generic-color-schemes)

## Intro

This is a set of color schemes for iTerm (aka iTerm2). It also includes ports to Terminal, Konsole, PuTTY, Xresources, XRDB, Remmina, Termite, XFCE, Tilda, FreeBSD VT, Terminator, Kitty, Ghostty, MobaXterm, LXTerminal, Microsoft's Windows Terminal, Visual Studio, Alacritty

Screenshots below and in the [screenshots](screenshots/) directory.

## Installation Instructions

There are 3 ways to install an iTerm theme:

- Direct way via keyboard shortcut:

  - Launch iTerm 2. Get the latest version at <a href="http://www.iterm2.com">iterm2.com</a>
  - Type CMD+i (⌘+i)
  - Navigate to **Colors** tab
  - Click on **Color Presets**
  - Click on **Import**
  - Click on the **schemes** folder
  - Select the **.itermcolors** profiles you would like to import
  - Click on **Color Presets** and choose a color scheme

- Via iTerm preferences (go to the same configuration location as above):

  - Launch iTerm 2. Get the latest version at <a href="http://www.iterm2.com">iterm2.com</a>
  - Click on **iTerm2** menu title
  - Select **Preferences...** option
  - Select **Profiles**
  - Navigate to **Colors** tab
  - Click on **Color Presets**
  - Click on **Import**
  - Select the .itermcolors file(s) of the [schemes](schemes/) you'd like to use \* Click on **Color Presets** and choose a color scheme

- Via Bash script

  - Launch iTerm 2. Get the latest version at <a href="http://www.iterm2.com">iterm2.com</a>
  - Run the following command:

  ```sh
  # Import all color schemes
  tools/import-scheme.sh schemes/*

  # Import all color schemes (verbose mode)
  tools/import-scheme.sh -v schemes/*

  # Import specific color schemes (quotations are needed for schemes with spaces in name)
  tools/import-scheme.sh 'schemes/SpaceGray Eighties.itermcolors' # by file path
  tools/import-scheme.sh 'SpaceGray Eighties'       # by scheme name
  tools/import-scheme.sh Molokai 'SpaceGray Eighties'     # import multiple
  ```

  - Restart iTerm 2. (Need to quit iTerm 2 to reload the configuration file.)

## Contribute

### Using Docker

If docker is installed, the script `generate-all.sh` will do most of the
steps described in [Prerequisits](#prerequisits), except for the instructions
related to `pyenv` as this is not required in a docker container dedicated to
generating the required files.

With docker, there is no need to install python and its dependencies on your
computer.

The remaining manual tasks are to update `README.md` to include your theme and
screenshot, and to update `CREDITS.md` to credit yourself for your contribution.

#### Debugging using Docker

In cases where new tools have to be tested, `./generate-all.sh debug` will start
an interactive terminal session inside the container.

### Prerequisites

1. For convenient work with generation scripts, it is recommended to install [pyenv](https://github.com/pyenv/pyenv).
2. Run `pyenv install` inside project folder to install python version from `.python-version` file.
3. Run `pip install -r requirements.txt` to install the project dependencies.

### How to add new theme

Have a great theme? Send it to me via a Pull Request!

#### Have an iTerm theme?

1. Get your theme's`.itermcolors` file.
   - Launch iTerm 2
   - Type CMD+i (⌘+i)
   - Navigate to **Colors** tab
   - Click on **Color Presets**
   - Click on **Export**
   - Save the .itermcolors file
2. Put your theme file into `/schemes/`
   - `mv <your-itermcolors-file> schemes/`

#### Have a theme in another format?

1. Convert it to the YAML format specified in `yaml/README.md`.
   This is an extension of the format supported by the [Gogh](https://github.com/Gogh-Co/Gogh/) project.
   - If it helps, you can use `tools/kitty_to_yaml.py` and `tools/ghostty_to_yaml.py`.
     These tools accept configuration file streamed into stdin, and output a YAML fragment to stdout.
2. Put the YAML file in `yaml/`, with the `.yml` extension.

#### Test your theme

1. Generate other formats for your theme using the `gen.py` script.
   - `python3 tools/gen.py -s <YourTheme>`
2. Generate a screenshot of your theme using the `screenshot_gen` tool.
   - `pushd tools && python3 -m screenshot_gen && popd`. This will generate new screenshots where they are missing.
   - If you have `oxipng` or `zopflipng` installed, the screenshot will be optimized for you.

#### Update `CREDITS.md` (optional)

1. Update `CREDITS.md` to credit yourself for your contribution.

### How to add new template

Do you want to convert existing iTerm themes to themes for your favorite terminal/editor/etc?

1. Get config file from your terminal/editor/etc.
2. Change actual colors in config to template placeholders from the list below.

```
  {{ Background_Color }}
  {{ Bold_Color }}
  {{ Cursor_Color }}
  {{ Cursor_Text_Color }}
  {{ Foreground_Color }}
  {{ Selected_Text_Color }}
  {{ Selection_Color }}
  {{ Ansi_0_Color }} // black
  {{ Ansi_1_Color }} // red
  {{ Ansi_2_Color }} // green
  {{ Ansi_3_Color }} // yellow
  {{ Ansi_4_Color }} // blue
  {{ Ansi_5_Color }} // magenta
  {{ Ansi_6_Color }} // cyan
  {{ Ansi_7_Color }} // white
  {{ Ansi_8_Color }} // bright black
  {{ Ansi_9_Color }} // bright red
  {{ Ansi_10_Color }} // bright green
  {{ Ansi_11_Color }} // bright yellow
  {{ Ansi_12_Color }} // bright blue
  {{ Ansi_13_Color }} // bright magenta
  {{ Ansi_14_Color }} // bright cyan
  {{ Ansi_15_Color }} // bright white

  Each color has these fields:
 - {{ Background_Color.hex }} for hex representation
 - {{ Background_Color.rgb }} for rgb representation as a "(r, g, b)" string
 - {{ Backgroun_Color.guint16 }} for guint16 representation

  Also you have access to this metadata fields:
 - {{ Guint16_Palette }} with a string containing all ansi colors as guint16 values
 - {{ Dark_Theme }} which contains a sign that the theme is dark
```

3. If you need a new value type for color, add it too `tools/converter.py`
4. Put your template file into `tool/templates`. A folder with schemas will be created based on the filename. And the file extension will remain with all generated ones. Example: `editor.ext` file will generate schemas as `editor/scheme_name.ext`
5. Generate all existing themes for all templates `cd tools/ && ./gen.py`. Or, if you only want to generate schemas for your template, you can use the `-t` flag.

- `./gen.py -t kitty`

6. If in the process you had to add new dependencies or update the version of python, do not forget to indicate this in `requirements.txt` or `.python-version`.

<!-- SCREENSHOTS_BEGIN -->

## Screenshots

The screenshots are categorized.

- [Dark Themes](#darkthemes)
- [Light Themes](#lightthemes)

### Dark Themes<a name="darkthemes"><a/>

### 0x96f

![Screenshot](/screenshots/0x96f.png)

### 12-bit Rainbow

![Screenshot](/screenshots/12-bit-rainbow.png)

### 3024 Night

![Screenshot](/screenshots/3024-night.png)

### Aardvark Blue

![Screenshot](/screenshots/aardvark-blue.png)

### Abernathy

![Screenshot](/screenshots/abernathy.png)

### Adventure Time

![Screenshot](/screenshots/adventure-time.png)

### Adventure

![Screenshot](/screenshots/adventure.png)

### Adwaita Dark

![Screenshot](/screenshots/adwaita-dark.png)

### Afterglow

![Screenshot](/screenshots/afterglow.png)

### Alien Blood

![Screenshot](/screenshots/alien-blood.png)

### Andromeda

![Screenshot](/screenshots/andromeda.png)

### Apple Classic

![Screenshot](/screenshots/apple-classic.png)

### Apple System Colors

![Screenshot](/screenshots/apple-system-colors.png)

### Arcoiris

![Screenshot](/screenshots/arcoiris.png)

### Ardoise

![Screenshot](/screenshots/ardoise.png)

### Argonaut

![Screenshot](/screenshots/argonaut.png)

### Arthur

![Screenshot](/screenshots/arthur.png)

### Atelier Sulphurpool

![Screenshot](/screenshots/atelier-sulphurpool.png)

### Atom One Dark

![Screenshot](/screenshots/atom-one-dark.png)

### Atom

![Screenshot](/screenshots/atom.png)

### Aura

![Screenshot](/screenshots/aura.png)

### Aurora

![Screenshot](/screenshots/aurora.png)

### Ayu Mirage

![Screenshot](/screenshots/ayu-mirage.png)

### Ayu

![Screenshot](/screenshots/ayu.png)

### Banana Blueberry

![Screenshot](/screenshots/banana-blueberry.png)

### Batman

![Screenshot](/screenshots/batman.png)

### Belafonte Night

![Screenshot](/screenshots/belafonte-night.png)

### Birds Of Paradise

![Screenshot](/screenshots/birds-of-paradise.png)

### Black Metal (Bathory)

![Screenshot](/screenshots/black-metal-bathory.png)

### Black Metal (Burzum)

![Screenshot](/screenshots/black-metal-burzum.png)

### Black Metal (Dark Funeral)

![Screenshot](/screenshots/black-metal-dark-funeral.png)

### Black Metal (Gorgoroth)

![Screenshot](/screenshots/black-metal-gorgoroth.png)

### Black Metal (Immortal)

![Screenshot](/screenshots/black-metal-immortal.png)

### Black Metal (Khold)

![Screenshot](/screenshots/black-metal-khold.png)

### Black Metal (Marduk)

![Screenshot](/screenshots/black-metal-marduk.png)

### Black Metal (Mayhem)

![Screenshot](/screenshots/black-metal-mayhem.png)

### Black Metal (Nile)

![Screenshot](/screenshots/black-metal-nile.png)

### Black Metal (Venom)

![Screenshot](/screenshots/black-metal-venom.png)

### Black Metal

![Screenshot](/screenshots/black-metal.png)

### Blazer

![Screenshot](/screenshots/blazer.png)

### Blue Berry Pie

![Screenshot](/screenshots/blue-berry-pie.png)

### Blue Dolphin

![Screenshot](/screenshots/blue-dolphin.png)

### Blue Matrix

![Screenshot](/screenshots/blue-matrix.png)

### Bluloco Dark

![Screenshot](/screenshots/bluloco-dark.png)

### Borland

![Screenshot](/screenshots/borland.png)

### Box

![Screenshot](/screenshots/box.png)

### Breeze

![Screenshot](/screenshots/breeze.png)

### Bright Lights

![Screenshot](/screenshots/bright-lights.png)

### Broadcast

![Screenshot](/screenshots/broadcast.png)

### Brogrammer

![Screenshot](/screenshots/brogrammer.png)

### Builtin Dark

![Screenshot](/screenshots/builtin-dark.png)

### Builtin Pastel Dark

![Screenshot](/screenshots/builtin-pastel-dark.png)

### Builtin Solarized Dark

![Screenshot](/screenshots/builtin-solarized-dark.png)

### Builtin Tango Dark

![Screenshot](/screenshots/builtin-tango-dark.png)

### C64

![Screenshot](/screenshots/c64.png)

### Calamity

![Screenshot](/screenshots/calamity.png)

### Carbonfox

![Screenshot](/screenshots/carbonfox.png)

### Catppuccin Frappe

![Screenshot](/screenshots/catppuccin-frappe.png)

### Catppuccin Macchiato

![Screenshot](/screenshots/catppuccin-macchiato.png)

### Catppuccin Mocha

![Screenshot](/screenshots/catppuccin-mocha.png)

### CGA

![Screenshot](/screenshots/cga.png)

### Chalk

![Screenshot](/screenshots/chalk.png)

### Chalkboard

![Screenshot](/screenshots/chalkboard.png)

### Challenger Deep

![Screenshot](/screenshots/challenger-deep.png)

### Chester

![Screenshot](/screenshots/chester.png)

### Ciapre

![Screenshot](/screenshots/ciapre.png)

### Citruszest

![Screenshot](/screenshots/citruszest.png)

### Cobalt Neon

![Screenshot](/screenshots/cobalt-neon.png)

### Cobalt Next Dark

![Screenshot](/screenshots/cobalt-next-dark.png)

### Cobalt Next Minimal

![Screenshot](/screenshots/cobalt-next-minimal.png)

### Cobalt Next

![Screenshot](/screenshots/cobalt-next.png)

### Cobalt2

![Screenshot](/screenshots/cobalt2.png)

### Crayon Pony Fish

![Screenshot](/screenshots/crayon-pony-fish.png)

### Cursor Dark

![Screenshot](/screenshots/cursor-dark.png)

### Cutie Pro

![Screenshot](/screenshots/cutie-pro.png)

### Cyberdyne

![Screenshot](/screenshots/cyberdyne.png)

### Cyberpunk Scarlet Protocol

![Screenshot](/screenshots/cyberpunk-scarlet-protocol.png)

### Cyberpunk

![Screenshot](/screenshots/cyberpunk.png)

### Dark Modern

![Screenshot](/screenshots/dark-modern.png)

### Dark Pastel

![Screenshot](/screenshots/dark-pastel.png)

### Dark+

![Screenshot](/screenshots/dark.png)

### Darkermatrix

![Screenshot](/screenshots/darkermatrix.png)

### Darkmatrix

![Screenshot](/screenshots/darkmatrix.png)

### Darkside

![Screenshot](/screenshots/darkside.png)

### Deep

![Screenshot](/screenshots/deep.png)

### Desert

![Screenshot](/screenshots/desert.png)

### Detuned

![Screenshot](/screenshots/detuned.png)

### Dimidium

![Screenshot](/screenshots/dimidium.png)

### Dimmed Monokai

![Screenshot](/screenshots/dimmed-monokai.png)

### Django Reborn Again

![Screenshot](/screenshots/django-reborn-again.png)

### Django Smooth

![Screenshot](/screenshots/django-smooth.png)

### Django

![Screenshot](/screenshots/django.png)

### Doom One

![Screenshot](/screenshots/doom-one.png)

### Doom Peacock

![Screenshot](/screenshots/doom-peacock.png)

### Dot Gov

![Screenshot](/screenshots/dot-gov.png)

### Dracula+

![Screenshot](/screenshots/dracula.png)

### Dracula

![Screenshot](/screenshots/dracula.png)

### Duckbones

![Screenshot](/screenshots/duckbones.png)

### Duotone Dark

![Screenshot](/screenshots/duotone-dark.png)

### Duskfox

![Screenshot](/screenshots/duskfox.png)

### Earthsong

![Screenshot](/screenshots/earthsong.png)

### Electron Highlighter

![Screenshot](/screenshots/electron-highlighter.png)

### Elegant

![Screenshot](/screenshots/elegant.png)

### Elemental

![Screenshot](/screenshots/elemental.png)

### Elementary

![Screenshot](/screenshots/elementary.png)

### Embark

![Screenshot](/screenshots/embark.png)

### Embers Dark

![Screenshot](/screenshots/embers-dark.png)

### ENCOM

![Screenshot](/screenshots/encom.png)

### Espresso Libre

![Screenshot](/screenshots/espresso-libre.png)

### Espresso

![Screenshot](/screenshots/espresso.png)

### Everblush

![Screenshot](/screenshots/everblush.png)

### Everforest Dark Hard

![Screenshot](/screenshots/everforest-dark-hard.png)

### Fahrenheit

![Screenshot](/screenshots/fahrenheit.png)

### Fairyfloss

![Screenshot](/screenshots/fairyfloss.png)

### Farmhouse Dark

![Screenshot](/screenshots/farmhouse-dark.png)

### Fideloper

![Screenshot](/screenshots/fideloper.png)

### Firefly Traditional

![Screenshot](/screenshots/firefly-traditional.png)

### Firefox Dev

![Screenshot](/screenshots/firefox-dev.png)

### Firewatch

![Screenshot](/screenshots/firewatch.png)

### Fish Tank

![Screenshot](/screenshots/fish-tank.png)

### Flat

![Screenshot](/screenshots/flat.png)

### Flatland

![Screenshot](/screenshots/flatland.png)

### Flexoki Dark

![Screenshot](/screenshots/flexoki-dark.png)

### Floraverse

![Screenshot](/screenshots/floraverse.png)

### Forest Blue

![Screenshot](/screenshots/forest-blue.png)

### Framer

![Screenshot](/screenshots/framer.png)

### Front End Delight

![Screenshot](/screenshots/front-end-delight.png)

### Fun Forrest

![Screenshot](/screenshots/fun-forrest.png)

### Galaxy

![Screenshot](/screenshots/galaxy.png)

### Galizur

![Screenshot](/screenshots/galizur.png)

### Ghostty Default Style Dark

![Screenshot](/screenshots/ghostty-default-style-dark.png)

### GitHub Dark Colorblind

![Screenshot](/screenshots/github-dark-colorblind.png)

### GitHub Dark Default

![Screenshot](/screenshots/github-dark-default.png)

### GitHub Dark Dimmed

![Screenshot](/screenshots/github-dark-dimmed.png)

### GitHub Dark High Contrast

![Screenshot](/screenshots/github-dark-high-contrast.png)

### GitHub Dark

![Screenshot](/screenshots/github-dark.png)

### GitLab Dark Grey

![Screenshot](/screenshots/gitlab-dark-grey.png)

### GitLab Dark

![Screenshot](/screenshots/gitlab-dark.png)

### Glacier

![Screenshot](/screenshots/glacier.png)

### Grape

![Screenshot](/screenshots/grape.png)

### Grass

![Screenshot](/screenshots/grass.png)

### Grey Green

![Screenshot](/screenshots/grey-green.png)

### Gruber Darker

![Screenshot](/screenshots/gruber-darker.png)

### Gruvbox Dark Hard

![Screenshot](/screenshots/gruvbox-dark-hard.png)

### Gruvbox Dark

![Screenshot](/screenshots/gruvbox-dark.png)

### Gruvbox Material Dark

![Screenshot](/screenshots/gruvbox-material-dark.png)

### Gruvbox Material

![Screenshot](/screenshots/gruvbox-material.png)

### Guezwhoz

![Screenshot](/screenshots/guezwhoz.png)

### Hacktober

![Screenshot](/screenshots/hacktober.png)

### Hardcore

![Screenshot](/screenshots/hardcore.png)

### Harper

![Screenshot](/screenshots/harper.png)

### Havn Skumring

![Screenshot](/screenshots/havn-skumring.png)

### HaX0R Blue

![Screenshot](/screenshots/hax0r-blue.png)

### HaX0R Gr33N

![Screenshot](/screenshots/hax0r-gr33n.png)

### HaX0R R3D

![Screenshot](/screenshots/hax0r-r3d.png)

### Heeler

![Screenshot](/screenshots/heeler.png)

### Highway

![Screenshot](/screenshots/highway.png)

### Hipster Green

![Screenshot](/screenshots/hipster-green.png)

### Hivacruz

![Screenshot](/screenshots/hivacruz.png)

### Homebrew

![Screenshot](/screenshots/homebrew.png)

### Hopscotch.256

![Screenshot](/screenshots/hopscotch256.png)

### Hopscotch

![Screenshot](/screenshots/hopscotch.png)

### Horizon

![Screenshot](/screenshots/horizon.png)

### Hot Dog Stand (Mustard)

![Screenshot](/screenshots/hot-dog-stand-mustard.png)

### Hurtado

![Screenshot](/screenshots/hurtado.png)

### Hybrid

![Screenshot](/screenshots/hybrid.png)

### IBM 5153 CGA (Black)

![Screenshot](/screenshots/ibm-5153-cga-black.png)

### IBM 5153 CGA

![Screenshot](/screenshots/ibm-5153-cga.png)

### IC Green PPL

![Screenshot](/screenshots/ic-green-ppl.png)

### IC Orange PPL

![Screenshot](/screenshots/ic-orange-ppl.png)

### Iceberg Dark

![Screenshot](/screenshots/iceberg-dark.png)

### Idea

![Screenshot](/screenshots/idea.png)

### Idle Toes

![Screenshot](/screenshots/idle-toes.png)

### IR Black

![Screenshot](/screenshots/ir-black.png)

### IRIX Console

![Screenshot](/screenshots/irix-console.png)

### IRIX Terminal

![Screenshot](/screenshots/irix-terminal.png)

### iTerm2 Dark Background

![Screenshot](/screenshots/iterm2-dark-background.png)

### iTerm2 Default

![Screenshot](/screenshots/iterm2-default.png)

### iTerm2 Pastel Dark Background

![Screenshot](/screenshots/iterm2-pastel-dark-background.png)

### iTerm2 Smoooooth

![Screenshot](/screenshots/iterm2-smoooooth.png)

### iTerm2 Solarized Dark

![Screenshot](/screenshots/iterm2-solarized-dark.png)

### iTerm2 Tango Dark

![Screenshot](/screenshots/iterm2-tango-dark.png)

### Jackie Brown

![Screenshot](/screenshots/jackie-brown.png)

### Japanesque

![Screenshot](/screenshots/japanesque.png)

### Jellybeans

![Screenshot](/screenshots/jellybeans.png)

### JetBrains Darcula

![Screenshot](/screenshots/jetbrains-darcula.png)

### Jubi

![Screenshot](/screenshots/jubi.png)

### Kanagawa Dragon

![Screenshot](/screenshots/kanagawa-dragon.png)

### Kanagawa Wave

![Screenshot](/screenshots/kanagawa-wave.png)

### Kanagawabones

![Screenshot](/screenshots/kanagawabones.png)

### Kibble

![Screenshot](/screenshots/kibble.png)

### Kitty Default

![Screenshot](/screenshots/kitty-default.png)

### Kitty Low Contrast

![Screenshot](/screenshots/kitty-low-contrast.png)

### Kolorit

![Screenshot](/screenshots/kolorit.png)

### Konsolas

![Screenshot](/screenshots/konsolas.png)

### Kurokula

![Screenshot](/screenshots/kurokula.png)

### Lab Fox

![Screenshot](/screenshots/lab-fox.png)

### Laser

![Screenshot](/screenshots/laser.png)

### Later This Evening

![Screenshot](/screenshots/later-this-evening.png)

### Lavandula

![Screenshot](/screenshots/lavandula.png)

### Liquid Carbon Transparent

![Screenshot](/screenshots/liquid-carbon-transparent.png)

### Liquid Carbon

![Screenshot](/screenshots/liquid-carbon.png)

### Lovelace

![Screenshot](/screenshots/lovelace.png)

### Mariana

![Screenshot](/screenshots/mariana.png)

### Material Dark

![Screenshot](/screenshots/material-dark.png)

### Material Darker

![Screenshot](/screenshots/material-darker.png)

### Material Design Colors

![Screenshot](/screenshots/material-design-colors.png)

### Material Ocean

![Screenshot](/screenshots/material-ocean.png)

### Mathias

![Screenshot](/screenshots/mathias.png)

### Matrix

![Screenshot](/screenshots/matrix.png)

### Matte Black

![Screenshot](/screenshots/matte-black.png)

### Medallion

![Screenshot](/screenshots/medallion.png)

### Melange Dark

![Screenshot](/screenshots/melange-dark.png)

### Mellifluous

![Screenshot](/screenshots/mellifluous.png)

### Mellow

![Screenshot](/screenshots/mellow.png)

### Miasma

![Screenshot](/screenshots/miasma.png)

### Midnight In Mojave

![Screenshot](/screenshots/midnight-in-mojave.png)

### Mirage

![Screenshot](/screenshots/mirage.png)

### Misterioso

![Screenshot](/screenshots/misterioso.png)

### Molokai

![Screenshot](/screenshots/molokai.png)

### Mona Lisa

![Screenshot](/screenshots/mona-lisa.png)

### Monokai Classic

![Screenshot](/screenshots/monokai-classic.png)

### Monokai Pro Machine

![Screenshot](/screenshots/monokai-pro-machine.png)

### Monokai Pro Octagon

![Screenshot](/screenshots/monokai-pro-octagon.png)

### Monokai Pro Ristretto

![Screenshot](/screenshots/monokai-pro-ristretto.png)

### Monokai Pro Spectrum

![Screenshot](/screenshots/monokai-pro-spectrum.png)

### Monokai Pro

![Screenshot](/screenshots/monokai-pro.png)

### Monokai Remastered

![Screenshot](/screenshots/monokai-remastered.png)

### Monokai Soda

![Screenshot](/screenshots/monokai-soda.png)

### Monokai Vivid

![Screenshot](/screenshots/monokai-vivid.png)

### Moonfly

![Screenshot](/screenshots/moonfly.png)

### N0Tch2K

![Screenshot](/screenshots/n0tch2k.png)

### Neobones Dark

![Screenshot](/screenshots/neobones-dark.png)

### Neon

![Screenshot](/screenshots/neon.png)

### Neopolitan

![Screenshot](/screenshots/neopolitan.png)

### Neutron

![Screenshot](/screenshots/neutron.png)

### Night Lion V1

![Screenshot](/screenshots/night-lion-v1.png)

### Night Lion V2

![Screenshot](/screenshots/night-lion-v2.png)

### Night Owl

![Screenshot](/screenshots/night-owl.png)

### Nightfox

![Screenshot](/screenshots/nightfox.png)

### Niji

![Screenshot](/screenshots/niji.png)

### Nocturnal Winter

![Screenshot](/screenshots/nocturnal-winter.png)

### Nord Wave

![Screenshot](/screenshots/nord-wave.png)

### Nord

![Screenshot](/screenshots/nord.png)

### Nordfox

![Screenshot](/screenshots/nordfox.png)

### Nvim Dark

![Screenshot](/screenshots/nvim-dark.png)

### Obsidian

![Screenshot](/screenshots/obsidian.png)

### Ocean

![Screenshot](/screenshots/ocean.png)

### Oceanic Material

![Screenshot](/screenshots/oceanic-material.png)

### Oceanic Next

![Screenshot](/screenshots/oceanic-next.png)

### Ollie

![Screenshot](/screenshots/ollie.png)

### One Double Dark

![Screenshot](/screenshots/one-double-dark.png)

### One Half Dark

![Screenshot](/screenshots/one-half-dark.png)

### Operator Mono Dark

![Screenshot](/screenshots/operator-mono-dark.png)

### Overnight Slumber

![Screenshot](/screenshots/overnight-slumber.png)

### Oxocarbon

![Screenshot](/screenshots/oxocarbon.png)

### Pale Night Hc

![Screenshot](/screenshots/pale-night-hc.png)

### Pandora

![Screenshot](/screenshots/pandora.png)

### Paraiso Dark

![Screenshot](/screenshots/paraiso-dark.png)

### Paul Millr

![Screenshot](/screenshots/paul-millr.png)

### Pencil Dark

![Screenshot](/screenshots/pencil-dark.png)

### Peppermint

![Screenshot](/screenshots/peppermint.png)

### Phala Green Dark

![Screenshot](/screenshots/phala-green-dark.png)

### Pnevma

![Screenshot](/screenshots/pnevma.png)

### Popping And Locking

![Screenshot](/screenshots/popping-and-locking.png)

### Powershell

![Screenshot](/screenshots/powershell.png)

### Pro

![Screenshot](/screenshots/pro.png)

### Purple Rain

![Screenshot](/screenshots/purple-rain.png)

### Purplepeter

![Screenshot](/screenshots/purplepeter.png)

### Rapture

![Screenshot](/screenshots/rapture.png)

### Raycast Dark

![Screenshot](/screenshots/raycast-dark.png)

### Rebecca

![Screenshot](/screenshots/rebecca.png)

### Red Alert

![Screenshot](/screenshots/red-alert.png)

### Red Planet

![Screenshot](/screenshots/red-planet.png)

### Red Sands

![Screenshot](/screenshots/red-sands.png)

### Relaxed

![Screenshot](/screenshots/relaxed.png)

### Retro Legends

![Screenshot](/screenshots/retro-legends.png)

### Retro

![Screenshot](/screenshots/retro.png)

### Rippedcasts

![Screenshot](/screenshots/rippedcasts.png)

### Rose Pine Moon

![Screenshot](/screenshots/rose-pine-moon.png)

### Rose Pine

![Screenshot](/screenshots/rose-pine.png)

### Rouge 2

![Screenshot](/screenshots/rouge-2.png)

### Royal

![Screenshot](/screenshots/royal.png)

### Ryuuko

![Screenshot](/screenshots/ryuuko.png)

### Sakura

![Screenshot](/screenshots/sakura.png)

### Scarlet Protocol

![Screenshot](/screenshots/scarlet-protocol.png)

### Sea Shells

![Screenshot](/screenshots/sea-shells.png)

### Seafoam Pastel

![Screenshot](/screenshots/seafoam-pastel.png)

### Selenized Dark

![Screenshot](/screenshots/selenized-dark.png)

### Seoulbones Dark

![Screenshot](/screenshots/seoulbones-dark.png)

### Seti

![Screenshot](/screenshots/seti.png)

### Shades Of Purple

![Screenshot](/screenshots/shades-of-purple.png)

### Shaman

![Screenshot](/screenshots/shaman.png)

### Slate

![Screenshot](/screenshots/slate.png)

### Sleepy Hollow

![Screenshot](/screenshots/sleepy-hollow.png)

### Smyck

![Screenshot](/screenshots/smyck.png)

### Snazzy Soft

![Screenshot](/screenshots/snazzy-soft.png)

### Snazzy

![Screenshot](/screenshots/snazzy.png)

### Soft Server

![Screenshot](/screenshots/soft-server.png)

### Solarized Darcula

![Screenshot](/screenshots/solarized-darcula.png)

### Solarized Dark Higher Contrast

![Screenshot](/screenshots/solarized-dark-higher-contrast.png)

### Solarized Dark Patched

![Screenshot](/screenshots/solarized-dark-patched.png)

### Solarized Osaka Night

![Screenshot](/screenshots/solarized-osaka-night.png)

### Sonokai

![Screenshot](/screenshots/sonokai.png)

### Spacedust

![Screenshot](/screenshots/spacedust.png)

### Spacegray Bright

![Screenshot](/screenshots/spacegray-bright.png)

### Spacegray Eighties Dull

![Screenshot](/screenshots/spacegray-eighties-dull.png)

### Spacegray Eighties

![Screenshot](/screenshots/spacegray-eighties.png)

### Spacegray

![Screenshot](/screenshots/spacegray.png)

### Spiderman

![Screenshot](/screenshots/spiderman.png)

### Square

![Screenshot](/screenshots/square.png)

### Squirrelsong Dark

![Screenshot](/screenshots/squirrelsong-dark.png)

### Srcery

![Screenshot](/screenshots/srcery.png)

### Starlight

![Screenshot](/screenshots/starlight.png)

### Sublette

![Screenshot](/screenshots/sublette.png)

### Subliminal

![Screenshot](/screenshots/subliminal.png)

### Sugarplum

![Screenshot](/screenshots/sugarplum.png)

### Sundried

![Screenshot](/screenshots/sundried.png)

### Symfonic

![Screenshot](/screenshots/symfonic.png)

### Synthwave Alpha

![Screenshot](/screenshots/synthwave-alpha.png)

### Synthwave Everything

![Screenshot](/screenshots/synthwave-everything.png)

### Synthwave

![Screenshot](/screenshots/synthwave.png)

### Tearout

![Screenshot](/screenshots/tearout.png)

### Teerb

![Screenshot](/screenshots/teerb.png)

### Terafox

![Screenshot](/screenshots/terafox.png)

### Terminal Basic Dark

![Screenshot](/screenshots/terminal-basic-dark.png)

### Thayer Bright

![Screenshot](/screenshots/thayer-bright.png)

### The Hulk

![Screenshot](/screenshots/the-hulk.png)

### Tinacious Design Dark

![Screenshot](/screenshots/tinacious-design-dark.png)

### TokyoNight Moon

![Screenshot](/screenshots/tokyonight-moon.png)

### TokyoNight Night

![Screenshot](/screenshots/tokyonight-night.png)

### TokyoNight Storm

![Screenshot](/screenshots/tokyonight-storm.png)

### TokyoNight

![Screenshot](/screenshots/tokyonight.png)

### Tomorrow Night Blue

![Screenshot](/screenshots/tomorrow-night-blue.png)

### Tomorrow Night Bright

![Screenshot](/screenshots/tomorrow-night-bright.png)

### Tomorrow Night Burns

![Screenshot](/screenshots/tomorrow-night-burns.png)

### Tomorrow Night Eighties

![Screenshot](/screenshots/tomorrow-night-eighties.png)

### Tomorrow Night

![Screenshot](/screenshots/tomorrow-night.png)

### Toy Chest

![Screenshot](/screenshots/toy-chest.png)

### Treehouse

![Screenshot](/screenshots/treehouse.png)

### Twilight

![Screenshot](/screenshots/twilight.png)

### Ubuntu

![Screenshot](/screenshots/ubuntu.png)

### Ultra Dark

![Screenshot](/screenshots/ultra-dark.png)

### Ultra Violent

![Screenshot](/screenshots/ultra-violent.png)

### Under The Sea

![Screenshot](/screenshots/under-the-sea.png)

### Urple

![Screenshot](/screenshots/urple.png)

### Vague

![Screenshot](/screenshots/vague.png)

### Vaughn

![Screenshot](/screenshots/vaughn.png)

### Vercel

![Screenshot](/screenshots/vercel.png)

### Vesper

![Screenshot](/screenshots/vesper.png)

### Vibrant Ink

![Screenshot](/screenshots/vibrant-ink.png)

### Violet Dark

![Screenshot](/screenshots/violet-dark.png)

### Violite

![Screenshot](/screenshots/violite.png)

### Warm Neon

![Screenshot](/screenshots/warm-neon.png)

### Wez

![Screenshot](/screenshots/wez.png)

### Whimsy

![Screenshot](/screenshots/whimsy.png)

### Wild Cherry

![Screenshot](/screenshots/wild-cherry.png)

### Wilmersdorf

![Screenshot](/screenshots/wilmersdorf.png)

### Wombat

![Screenshot](/screenshots/wombat.png)

### Wryan

![Screenshot](/screenshots/wryan.png)

### Xcode Dark hc

![Screenshot](/screenshots/xcode-dark-hc.png)

### Xcode Dark

![Screenshot](/screenshots/xcode-dark.png)

### Xcode WWDC

![Screenshot](/screenshots/xcode-wwdc.png)

### Zenbones Dark

![Screenshot](/screenshots/zenbones-dark.png)

### Zenburn

![Screenshot](/screenshots/zenburn.png)

### Zenburned

![Screenshot](/screenshots/zenburned.png)

### Zenwritten Dark

![Screenshot](/screenshots/zenwritten-dark.png)

### Light Themes<a name="lightthemes"><a/>

### 3024 Day

![Screenshot](/screenshots/3024-day.png)

### Adwaita

![Screenshot](/screenshots/adwaita.png)

### Alabaster

![Screenshot](/screenshots/alabaster.png)

### Apple System Colors Light

![Screenshot](/screenshots/apple-system-colors-light.png)

### Atom One Light

![Screenshot](/screenshots/atom-one-light.png)

### Ayu Light

![Screenshot](/screenshots/ayu-light.png)

### Belafonte Day

![Screenshot](/screenshots/belafonte-day.png)

### Bluloco Light

![Screenshot](/screenshots/bluloco-light.png)

### Breadog

![Screenshot](/screenshots/breadog.png)

### Builtin Light

![Screenshot](/screenshots/builtin-light.png)

### Builtin Solarized Light

![Screenshot](/screenshots/builtin-solarized-light.png)

### Builtin Tango Light

![Screenshot](/screenshots/builtin-tango-light.png)

### Catppuccin Latte

![Screenshot](/screenshots/catppuccin-latte.png)

### CLRS

![Screenshot](/screenshots/clrs.png)

### Coffee Theme

![Screenshot](/screenshots/coffee-theme.png)

### Dawnfox

![Screenshot](/screenshots/dawnfox.png)

### Dayfox

![Screenshot](/screenshots/dayfox.png)

### Everforest Light Med

![Screenshot](/screenshots/everforest-light-med.png)

### Farmhouse Light

![Screenshot](/screenshots/farmhouse-light.png)

### Flexoki Light

![Screenshot](/screenshots/flexoki-light.png)

### GitHub Light Colorblind

![Screenshot](/screenshots/github-light-colorblind.png)

### GitHub Light Default

![Screenshot](/screenshots/github-light-default.png)

### GitHub Light High Contrast

![Screenshot](/screenshots/github-light-high-contrast.png)

### GitHub

![Screenshot](/screenshots/github.png)

### GitLab Light

![Screenshot](/screenshots/gitlab-light.png)

### Gruvbox Light Hard

![Screenshot](/screenshots/gruvbox-light-hard.png)

### Gruvbox Light

![Screenshot](/screenshots/gruvbox-light.png)

### Gruvbox Material Light

![Screenshot](/screenshots/gruvbox-material-light.png)

### Havn Daggry

![Screenshot](/screenshots/havn-daggry.png)

### Horizon Bright

![Screenshot](/screenshots/horizon-bright.png)

### Hot Dog Stand

![Screenshot](/screenshots/hot-dog-stand.png)

### Iceberg Light

![Screenshot](/screenshots/iceberg-light.png)

### iTerm2 Light Background

![Screenshot](/screenshots/iterm2-light-background.png)

### iTerm2 Solarized Light

![Screenshot](/screenshots/iterm2-solarized-light.png)

### iTerm2 Tango Light

![Screenshot](/screenshots/iterm2-tango-light.png)

### Light Owl

![Screenshot](/screenshots/light-owl.png)

### Man Page

![Screenshot](/screenshots/man-page.png)

### Material

![Screenshot](/screenshots/material.png)

### Melange Light

![Screenshot](/screenshots/melange-light.png)

### Monokai Pro Light Sun

![Screenshot](/screenshots/monokai-pro-light-sun.png)

### Monokai Pro Light

![Screenshot](/screenshots/monokai-pro-light.png)

### Neobones Light

![Screenshot](/screenshots/neobones-light.png)

### Night Owlish Light

![Screenshot](/screenshots/night-owlish-light.png)

### Nord Light

![Screenshot](/screenshots/nord-light.png)

### Novel

![Screenshot](/screenshots/novel.png)

### Nvim Light

![Screenshot](/screenshots/nvim-light.png)

### One Double Light

![Screenshot](/screenshots/one-double-light.png)

### One Half Light

![Screenshot](/screenshots/one-half-light.png)

### Pencil Light

![Screenshot](/screenshots/pencil-light.png)

### Piatto Light

![Screenshot](/screenshots/piatto-light.png)

### Primary

![Screenshot](/screenshots/primary.png)

### Pro Light

![Screenshot](/screenshots/pro-light.png)

### Raycast Light

![Screenshot](/screenshots/raycast-light.png)

### Rose Pine Dawn

![Screenshot](/screenshots/rose-pine-dawn.png)

### Selenized Light

![Screenshot](/screenshots/selenized-light.png)

### Seoulbones Light

![Screenshot](/screenshots/seoulbones-light.png)

### Spring

![Screenshot](/screenshots/spring.png)

### Tango Adapted

![Screenshot](/screenshots/tango-adapted.png)

### Tango Half Adapted

![Screenshot](/screenshots/tango-half-adapted.png)

### Terminal Basic

![Screenshot](/screenshots/terminal-basic.png)

### Tinacious Design Light

![Screenshot](/screenshots/tinacious-design-light.png)

### TokyoNight Day

![Screenshot](/screenshots/tokyonight-day.png)

### Tomorrow

![Screenshot](/screenshots/tomorrow.png)

### Unikitty

![Screenshot](/screenshots/unikitty.png)

### Vimbones

![Screenshot](/screenshots/vimbones.png)

### Violet Light

![Screenshot](/screenshots/violet-light.png)

### Xcode Light hc

![Screenshot](/screenshots/xcode-light-hc.png)

### Xcode Light

![Screenshot](/screenshots/xcode-light.png)

### Zenbones Light

![Screenshot](/screenshots/zenbones-light.png)

### Zenbones

![Screenshot](/screenshots/zenbones.png)

### Zenwritten Light

![Screenshot](/screenshots/zenwritten-light.png)
<!-- SCREENSHOTS_END -->

## Credits

- The schemes [_Novel_](#novel), [_Espresso_](#espresso), [_Grass_](#grass), [_Homebrew_](#homebrew), [_Ocean_](#ocean), [_Pro_](#pro), [_Man Page_](#man-page), [_Red Sands_](#red-sands), and [_Terminal Basic_](#terminal-basic) are ports of the schemes of the same name included with the Mac Terminal application. All of Terminal's schemes have now been ported, with the exception of _Solid Colors_ (random backgrounds, which iTerm doesn't support) and _Aerogel_ (which is hideous).
- The schemes [_iTerm2 Default_](#iterm2-default), [_iTerm2 Dark Background_](#iterm2-dark-background), [_iTerm2 Light Background_](#iterm2-light-background), [_iTerm2 Pastel (Dark Background)_](#iterm2-pastel-dark-background), [_iTerm2 Smoooooth_](#iterm2-smoooooth), [_iTerm2 Solarized Dark_](#iterm2-solarized-dark), [_iTerm2 Solarized Light_](#iterm2-solarized-light), [_iTerm2 Tango Dark_](#iterm2-tango-dark), and [_iTerm2 Tango Light_](#iterm2-tango-light) are ports from the built-in color schemes of iTerm2 (current source is iTerm2 v3.4.19).
- Credits for all other themes are listed in [CREDITS.md](./CREDITS.md)

If there are other color schemes you'd like to see included, drop me a line!

## Extra

### X11 Installation

To install under the [X Window System](https://www.x.org/):

- Import the .xrdb file of the scheme you'd like to use:

  #include "/home/mbadolato/iTerm2-Color-Schemes/xrdb/Blazer.xrdb"

- Use the `#define`s provided by the imported .xrdb file:

  Rxvt*color0: Ansi_0_Color
  Rxvt*color1: Ansi_1_Color
  Rxvt*color2: Ansi_2_Color
  Rxvt*color3: Ansi_3_Color
  Rxvt*color4: Ansi_4_Color
  Rxvt*color5: Ansi_5_Color
  Rxvt*color6: Ansi_6_Color
  Rxvt*color7: Ansi_7_Color
  Rxvt*color8: Ansi_8_Color
  Rxvt*color9: Ansi_9_Color
  Rxvt*color10: Ansi_10_Color
  Rxvt*color11: Ansi_11_Color
  Rxvt*color12: Ansi_12_Color
  Rxvt*color13: Ansi_13_Color
  Rxvt*color14: Ansi_14_Color
  Rxvt*color15: Ansi_15_Color
  Rxvt*colorBD: Bold_Color
  Rxvt*colorIT: Italic_Color
  Rxvt*colorUL: Underline_Color
  Rxvt*foreground: Foreground_Color
  Rxvt*background: Background_Color
  Rxvt*cursorColor: Cursor_Color

  XTerm*color0: Ansi_0_Color
  XTerm*color1: Ansi_1_Color
  XTerm*color2: Ansi_2_Color
  XTerm*color3: Ansi_3_Color
  XTerm*color4: Ansi_4_Color
  XTerm*color5: Ansi_5_Color
  XTerm*color6: Ansi_6_Color
  XTerm*color7: Ansi_7_Color
  XTerm*color8: Ansi_8_Color
  XTerm*color9: Ansi_9_Color
  XTerm*color10: Ansi_10_Color
  XTerm*color11: Ansi_11_Color
  XTerm*color12: Ansi_12_Color
  XTerm*color13: Ansi_13_Color
  XTerm*color14: Ansi_14_Color
  XTerm*color15: Ansi_15_Color
  XTerm*colorBD: Bold_Color
  XTerm*colorIT: Italic_Color
  XTerm*colorUL: Underline_Color
  XTerm*foreground: Foreground_Color
  XTerm*background: Background_Color
  XTerm*cursorColor: Cursor_Color

- Store the above snippets in a file and pass it in:

  xrdb -merge YOUR_FILE_CONTAINING_ABOVE_SNIPPETS

- Open new XTerm or Rxvt windows to see the changes.

- Adapt this procedure to other terminals as needed.

### Terminator color schemes

Edit your Terminator configuration file (located in: `$HOME/.config/terminator/config`) and add the configurations for the theme(s) you'd like to use the `[profiles]` section. The `terminator/` directory contains the config snippets you'll need. Just paste the configurations into the `[profiles]` sections, and you're good to go!

At a minimum, this is all you need. You can customize the fonts and other aspects as well, if you wish. See the Terminator documentation for more details.

An example config file that includes the code snippet for the Symfonic theme would look like this:

```ini
[global_config]
 [keybindings]
 [profiles]
   [[default]]
  palette = "#1a1a1a:#f4005f:#98e024:#fa8419:#9d65ff:#f4005f:#58d1eb:#c4c5b5:#625e4c:#f4005f:#98e024:#e0d561:#9d65ff:#f4005f:#58d1eb:#f6f6ef"
  background_image = None
  use_system_font = False
  cursor_color = "#f6f7ec"
  foreground_color = "#c4c5b5"
  font = Source Code Pro Light 11
  background_color = "#1a1a1a"
   [[Symfonic]]
  palette = "#000000:#dc322f:#56db3a:#ff8400:#0084d4:#b729d9:#ccccff:#ffffff:#1b1d21:#dc322f:#56db3a:#ff8400:#0084d4:#b729d9:#ccccff:#ffffff"
  background_color = "#000000"
  cursor_color = "#dc322f"
  foreground_color = "#ffffff"
  background_image = None
 [layouts]
   [[default]]
  [[[child1]]]
    type = Terminal
    parent = window0
  [[[window0]]]
    type = Window
    parent = ""
 [plugins]
```

### Konsole color schemes

Copy the themes from the `konsole` directory to `$HOME/.config/konsole` (in some versions of KDE, the theme directory may be located at `$HOME/.local/share/konsole`), restart Konsole and choose your new theme from the profile preferences window.

If you want to make the themes available to all users, copy the .colorscheme files to `/usr/share/konsole`.

### Terminal color schemes

Just double click on selected theme in `terminal` directory

### PuTTY color schemes

#### New Session Method

This method creates a new blank session with JUST colors set properly.

Download the appropriate `colorscheme.reg` file and import the registry changes by right-clicking and choosing Merge. Choose "Yes" when prompted if you're sure. Color scheme will show up as a new PuTTY session with all defaults except entries at `Window > Colours > Adjust the precise colours PuTTY displays`.

#### Modify Session Method

This method modifies an existing session and changes JUST the color settings.

Download the appropriate `colorscheme.reg` file. Open the file with a text editor and change the color scheme portion (`Molokai` below) to match the session you want to modify:

```
[HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\Molokai]
- CHANGE TO (EXAMPLE) -
[HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\root@localhost]
```

**NOTE**: Some special characters will need to be changed to their Percent-encoded representation (IE, Space as `%20`). To quickly find the right session name view the top-level entries at `HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\` with `regedit.exe`.

#### Other PuTTY Recommendations

```
Window > Appearance
 Font: Consolas, bold, 14-point
 Font quality:
  ( ) Antialiased   ( ) Non-Antialiased
  (O) ClearType    ( ) Default
Window > Colours
 [X] Allow terminal to specify ANSI colours
 [X] Allow terminal to use xterm 256-colour mode
 Indicate bolded text by changing:
  ( ) The font  (O) The colour   ( ) Both
 [ ] Attempt to use logical palettes
 [ ] Use system colours
```

### Xfce Terminal color schemes

Copy the `colorschemes` folder to `~/.local/share/xfce4/terminal/` and restart Terminal.

### FreeBSD vt color schemes

Append your favourite theme from `freebsd_vt/` to `/boot/loader.conf`
or `/boot/loader.conf.local` and reboot.

### MobaXterm color schemes

Copy the theme content from `mobaxterm/` and paste the content to your `MobaXterm.ini` in the corresponding place (`[Colors]`).

### LXTerminal color schemes

Copy the theme content from `lxterminal/` and paste the content to your `lxterminal` in the corresponding place (`[general]`).

### Visual Studio Code color schemes

Copy the theme content from `vscode/` and paste the content to your [UserSettings.json](https://code.visualstudio.com/docs/getstarted/settings).

### Windows Terminal color schemes

Copy the theme content from `windowsterminal/` and paste the content to your `profiles.json` in the corresponding place (`"schemes"`). Then specify the name of your theme by `"colorScheme"` in `"profiles"`.

### Alacritty color schemes

Copy the theme content from `alacritty/` and paste the content to your alacritty config file, at `~/.config/alacritty/alacritty.toml`. You can also set your theme by adding the following line at your config's 1st line `import = ["~/.config/alacritty/themes/mytheme.toml"]`.

If you still need a color scheme with .yml, you can get it [here](https://github.com/mbadolato/iTerm2-Color-Schemes/tree/56d74c3e29040e44ff7e379a84e0fa3a57b3e903/alacritty).

### Ghostty color schemes

Copy the theme content from `ghostty/` and paste the content in your Ghostty config file, at `~/.config/ghostty/config`.

### Rio color schemes

Copy the theme file from `rio/` and paste to your rio theme config directory (typically `~/.config/rio/themes/`).
Then specify the name of your theme in the `theme` field in the [config file](https://raphamorim.io/rio/docs/#configuration-file).

### Termux color schemes

Copy the theme content from `termux/` and paste the content to `~/.termux` directory as `~/.termux/colors.properties` file and run `termux-reload-settings` to apply the theme.

### Generic color schemes

These schemes work with any terminal emulator with support for the OSC 4 escape code (including the Linux console, GNOME Terminal, and more).

Copy the shell script from `generic/` and paste the script to `~/bin/set-colors.sh`, or wherever you prefer to put shell scripts.
Then add `bash ~/bin/set-colors.sh` to your shell's config file (`~/.bashrc`, `~/.zshrc`, etc).

### Previewing color schemes

[preview.rb](tools/preview.rb) is a simple script that allows you to preview
the color schemes without having to import them. It parses .itermcolors files
and applies the colors to the current session using [iTerm's proprietary
escape codes](https://iterm2.com/documentation-escape-codes.html). As noted in
the linked page, it doesn't run on tmux or screen.

```sh
# Apply AdventureTime scheme to the current session
tools/preview.rb schemes/AdventureTime.itermcolors

# Apply the schemes in turn.
# - Press (almost) any key to advance; hit CTRL-C or ESC to stop
# - Press the delete key to go back
tools/preview.rb schemes/*
```

#### Previewing color schemes in other terminal emulators

[preview-generic.sh](tools/preview-generic.sh) is a script which can preview
the themes in any terminal emulator which has support for the OSC 4 escape
codes. It works by running the shell scripts from the `generic/` directory.

```sh
# Apply AdventureTime scheme to the current session
bash generic/AdventureTime.sh

# Apply the schemes in turn
# - Press left/right arrow keys to navigate, press `q` to stop
./tools/preview-generic.sh generic/*
```

---

iTerm Color Schemes | iTerm2 Color Schemes | iTerm 2 Color Schemes | iTerm Themes | iTerm2 Themes | iTerm 2 Themes

[![Analytics](https://ga-beacon.appspot.com/UA-30661340-2/mbadolato/iTerm2-Color-Schemes?pixel)](https://github.com/igrigorik/ga-beacon)
