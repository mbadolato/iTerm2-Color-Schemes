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

![Screenshot](/screenshots/12-bit_rainbow.png)

### 3024 Night

![Screenshot](/screenshots/3024_night.png)

### Aardvark Blue

![Screenshot](/screenshots/aardvark_blue.png)

### Abernathy

![Screenshot](/screenshots/abernathy.png)

### Adventure

![Screenshot](/screenshots/adventure.png)

### AdventureTime

![Screenshot](/screenshots/adventure_time.png)

### Adwaita Dark

![Screenshot](/screenshots/adwaita_dark.png)

### Afterglow

![Screenshot](/screenshots/afterglow.png)

### AlienBlood

![Screenshot](/screenshots/alien_blood.png)

### Andromeda

![Screenshot](/screenshots/andromeda.png)

### Apple Classic

![Screenshot](/screenshots/apple-classic.png)

### Apple System Colors

![Screenshot](/screenshots/apple-system-colors.png)

### arcoiris

![Screenshot](/screenshots/arcoiris.png)

### Ardoise

![Screenshot](/screenshots/ardoise.png)

### Argonaut

![Screenshot](/screenshots/argonaut.png)

### Arthur

![Screenshot](/screenshots/arthur.png)

### AtelierSulphurpool

![Screenshot](/screenshots/atelier-sulphurpool_dark.png)

### Atom

![Screenshot](/screenshots/atom.png)

### AtomOneDark

![Screenshot](/screenshots/atom_one_dark.png)

### Aura

![Screenshot](/screenshots/aura.png)

### Aurora

![Screenshot](/screenshots/aurora.png)

### Ayu Mirage

![Screenshot](/screenshots/ayu_mirage.png)

### ayu

![Screenshot](/screenshots/ayu.png)

### Banana Blueberry

![Screenshot](/screenshots/banana_blueberry.png)

### Batman

![Screenshot](/screenshots/batman.png)

### Belafonte Night

![Screenshot](/screenshots/belafonte_night.png)

### BirdsOfParadise

![Screenshot](/screenshots/birds_of_paradise.png)

### Black Metal (Bathory)

![Screenshot](/screenshots/black_metal_bathory.png)

### Black Metal (Burzum)

![Screenshot](/screenshots/black_metal_burzum.png)

### Black Metal (Dark Funeral)

![Screenshot](/screenshots/black_metal_dark_funeral.png)

### Black Metal (Gorgoroth)

![Screenshot](/screenshots/black_metal_gorgoroth.png)

### Black Metal (Immortal)

![Screenshot](/screenshots/black_metal_immortal.png)

### Black Metal (Khold)

![Screenshot](/screenshots/black_metal_khold.png)

### Black Metal (Marduk)

![Screenshot](/screenshots/black_metal_marduk.png)

### Black Metal (Mayhem)

![Screenshot](/screenshots/black_metal_mayhem.png)

### Black Metal (Nile)

![Screenshot](/screenshots/black_metal_nile.png)

### Black Metal (Venom)

![Screenshot](/screenshots/black_metal_venom.png)

### Black Metal

![Screenshot](/screenshots/black_metal.png)

### Blazer

![Screenshot](/screenshots/blazer.png)

### Blue Matrix

![Screenshot](/screenshots/blue_matrix.png)

### BlueBerryPie

![Screenshot](/screenshots/blueberry_pie.png)

### BlueDolphin

![Screenshot](/screenshots/BlueDolphin.png)

### BlulocoDark

![Screenshot](/screenshots/bluloco_dark.png)

### Borland

![Screenshot](/screenshots/borland.png)

### Box

![Screenshot](/screenshots/box.png)

### Breeze

![Screenshot](/screenshots/breeze.png)

### Bright Lights

![Screenshot](/screenshots/bright_lights.png)

### Broadcast

![Screenshot](/screenshots/broadcast.png)

### Brogrammer

![Screenshot](/screenshots/brogrammer.png)

### C64

![Screenshot](/screenshots/c64.png)

### Calamity

![Screenshot](/screenshots/calamity.png)

### catppuccin-frappe

![Screenshot](/screenshots/catppuccin-frappe.png)

### catppuccin-macchiato

![Screenshot](/screenshots/catppuccin-macchiato.png)

### catppuccin-mocha

![Screenshot](/screenshots/catppuccin-mocha.png)

### CGA

![Screenshot](/screenshots/cga.png)

### Chalk

![Screenshot](/screenshots/chalk.png)

### Chalkboard

![Screenshot](/screenshots/chalkboard.png)

### ChallengerDeep

![Screenshot](/screenshots/challenger_deep.png)

### Chester

![Screenshot](/screenshots/chester.png)

### Ciapre

![Screenshot](/screenshots/ciapre.png)

### citruszest

![Screenshot](/screenshots/citruszest.png)

### Cobalt Neon

![Screenshot](/screenshots/cobalt_neon.png)

### Cobalt2

![Screenshot](/screenshots/cobalt2.png)

### CobaltNext-Dark

![Screenshot](/screenshots/cobalt_next-dark.png)

### CobaltNext-Minimal

![Screenshot](/screenshots/cobalt_next-minimal.png)

### CobaltNext

![Screenshot](/screenshots/cobalt_next.png)

### CrayonPonyFish

![Screenshot](/screenshots/crayon_pony_fish.png)

### CutiePro

![Screenshot](/screenshots/CutiePro.png)

### Cyberdyne

![Screenshot](/screenshots/cyberdyne.png)

### cyberpunk

![Screenshot](/screenshots/cyberpunk.png)

### CyberpunkScarletProtocol

![Screenshot](/screenshots/cyberpunk_scarlet_protocol.png)

### Dark Modern

![Screenshot](/screenshots/dark_modern.png)

### Dark Pastel

![Screenshot](/screenshots/dark_pastel.png)

### Dark+

![Screenshot](/screenshots/dark_plus.png)

### darkermatrix

![Screenshot](/screenshots/darkermatrix.png)

### darkmatrix

![Screenshot](/screenshots/darkmatrix.png)

### Darkside

![Screenshot](/screenshots/darkside.png)

### deep

![Screenshot](/screenshots/deep.png)

### Desert

![Screenshot](/screenshots/desert.png)

### detuned

![Screenshot](/screenshots/detuned.png)

### Dimidium

![Screenshot](/screenshots/dimidium.png)

### DimmedMonokai

![Screenshot](/screenshots/dimmed_monokai.png)

### Django

![Screenshot](/screenshots/django.png)

### DjangoRebornAgain

![Screenshot](/screenshots/DjangoRebornAgain.png)

### DjangoSmooth

![Screenshot](/screenshots/DjangoSmoothy.png)

### Doom Peacock

![Screenshot](/screenshots/doom_peacock.png)

### DoomOne

![Screenshot](/screenshots/doom_one.png)

### DotGov

![Screenshot](/screenshots/dot_gov.png)

### Dracula+

![Screenshot](/screenshots/dracula+.png)

### Dracula

![Screenshot](/screenshots/dracula.png)

### duckbones

![Screenshot](/screenshots/duckbones.png)

### Duotone Dark

![Screenshot](/screenshots/duotone_dark.png)

### Earthsong

![Screenshot](/screenshots/earthsong.png)

### electron-highlighter

![Screenshot](/screenshots/electron-highlighter.png)

### Elegant

![Screenshot](/screenshots/elegant.png)

### Elemental

![Screenshot](/screenshots/elemental.png)

### Elementary

![Screenshot](/screenshots/elementary.png)

### Embark

![Screenshot](/screenshots/embark.png)

### embers-dark

![Screenshot](/screenshots/embers.png)

### ENCOM

![Screenshot](/screenshots/encom.png)

### Espresso Libre

![Screenshot](/screenshots/espresso_libre.png)

### Espresso

![Screenshot](/screenshots/espresso.png)

### Everblush

![Screenshot](/screenshots/everblush.png)

### Everforest Dark - Hard

![Screenshot](/screenshots/everforest_dark_hard.png)

### Fahrenheit

![Screenshot](/screenshots/fahrenheit.png)

### Fairyfloss

![Screenshot](/screenshots/fairyfloss.png)

### farmhouse-dark

![Screenshot](/screenshots/farmhouse-dark.png)

### Fideloper

![Screenshot](/screenshots/fideloper.png)

### Firefly Traditional

![Screenshot](/screenshots/firefly-traditional.png)

### FirefoxDev

![Screenshot](/screenshots/firefox_dev.png)

### Firewatch

![Screenshot](/screenshots/firewatch.png)

### FishTank

![Screenshot](/screenshots/fish_tank.png)

### Flat

![Screenshot](/screenshots/flat.png)

### Flatland

![Screenshot](/screenshots/flatland.png)

### flexoki-dark

![Screenshot](/screenshots/flexoki-dark.png)

### Floraverse

![Screenshot](/screenshots/floraverse.png)

### ForestBlue

![Screenshot](/screenshots/forest_blue.png)

### Framer

![Screenshot](/screenshots/framer.png)

### FrontEndDelight

![Screenshot](/screenshots/front_end_delight.png)

### FunForrest

![Screenshot](/screenshots/fun_forrest.png)

### Galaxy

![Screenshot](/screenshots/galaxy.png)

### Galizur

![Screenshot](/screenshots/galizur.png)

### Ghostty Default StyleDark

![Screenshot](/screenshots/ghostty_default_style_dark.png)

### GitHub Dark

![Screenshot](/screenshots/github_dark.png)

### GitHub-Dark-Colorblind

![Screenshot](/screenshots/github-dark-colorblind.png)

### GitHub-Dark-Default

![Screenshot](/screenshots/github-dark-default.png)

### GitHub-Dark-Dimmed

![Screenshot](/screenshots/github-dark-dimmed.png)

### GitHub-Dark-High-Contrast

![Screenshot](/screenshots/github-dark-high-contrast.png)

### GitLab-Dark-Grey

![Screenshot](/screenshots/git_lab-dark-grey.png)

### GitLab-Dark

![Screenshot](/screenshots/git_lab-dark.png)

### Glacier

![Screenshot](/screenshots/glacier.png)

### Grape

![Screenshot](/screenshots/grape.png)

### Grass

![Screenshot](/screenshots/grass.png)

### Grey-green

![Screenshot](/screenshots/grey-green.png)

### gruber-darker

![Screenshot](/screenshots/gruber-darker.png)

### gruvbox-material

![Screenshot](/screenshots/gruvbox_material.png)

### GruvboxDark

![Screenshot](/screenshots/gruvbox_dark.png)

### GruvboxDarkHard

![Screenshot](/screenshots/gruvbox_dark_hard.png)

### Guezwhoz

![Screenshot](/screenshots/guezwhoz.png)

### Hacktober

![Screenshot](/screenshots/hacktober.png)

### Hardcore

![Screenshot](/screenshots/hardcore.png)

### Harper

![Screenshot](/screenshots/harper.png)

### Havn Skumring

![Screenshot](/screenshots/havn_skumring.png)

### HaX0R_BLUE

![Screenshot](/screenshots/hax0r_blue.png)

### HaX0R_GR33N

![Screenshot](/screenshots/hax0r_gr33n.png)

### HaX0R_R3D

![Screenshot](/screenshots/hax0r_r3d.png)

### heeler

![Screenshot](/screenshots/heeler.png)

### Highway

![Screenshot](/screenshots/highway.png)

### Hipster Green

![Screenshot](/screenshots/hipster_green.png)

### Hivacruz

![Screenshot](/screenshots/hivacruz.png)

### Homebrew

![Screenshot](/screenshots/homebrew.png)

### Hopscotch.256

![Screenshot](/screenshots/hopscotch_256.png)

### Hopscotch

![Screenshot](/screenshots/hopscotch.png)

### Horizon

![Screenshot](/screenshots/horizon.png)

### Hurtado

![Screenshot](/screenshots/hurtado.png)

### Hybrid

![Screenshot](/screenshots/hybrid.png)

### IC_Green_PPL

![Screenshot](/screenshots/ic_green_ppl.png)

### IC_Orange_PPL

![Screenshot](/screenshots/ic_orange_ppl.png)

### iceberg-dark

![Screenshot](/screenshots/iceberg.png)

### idea

![Screenshot](/screenshots/idea.png)

### idleToes

![Screenshot](/screenshots/idleToes.png)

### IR_Black

![Screenshot](/screenshots/ir_black.png)

### IRIX Console

![Screenshot](/screenshots/irix_console.png)

### IRIX Terminal

![Screenshot](/screenshots/irix_terminal.png)

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

![Screenshot](/screenshots/jackie_brown.png)

### Japanesque

![Screenshot](/screenshots/japanesque.png)

### Jellybeans

![Screenshot](/screenshots/jellybeans.png)

### JetBrains Darcula

![Screenshot](/screenshots/jetbrains_darcula.png)

### jubi

![Screenshot](/screenshots/jubi.png)

### Kanagawa Dragon

![Screenshot](/screenshots/kanagawa-dragon.png)

### Kanagawa Wave

![Screenshot](/screenshots/kanagawa-wave.png)

### kanagawabones

![Screenshot](/screenshots/kanagawabones.png)

### Kibble

![Screenshot](/screenshots/kibble.png)

### Kolorit

![Screenshot](/screenshots/kolorit.png)

### Konsolas

![Screenshot](/screenshots/konsolas.png)

### kurokula

![Screenshot](/screenshots/kurokula.png)

### Lab Fox

![Screenshot](/screenshots/lab_fox.png)

### Laser

![Screenshot](/screenshots/laser.png)

### Later This Evening

![Screenshot](/screenshots/later_this_evening.png)

### Lavandula

![Screenshot](/screenshots/lavandula.png)

### LiquidCarbon

![Screenshot](/screenshots/liquid_carbon.png)

### LiquidCarbonTransparent

![Screenshot](/screenshots/liquid_carbon_transparent.png)

### LiquidCarbonTransparentInverse

![Screenshot](/screenshots/liquid_carbon_transparent_inverse.png)

### lovelace

![Screenshot](/screenshots/lovelace.png)

### Mariana

![Screenshot](/screenshots/mariana.png)

### MaterialDark

![Screenshot](/screenshots/material_dark.png)

### MaterialDarker

![Screenshot](/screenshots/material_darker.png)

### MaterialDesignColors

![Screenshot](/screenshots/material_design_colors.png)

### MaterialOcean

![Screenshot](/screenshots/material_ocean.png)

### Mathias

![Screenshot](/screenshots/mathias.png)

### matrix

![Screenshot](/screenshots/matrix.png)

### Medallion

![Screenshot](/screenshots/medallion.png)

### Melange_dark

![Screenshot](/screenshots/melange_dark.png)

### Mellifluous

![Screenshot](/screenshots/mellifluous.png)

### mellow

![Screenshot](/screenshots/mellow.png)

### miasma

![Screenshot](/screenshots/miasma.png)

### midnight-in-mojave

![Screenshot](/screenshots/midnight_in_mojave.png)

### Mirage

![Screenshot](/screenshots/mirage.png)

### Misterioso

![Screenshot](/screenshots/misterioso.png)

### Molokai

![Screenshot](/screenshots/molokai.png)

### MonaLisa

![Screenshot](/screenshots/mona_lisa.png)

### Monokai Classic

![Screenshot](/screenshots/monokai_classic.png)

### Monokai Pro Machine

![Screenshot](/screenshots/monokai_pro_machine.png)

### Monokai Pro Octagon

![Screenshot](/screenshots/monokai_pro_octagon.png)

### Monokai Pro Ristretto

![Screenshot](/screenshots/monokai_pro_ristretto.png)

### Monokai Pro Spectrum

![Screenshot](/screenshots/monokai_pro_spectrum.png)

### Monokai Pro

![Screenshot](/screenshots/monokai_pro.png)

### Monokai Remastered

![Screenshot](/screenshots/monokai_remastered.png)

### Monokai Soda

![Screenshot](/screenshots/monokai_soda.png)

### Monokai Vivid

![Screenshot](/screenshots/monokai_vivid.png)

### moonfly

![Screenshot](/screenshots/moonfly.png)

### N0tch2k

![Screenshot](/screenshots/n0tch2k.png)

### neobones_dark

![Screenshot](/screenshots/neobones_dark.png)

### Neon

![Screenshot](/screenshots/neon.png)

### Neopolitan

![Screenshot](/screenshots/neopolitan.png)

### Neutron

![Screenshot](/screenshots/neutron.png)

### nightfox

![Screenshot](/screenshots/nightfox.png)

### NightLion v1

![Screenshot](/screenshots/nightlion_v1.png)

### NightLion v2

![Screenshot](/screenshots/nightlion_v2.png)

### NightOwl

![Screenshot](/screenshots/night_owl.png)

### niji

![Screenshot](/screenshots/niji.png)

### Nocturnal Winter

![Screenshot](/screenshots/nocturnal_winter.png)

### nord-wave

![Screenshot](/screenshots/nord-wave.png)

### nord

![Screenshot](/screenshots/nord.png)

### NvimDark

![Screenshot](/screenshots/NvimDark.png)

### Obsidian

![Screenshot](/screenshots/obsidian.png)

### Ocean

![Screenshot](/screenshots/ocean.png)

### Oceanic-Next

![Screenshot](/screenshots/oceanic_next.png)

### OceanicMaterial

![Screenshot](/screenshots/oceanic_material.png)

### Ollie

![Screenshot](/screenshots/ollie.png)

### One Double Dark

![Screenshot](/screenshots/one_double_dark.png)

### OneHalfDark

![Screenshot](/screenshots/onehalfdark.png)

### Operator Mono Dark

![Screenshot](/screenshots/operator_mono_dark.png)

### Overnight Slumber

![Screenshot](/screenshots/overnight_slumber.png)

### Oxocarbon

![Screenshot](/screenshots/oxocarbon.png)

### PaleNightHC

![Screenshot](/screenshots/PaleNightHC.png)

### Pandora

![Screenshot](/screenshots/pandora.png)

### Paraiso Dark

![Screenshot](/screenshots/paraiso_dark.png)

### PaulMillr

![Screenshot](/screenshots/paul_millr.png)

### PencilDark

![Screenshot](/screenshots/pencil_dark.png)

### Peppermint

![Screenshot](/screenshots/peppermint.png)

### Phala Green Dark

![Screenshot](/screenshots/phala_green_dark.png)

### Pnevma

![Screenshot](/screenshots/pnevma.png)

### Popping and Locking

![Screenshot](/screenshots/popping_and_locking.png)

### Pro

![Screenshot](/screenshots/pro.png)

### Purple Rain

![Screenshot](/screenshots/purple_rain.png)

### purplepeter

![Screenshot](/screenshots/purplepeter.png)

### Rapture

![Screenshot](/screenshots/rapture.png)

### Raycast_Dark

![Screenshot](/screenshots/raycast_dark.png)

### rebecca

![Screenshot](/screenshots/rebecca.png)

### Red Alert

![Screenshot](/screenshots/red_alert.png)

### Red Planet

![Screenshot](/screenshots/red_planet.png)

### Red Sands

![Screenshot](/screenshots/red_sands.png)

### Relaxed

![Screenshot](/screenshots/relaxed.png)

### Retro

![Screenshot](/screenshots/retro.png)

### RetroLegends

![Screenshot](/screenshots/RetroLegends.png)

### Rippedcasts

![Screenshot](/screenshots/rippedcasts.png)

### rose-pine-moon

![Screenshot](/screenshots/rose-pine-moon.png)

### rose-pine

![Screenshot](/screenshots/rose-pine.png)

### Rouge 2

![Screenshot](/screenshots/rouge_2.png)

### Royal

![Screenshot](/screenshots/royal.png)

### Ryuuko

![Screenshot](/screenshots/ryuuko.png)

### Sakura

![Screenshot](/screenshots/sakura.png)

### Scarlet Protocol

![Screenshot](/screenshots/scarlet_protocol.png)

### Seafoam Pastel

![Screenshot](/screenshots/seafoam_pastel.png)

### SeaShells

![Screenshot](/screenshots/sea_shells.png)

### selenized-dark

![Screenshot](/screenshots/selenized-dark.png)

### seoulbones_dark

![Screenshot](/screenshots/seoulbones_dark.png)

### Seti

![Screenshot](/screenshots/seti.png)

### shades-of-purple

![Screenshot](/screenshots/ShadesOfPurple.png)

### Shaman

![Screenshot](/screenshots/shaman.png)

### Slate

![Screenshot](/screenshots/slate.png)

### SleepyHollow

![Screenshot](/screenshots/SleepyHollow.png)

### Smyck

![Screenshot](/screenshots/smyck.png)

### Snazzy Soft

![Screenshot](/screenshots/snazzy_soft.png)

### Snazzy

![Screenshot](/screenshots/snazzy.png)

### SoftServer

![Screenshot](/screenshots/soft_server.png)

### Solarized Darcula

![Screenshot](/screenshots/solarized_darcula.png)

### Solarized Dark - Patched

![Screenshot](/screenshots/solarized_dark_patched.png)

### Solarized Dark Higher Contrast

![Screenshot](/screenshots/solarized_dark_higher_contrast.png)

### solarized-osaka-night

![Screenshot](/screenshots/solarized-osaka-night.png)

### sonokai

![Screenshot](/screenshots/sonokai.png)

### Spacedust

![Screenshot](/screenshots/spacedust.png)

### SpaceGray Bright

![Screenshot](/screenshots/spacegray_bright.png)

### SpaceGray Eighties Dull

![Screenshot](/screenshots/spacegray_eighties_dull.png)

### SpaceGray Eighties

![Screenshot](/screenshots/spacegray_eighties.png)

### SpaceGray

![Screenshot](/screenshots/space_gray.png)

### Spiderman

![Screenshot](/screenshots/spiderman.png)

### Square

![Screenshot](/screenshots/square.png)

### Squirrelsong Dark

![Screenshot](/screenshots/squirrelsong_dark.png)

### srcery

![Screenshot](/screenshots/srcery.png)

### starlight

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

### synthwave-everything

![Screenshot](/screenshots/synthwave-everything.png)

### synthwave

![Screenshot](/screenshots/synthwave.png)

### SynthwaveAlpha

![Screenshot](/screenshots/synthwave_alpha.png)

### Tearout

![Screenshot](/screenshots/tearout.png)

### Teerb

![Screenshot](/screenshots/teerb.png)

### terafox

![Screenshot](/screenshots/terafox.png)

### Terminal Basic Dark

![Screenshot](/screenshots/terminal_basic_dark.png)

### Thayer Bright

![Screenshot](/screenshots/thayer_bright.png)

### The Hulk

![Screenshot](/screenshots/the_hulk.png)

### Tinacious Design (Dark)

![Screenshot](/screenshots/tinacious_design_dark.png)

### tokyonight-storm

![Screenshot](/screenshots/tokyonight-storm.png)

### tokyonight

![Screenshot](/screenshots/tokyonight.png)

### tokyonight_moon

![Screenshot](/screenshots/tokyonight-moon.png)

### tokyonight_night

![Screenshot](/screenshots/tokyonight-night.png)

### Tomorrow Night Blue

![Screenshot](/screenshots/tomorrow_night_blue.png)

### Tomorrow Night Bright

![Screenshot](/screenshots/tomorrow_night_bright.png)

### Tomorrow Night Burns

![Screenshot](/screenshots/tomorrow_night_burns.png)

### Tomorrow Night Eighties

![Screenshot](/screenshots/tomorrow_night_eighties.png)

### Tomorrow Night

![Screenshot](/screenshots/tomorrow_night.png)

### ToyChest

![Screenshot](/screenshots/toy_chest.png)

### Treehouse

![Screenshot](/screenshots/treehouse.png)

### Twilight

![Screenshot](/screenshots/twilight.png)

### Ubuntu

![Screenshot](/screenshots/ubuntu.png)

### UltraDark

![Screenshot](/screenshots/ultradark.png)

### UltraViolent

![Screenshot](/screenshots/ultra_violent.png)

### UnderTheSea

![Screenshot](/screenshots/under_the_sea.png)

### Urple

![Screenshot](/screenshots/urple.png)

### Vague

![Screenshot](/screenshots/vague.png)

### Vaughn

![Screenshot](/screenshots/vaughn.png)

### Vesper

![Screenshot](/screenshots/vesper.png)

### VibrantInk

![Screenshot](/screenshots/vibrant_ink.png)

### Violet Dark

![Screenshot](/screenshots/violet_dark.png)

### violite

![Screenshot](/screenshots/violite.png)

### WarmNeon

![Screenshot](/screenshots/warm_neon.png)

### Wez

![Screenshot](/screenshots/wez.png)

### Whimsy

![Screenshot](/screenshots/whimsy.png)

### WildCherry

![Screenshot](/screenshots/wild_cherry.png)

### wilmersdorf

![Screenshot](/screenshots/wilmersdorf.png)

### Wombat

![Screenshot](/screenshots/wombat.png)

### Wryan

![Screenshot](/screenshots/wryan.png)

### xcodedark

![Screenshot](/screenshots/xcodedark.png)

### xcodedarkhc

![Screenshot](/screenshots/xcodedarkhc.png)

### xcodewwdc

![Screenshot](/screenshots/xcodewwdc.png)

### zenbones_dark

![Screenshot](/screenshots/zenbones_dark.png)

### Zenburn

![Screenshot](/screenshots/zenburn.png)

### zenburned

![Screenshot](/screenshots/zenburned.png)

### zenwritten_dark

![Screenshot](/screenshots/zenwritten_dark.png)

### Light Themes<a name="lightthemes"><a/>

### 3024 Day

![Screenshot](/screenshots/3024_day.png)

### Adwaita

![Screenshot](/screenshots/adwaita.png)

### Alabaster

![Screenshot](/screenshots/alabaster.png)

### Apple System Colors Light

![Screenshot](/screenshots/apple_system_colors_light.png)

### AtomOneLight

![Screenshot](/screenshots/atom_one_light.png)

### ayu_light

![Screenshot](/screenshots/ayu_light.png)

### Belafonte Day

![Screenshot](/screenshots/belafonte_day.png)

### BlulocoLight

![Screenshot](/screenshots/bluloco_light.png)

### Breadog

![Screenshot](/screenshots/breadog.png)

### catppuccin-latte

![Screenshot](/screenshots/catppuccin-latte.png)

### CLRS

![Screenshot](/screenshots/clrs.png)

### coffee_theme

![Screenshot](/screenshots/Coffee.png)

### dayfox

![Screenshot](/screenshots/dayfox.png)

### Everforest Light - Med

![Screenshot](/screenshots/everforest_light_med.png)

### farmhouse-light

![Screenshot](/screenshots/farmhouse-light.png)

### flexoki-light

![Screenshot](/screenshots/flexoki-light.png)

### GitHub-Light-Colorblind

![Screenshot](/screenshots/github-light-colorblind.png)

### GitHub-Light-Default

![Screenshot](/screenshots/github-light-default.png)

### GitHub-Light-High-Contrast

![Screenshot](/screenshots/github-light-high-contrast.png)

### Github

![Screenshot](/screenshots/github.png)

### GitLab-Light

![Screenshot](/screenshots/git_lab-light.png)

### GruvboxLight

![Screenshot](/screenshots/gruvbox_light.png)

### GruvboxLightHard

![Screenshot](/screenshots/gruvbox_light_hard.png)

### Havn Daggry

![Screenshot](/screenshots/havn_daggry.png)

### Horizon-Bright

![Screenshot](/screenshots/horizon-bright.png)

### iceberg-light

![Screenshot](/screenshots/iceberg-light.png)

### iTerm2 Light Background

![Screenshot](/screenshots/iterm2-light-background.png)

### iTerm2 Solarized Light

![Screenshot](/screenshots/iterm2-solarized-light.png)

### iTerm2 Tango Light

![Screenshot](/screenshots/iterm2-tango-light.png)

### LightOwl

![Screenshot](/screenshots/light_owl.png)

### Man Page

![Screenshot](/screenshots/man_page.png)

### Material

![Screenshot](/screenshots/material.png)

### Melange_light

![Screenshot](/screenshots/melange_light.png)

### Monokai Pro Light Sun

![Screenshot](/screenshots/monokai_pro_light_sun.png)

### Monokai Pro Light

![Screenshot](/screenshots/monokai_pro_light.png)

### neobones_light

![Screenshot](/screenshots/neobones_light.png)

### Night Owlish Light

![Screenshot](/screenshots/night_owlish_light.png)

### nord-light

![Screenshot](/screenshots/nord_light.png)

### Novel

![Screenshot](/screenshots/novel.png)

### NvimLight

![Screenshot](/screenshots/NvimLight.png)

### One Double Light

![Screenshot](/screenshots/one_double_light.png)

### OneHalfLight

![Screenshot](/screenshots/onehalflight.png)

### PencilLight

![Screenshot](/screenshots/pencil_light.png)

### Piatto Light

![Screenshot](/screenshots/piatto_light.png)

### primary

![Screenshot](/screenshots/primary.png)

### Pro Light

![Screenshot](/screenshots/pro_light.png)

### Raycast_Light

![Screenshot](/screenshots/raycast_light.png)

### rose-pine-dawn

![Screenshot](/screenshots/rose-pine-dawn.png)

### selenized-light

![Screenshot](/screenshots/selenized-light.png)

### seoulbones_light

![Screenshot](/screenshots/seoulbones_light.png)

### Spring

![Screenshot](/screenshots/spring.png)

### Tango Adapted

![Screenshot](/screenshots/tango_adapted.png)

### Tango Half Adapted

![Screenshot](/screenshots/tango_half_adapted.png)

### Terminal Basic

![Screenshot](/screenshots/terminal_basic.png)

### Tinacious Design (Light)

![Screenshot](/screenshots/tinacious_design_light.png)

### tokyonight-day

![Screenshot](/screenshots/tokyonight-day.png)

### Tomorrow

![Screenshot](/screenshots/tomorrow.png)

### Unikitty

![Screenshot](/screenshots/unikitty.png)

### vimbones

![Screenshot](/screenshots/vimbones.png)

### Violet Light

![Screenshot](/screenshots/violet_light.png)

### xcodelight

![Screenshot](/screenshots/xcodelight.png)

### xcodelighthc

![Screenshot](/screenshots/xcodelighthc.png)

### zenbones

![Screenshot](/screenshots/zenbones.png)

### zenbones_light

![Screenshot](/screenshots/zenbones_light.png)

### zenwritten_light

![Screenshot](/screenshots/zenwritten_light.png)

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
