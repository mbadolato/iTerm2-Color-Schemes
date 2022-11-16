# iTerm Color Schemes

- [Intro](#intro)
- [Installation Instructions](#installation-instructions)
- [Contribute](#contribute)
- [Screenshots](#screenshots)
- [Credits](#credits)
- [Extra](#extra)
  - [X11 Installation](#x11-installation)
  - [Konsole color schemes](#konsole-color-schemes)
  - [Terminator color schemes](#terminator-color-schemes)
  - [Mac OS Terminal color schemes](#terminal-color-schemes)
  - [PuTTY color schemes](#putty-color-schemes)
  - [Xfce Terminal color schemes](#xfce-terminal-color-schemes)
  - [FreeBSD vt(4) color schemes](#freebsd-vt-color-schemes)
  - [Previewing color schemes](#previewing-color-schemes)
  - [MobaXterm color schemes](#mobaxterm-color-schemes)
  - [LXTerminal color schemes](#lxterminal-color-schemes)
  - [Visual Studio Code color schemes](#visual-studio-code-color-schemes)
  - [Windows Terminal color schemes](#windows-terminal-color-schemes)
  - [Alacritty color schemes](#alacritty-color-schemes)

## Intro

This is a set of color schemes for iTerm (aka iTerm2). It also includes ports to Terminal, Konsole, PuTTY, Xresources, XRDB, Remmina, Termite, XFCE, Tilda, FreeBSD VT, Terminator, Kitty, MobaXterm, LXTerminal, Microsoft's Windows Terminal, Visual Studio, Alacritty

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
  tools/import-scheme.sh 'SpaceGray Eighties'                     # by scheme name
  tools/import-scheme.sh Molokai 'SpaceGray Eighties'             # import multiple
  ```

  - Restart iTerm 2. (Need to quit iTerm 2 to reload the configuration file.)

## Contribute

### Prerequisites

1. For convenient work with generation scripts, it is recommended to install [pyenv](https://github.com/pyenv/pyenv).
2. Run `pyenv install` inside project folder to install python version from `.python-version` file.
3. Run `pip install -r requirements.txt` to install the project dependencies.

### How to add new theme

Have a great iTerm theme? Send it to me via a Pull Request!

1. Get your theme's`.itermcolors` file.
    - Launch iTerm 2
    - Type CMD+i (⌘+i)
    - Navigate to **Colors** tab
    - Click on **Color Presets**
    - Click on **Export**
    - Save the .itermcolors file
2. Put your theme file into `/schemes/`
    - `mv <your-itermcolors-file> schemes/`
3. Generate other formats for your theme using the `update_all.py` script.
    - `cd tools/ && python3 gen.py` OR
    - `cd tools/ && ./gen.py`
4. If you only want to generate files for your theme, you can specify this with the `-s` flag.
    - `./gen.py -s Dracula`
5. Get a screenshot of your theme using the `screenshotTable.sh` script and ImageMagick. **For screenshot consistency, please have your font set to 13pt Monaco and no transparency on the window.**
    - `cd tools/ && ./screenshotTable.sh` - this will create a color table for your theme that you can screenshot.
    - Use ImageMagick (or some other tool) to resize your image for consistency - `mogrify -resize 600x300\! <path-to-your-screenshot>`
    - Move your screenshot into `screenshots/` - `mv <your-screenshot> screenshots/`
6. Update `README.md` and `screenshots/README.md` to include your theme and screenshot. Also update `CREDITS.md` to credit yourself for your contribution.

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

  Eeach color has these fields:
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

## Screenshots

### 3024 Day

![Screenshot](screenshots/3024_day.png)

### 3024 Night

![Screenshot](screenshots/3024_night.png)

### Abernathy

![Screenshot](screenshots/abernathy.png)

### Adventure

![Screenshot](screenshots/adventure.png)

### AdventureTime

![Screenshot](screenshots/adventure_time.png)

### Afterglow

![Screenshot](screenshots/afterglow.png)

### Alabaster

![Screenshot](screenshots/alabaster.png)

### AlienBlood

![Screenshot](screenshots/alien_blood.png)

### Andromeda

![Screenshot](screenshots/andromeda.png)

### Arcoiris

![Screenshot](screenshots/arcoiris.png)

### Argonaut

![Screenshot](screenshots/argonaut.png)

### Arthur

![Screenshot](screenshots/arthur.png)

### AtelierSulphurpool

![Screenshot](screenshots/atelier-sulphurpool_dark.png)

### Atom

![Screenshot](screenshots/atom.png)

### Atom One Light

![Screenshot](screenshots/atom_one_light.png)

### ayu

![Screenshot](screenshots/ayu.png)

### ayu Light

![Screenshot](screenshots/ayu_light.png)

### ayu Mirage

![Screenshot](screenshots/ayu_mirage.png)

### Aurora

![Screenshot](screenshots/aurora.png)

### Banana Blueberry

![Screenshot](screenshots/banana_blueberry.png)

### Batman

![Screenshot](screenshots/batman.png)

### Belafonte Day

![Screenshot](screenshots/belafonte_day.png)

### Belafonte Night

![Screenshot](screenshots/belafonte_night.png)

### BirdsOfParadise

![Screenshot](screenshots/birds_of_paradise.png)

### Blazer

![Screenshot](screenshots/blazer.png)

### BlueBerry Pie

![Screenshot](screenshots/blueberry_pie.png)

### BlueDolphin

![Screenshot](screenshots/BlueDolphin.png)

### Blue Matrix

![Screenshot](screenshots/blue_matrix.png)

### Bluloco Dark

![Screenshot](screenshots/bluloco_dark.png)

### Bluloco Light

![Screenshot](screenshots/bluloco_light.png)

### Borland

![Screenshot](screenshots/borland.png)

### Breeze

![Screenshot](screenshots/breeze.png)

### Bright Lights

![Screenshot](screenshots/bright_lights.png)

### Broadcast

![Screenshot](screenshots/broadcast.png)

### Brogrammer

![Screenshot](screenshots/brogrammer.png)

### Builtin Dark

![Screenshot](screenshots/builtin_dark.png)

### Builtin Light

![Screenshot](screenshots/builtin_light.png)

### Builtin Pastel Dark

![Screenshot](screenshots/builtin_pastel_dark.png)

### Builtin Solarized Dark

![Screenshot](screenshots/builtin_solarized_dark.png)

### Builtin Solarized Light

![Screenshot](screenshots/builtin_solarized_light.png)

### Builtin Tango Dark

![Screenshot](screenshots/builtin_tango_dark.png)

### Builtin Tango Light

![Screenshot](screenshots/builtin_tango_light.png)

### C64

![Screenshot](screenshots/c64.png)

### Calamity

![Screenshot](screenshots/calamity.png)

### CGA

![Screenshot](screenshots/CGA.png)

### Chalk

![Screenshot](screenshots/chalk.png)

### Chalkboard

![Screenshot](screenshots/chalkboard.png)

### ChallengerDeep

![Screenshot](screenshots/challenger_deep.png)

### Chester

![Screenshot](screenshots/chester.png)

### Ciapre

![Screenshot](screenshots/ciapre.png)

### CLRS

![Screenshot](screenshots/clrs.png)

### Cobalt Neon

![Screenshot](screenshots/cobalt_neon.png)

### Cobalt2

![Screenshot](screenshots/cobalt2.png)

### Coffee

![Screenshot](screenshots/Coffee.png)

### CrayonPonyFish

![Screenshot](screenshots/crayon_pony_fish.png)

### Cyberdyne

![Screenshot](screenshots/cyberdyne.png)

### Cyberpunk

![Screenshot](screenshots/cyberpunk.png)

### Dark Pastel

![Screenshot](screenshots/dark_pastel.png)

### Dark+

![Screenshot](screenshots/dark_plus.png)

### Darkside

![Screenshot](screenshots/darkside.png)

### Deep

![Screenshot](screenshots/deep.png)

### Desert

![Screenshot](screenshots/desert.png)

### DimmedMonokai

![Screenshot](screenshots/dimmed_monokai.png)

### Django

![Screenshot](screenshots/Django.png)

### DjangoRebornAgain

![Screenshot](screenshots/DjangoRebornAgain.png)

### DjangoSmoothy

![Screenshot](screenshots/DjangoSmoothy.png)

### Doom One

![Screenshot](screenshots/doom_one.png)

### Doom Peacock

![Screenshot](screenshots/doom_peacock.png)

### DotGov

![Screenshot](screenshots/dot_gov.png)

### Dracula

![Screenshot](screenshots/dracula.png)

### Dracula+

![Screenshot](screenshots/Dracula+.png)

### Duckbones

![Screenshot](screenshots/duckbones.png)

### Duotone Dark

![Screenshot](screenshots/duotone_dark.png)

### Earthsong

![Screenshot](screenshots/earthsong.png)

### Elemental

![Screenshot](screenshots/elemental.png)

### Elementary

![Screenshot](screenshots/elementary.png)

### ENCOM

![Screenshot](screenshots/encom.png)

### Espresso

![Screenshot](screenshots/espresso.png)

### Espresso Libre

![Screenshot](screenshots/espresso_libre.png)

### Fairyfloss

![Screenshot](screenshots/fairyfloss.png)

### Fahrenheit

![Screenshot](screenshots/fahrenheit.png)

### Fideloper

![Screenshot](screenshots/fideloper.png)

### FirefoxDev

![Screenshot](screenshots/firefox_dev.png)

### Firewatch

![Screenshot](screenshots/firewatch.png)

### FishTank

![Screenshot](screenshots/fish_tank.png)

### Flat

![Screenshot](screenshots/flat.png)

### Flatland

![Screenshot](screenshots/flatland.png)

### Floraverse

![Screenshot](screenshots/floraverse.png)

### Forest Blue

![Screenshot](screenshots/forest_blue.png)

### Framer

![Screenshot](screenshots/framer.png)

### FrontEndDelight

![Screenshot](screenshots/front_end_delight.png)

### FunForrest

![Screenshot](screenshots/fun_forrest.png)

### Galaxy

![Screenshot](screenshots/galaxy.png)

### Galizur

![image](screenshots/galizur.png)

### Github

![Screenshot](screenshots/github.png)

### GitHub Dark

![Screenshot](screenshots/GitHub_Dark.png)

### Glacier

![Screenshot](screenshots/glacier.png)

### Grape

![Screenshot](screenshots/grape.png)

### Grass

![Screenshot](screenshots/grass.png)

### Grey-green

![Screenshot](screenshots/Grey-green.png)

### Gruvbox Dark

![Screenshot](screenshots/gruvbox_dark.png)

### Gruvbox Dark Hard

![Screenshot](screenshots/gruvbox_dark_hard.png)

### Gruvbox Light

![Screenshot](screenshots/gruvbox_light.png)

### Guezwhoz

![Screenshot](screenshots/Guezwhoz.png)

### Hacktober

![Screenshot](screenshots/hacktober.png)

### Hardcore

![Screenshot](screenshots/hardcore.png)

### Harper

![Screenshot](screenshots/harper.png)

### HaX0R_R3D

![Screenshot](screenshots/HaX0R_R3D.png)

### HaX0R_GR33N

![Screenshot](screenshots/HaX0R_GR33N.png)

### HaX0R_BLUE

![Screenshot](screenshots/HaX0R_BLUE.png)

### Highway

![Screenshot](screenshots/highway.png)

### Hipster Green

![Screenshot](screenshots/hipster_green.png)

### Hivacruz

![Screenshot](screenshots/hivacruz.png)

### Homebrew

![Screenshot](screenshots/homebrew.png)

### Hopscotch

![Screenshot](screenshots/hopscotch.png)

### Hopscotch 256

![Screenshot](screenshots/hopscotch_256.png)

### Hurtado

![Screenshot](screenshots/hurtado.png)

### Hybrid

![Screenshot](screenshots/hybrid.png)

### IC_Green_PPL

![Screenshot](screenshots/ic_green_ppl.png)

### IC_Orange_PPL

![Screenshot](screenshots/ic_orange_ppl.png)

### iceberg

![Screenshot](screenshots/iceberg.png)

### IDEA Drak

![Screenshot](screenshots/idea.png)

### idleToes

![Screenshot](screenshots/idleToes.png)

### IR_Black

![Screenshot](screenshots/ir_black.png)

### Jackie Brown

![Screenshot](screenshots/jackie_brown.png)

### Japanesque

![Screenshot](screenshots/japanesque.png)

### Jellybeans

![Screenshot](screenshots/jellybeans.png)

### JetBrains Darcula

![Screenshot](screenshots/jetbrains_darcula.png)

### Jubi

![Screenshot](screenshots/jubi.png)

### Kanagawabones

![Screenshot](screenshots/kanagawabones.png)

### Kibble

![Screenshot](screenshots/kibble.png)

### Kolorit

![Screenshot](screenshots/kolorit.png)

### Konsolas

![Screenshot](screenshots/konsolas.png)

### Lab Fox

![Screenshot](screenshots/lab_fox.png)

### Laser

![Screenshot](screenshots/laser.png)

### Later This Evening

![Screenshot](screenshots/later_this_evening.png)

### Lavandula

![Screenshot](screenshots/lavandula.png)

### LiquidCarbon

![Screenshot](screenshots/liquid_carbon.png)

### LiquidCarbonTransparent

![Screenshot](screenshots/liquid_carbon_transparent.png)

### LiquidCarbonTransparentInverse

![Screenshot](screenshots/liquid_carbon_transparent_inverse.png)

### LoveLace

![Screenshot](screenshots/LoveLace.png)

### Man Page

![Screenshot](screenshots/man_page.png)

### Mariana

![Screenshot](screenshots/mariana.png)

### Material

![Screenshot](screenshots/material.png)

### MaterialDark

![Screenshot](screenshots/material_dark.png)

### MaterialDarker

![Screenshot](screenshots/material_darker.png)

### MaterialDesignColors

![Screenshot](screenshots/material_design_colors.png)

### MaterialOcean

![Screenshot](screenshots/material_ocean.png)

### Mathias

![Screenshot](screenshots/mathias.png)

### Matrix

![Screenshot](screenshots/matrix.png)

### Dark Matrix

![Screenshot](screenshots/darkmatrix.png)

### Darker Matrix

![Screenshot](screenshots/darkermatrix.png)

### Medallion

![Screenshot](screenshots/medallion.png)

### Midnight In Mojave

![Screenshot](screenshots/midnight_in_mojave.png)

### Mirage

![Screenshot](screenshots/mirage.png)

### Misterioso

![Screenshot](screenshots/misterioso.png)

### Molokai

![Screenshot](screenshots/molokai.png)

### MonaLisa

![Screenshot](screenshots/mona_lisa.png)

### Monokai Remastered

![Screenshot](screenshots/monokai_remastered.png)

### Monokai Soda

![Screenshot](screenshots/monokai_soda.png)

### Monokai Vivid

![Screenshot](screenshots/monokai_vivid.png)

### N0tch2k

![Screenshot](screenshots/n0tch2k.png)

### Neobones Dark

![Screenshot](screenshots/neobones_dark.png)

### Neobones Light

![Screenshot](screenshots/neobones_light.png)

### Neon

![Screenshot](screenshots/neon.png)

### Neopolitan

![Screenshot](screenshots/neopolitan.png)

### Neutron

![Screenshot](screenshots/neutron.png)

### NightLion v1

![Screenshot](screenshots/nightlion_v1.png)

### NightLion v2

![Screenshot](screenshots/nightlion_v2.png)

### Night Owlish Light

![Screenshot](screenshots/night_owlish_light.png)

### Novel

![Screenshot](screenshots/novel.png)

### Nocturnal Winter

![Screenshot](screenshots/nocturnal_winter.png)

### Nord

![Screenshot](screenshots/nord.png)

### Nord-light

![Screenshot](screenshots/nord_light.png)

### Obsidian

![Screenshot](screenshots/obsidian.png)

### Ocean

![Screenshot](screenshots/ocean.png)

### OceanicMaterial

![Screenshot](screenshots/oceanic_material.png)

### Oceanic Next

![Screenshot](screenshots/oceanic_next.png)

### Ollie

![Screenshot](screenshots/ollie.png)

### One Half Dark

![Screenshot](screenshots/onehalfdark.png)

### One Half Light

![Screenshot](screenshots/onehalflight.png)

### Operator Mono Dark

![Screenshot](screenshots/operator_mono_dark.png)

### Overnight Slumber

![Screenshot](screenshots/overnight_slumber.png)

### Palenight High Contrast

![Screenshot](screenshots/PaleNightHC.png)

### Pandora

![Screenshot](screenshots/pandora.png)

### Paraiso Dark

![Screenshot](screenshots/paraiso_dark.png)

### PaulMillr

![Screenshot](screenshots/paul_millr.png)

### Pencil Dark

![Screenshot](screenshots/pencil_dark.png)

### Pencil Light

![Screenshot](screenshots/pencil_light.png)

### Peppermint

![Screenshot](screenshots/Peppermint.png)

### Piatto Light

![Screenshot](screenshots/piatto_light.png)

### Pnevma

![Screenshot](screenshots/pnevma.png)

### Popping and Locking

![Screenshot](screenshots/Popping_and_Locking.png)

### Primary

![Screenshot](screenshots/primary.png)

### Pro

![Screenshot](screenshots/pro.png)

### Pro Light

![Screenshot](screenshots/pro_light.png)

### Purple Peter

![Screenshot](screenshots/purplepeter.png)

### Purple Rain

![Screenshot](screenshots/purple_rain.png)

### Rapture

![Screenshot](screenshots/rapture.png)

### Raycast Dark

![Screenshot](screenshots/raycast_dark.png)

### Raycast Light

![Screenshot](screenshots/raycast_light.png)

### Rebecca

![Screenshot](screenshots/rebecca.png)

### Red Alert

![Screenshot](screenshots/red_alert.png)

### Red Planet

![Screenshot](screenshots/red_planet.png)

### Red Sands

![Screenshot](screenshots/red_sands.png)

### Relaxed

![Screenshot](screenshots/relaxed.png)

### Retro

![Screenshot](screenshots/Retro.png)

### Rippedcasts

![Screenshot](screenshots/rippedcasts.png)

### Rouge 2

![Screenshot](screenshots/rouge_2.png)

### Royal

![Screenshot](screenshots/royal.png)

### Ryuuko

![Screenshot](screenshots/ryuuko.png)

### Sakura

![Screenshot](screenshots/sakura.png)

### Scarlet Protocol

![Screenshot](screenshots/scarlet_protocol.png)

### Seafoam Pastel

![Screenshot](screenshots/seafoam_pastel.png)

### SeaShells

![Screenshot](screenshots/sea_shells.png)

### Seoulbones Dark

![Screenshot](screenshots/seoulbones_dark.png)

### Seoulbones Light

![Screenshot](screenshots/seoulbones_light.png)

### Seti

![Screenshot](screenshots/seti.png)

### Shaman

![Screenshot](screenshots/shaman.png)

### Shades-Of-Purple

![Screenshot](screenshots/ShadesOfPurple.png)

### Slate

![Screenshot](screenshots/slate.png)

### SleepyHollow

![Screenshot](screenshots/SleepyHollow.png)

### Smyck

![Screenshot](screenshots/smyck.png)

### Snazzy

![Screenshot](screenshots/snazzy.png)

### SoftServer

![Screenshot](screenshots/soft_server.png)

### Solarized Darcula (With background image)

![Screenshot](screenshots/solarized_darcula_with_background.png)

### Solarized Darcula (Without background image)

![Screenshot](screenshots/solarized_darcula.png)

### Solarized Dark - Patched

Some applications assume the ANSI color code 8 is a gray color. Solarized treats
this code as equal to the background. This theme is for people who prefer the
former. See issues [#59][issue-59], [#62][issue-62], and [#63][issue-63] for
more information.

![Screenshot](screenshots/solarized_dark_patched.png)

[issue-59]: https://github.com/mbadolato/iTerm2-Color-Schemes/issues/59
[issue-62]: https://github.com/mbadolato/iTerm2-Color-Schemes/issues/62
[issue-63]: https://github.com/mbadolato/iTerm2-Color-Schemes/pull/63

### Solarized Dark Higher Contrast

![Screenshot](screenshots/solarized_dark_higher_contrast.png)

### SpaceGray

![Screenshot](screenshots/space_gray.png)

### SpaceGray Eighties

![Screenshot](screenshots/spacegray_eighties.png)

### SpaceGray Eighties Dull

![Screenshot](screenshots/spacegray_eighties_dull.png)

### Spacedust

![Screenshot](screenshots/spacedust.png)

### Spiderman

![Screenshot](screenshots/spiderman.png)

### Spring

![Screenshot](screenshots/spring.png)

### Square

![Screenshot](screenshots/square.png)

### Sublette

![Screenshot](screenshots/sublette.png)

### Subliminal

![Screenshot](screenshots/subliminal.png)

### Sundried

![Screenshot](screenshots/sundried.png)

### Symfonic

![Screenshot](screenshots/symfonic.png)

### synthwave

![Screenshot](screenshots/synthwave.png)

### Synthwave Alpha

![Screenshot](screenshots/synthwave_alpha.png)

### Synthwave Everything

![Screenshot](screenshots/synthwave-everything.png)

### Tango Adapted

![Screenshot](screenshots/tango_adapted.png)

### Tango Half Adapted

![Screenshot](screenshots/tango_half_adapted.png)

### Teerb

![Screenshot](screenshots/teerb.png)

### Terminal Basic

![Screenshot](screenshots/terminal_basic.png)

### Thayer Bright

![Screenshot](screenshots/thayer_bright.png)

### The Hulk

![Screenshot](screenshots/the_hulk.png)

### Tinacious Design (Dark)

![Screenshot](screenshots/tinacious_design_dark.png)

### Tinacious Design (Light)

![Screenshot](screenshots/tinacious_design_light.png)

### TokyoNight

![Screenshot](screenshots/tokyonight.png)

### TokyoNight Storm

![Screenshot](screenshots/tokyonight-storm.png)

### TokyoNight Day

![Screenshot](screenshots/tokyonight-day.png)

### Tomorrow

![Screenshot](screenshots/tomorrow.png)

### Tomorrow Night

![Screenshot](screenshots/tomorrow_night.png)

### Tomorrow Night Blue

![Screenshot](screenshots/tomorrow_night_blue.png)

### Tomorrow Night Bright

![Screenshot](screenshots/tomorrow_night_bright.png)

### Tomorrow Night Eighties

![Screenshot](screenshots/tomorrow_night_eighties.png)

### Tomorrow Night Burns

![Screenshot](screenshots/tomorrow_night_burns.png)

### ToyChest

![Screenshot](screenshots/toy_chest.png)

### Treehouse

![Screenshot](screenshots/treehouse.png)

### Twilight

![Screenshot](screenshots/twilight.png)

### Ubuntu

![Screenshot](screenshots/ubuntu.png)

### UltraViolent

![Screenshot](screenshots/ultra_violent.png)

### UltraDark

![Screenshot](screenshots/ultradark.png)

### Under The Sea

![Screenshot](screenshots/under_the_sea.png)

### Unikitty

![Screenshot](screenshots/unikitty.png)

### Urple

![Screenshot](screenshots/urple.png)

### Vaughn

![Screenshot](screenshots/vaughn.png)

### VibrantInk

![Screenshot](screenshots/vibrant_ink.png)

### Vimbones

![Screenshot](screenshots/vimbones.png)

### Violet Light

![Screenshot](screenshots/violet_light.png)

### Violet Dark

![Screenshot](screenshots/violet_dark.png)

### WarmNeon

![Screenshot](screenshots/warm_neon.png)

### Wez

![Screenshot](screenshots/wez.png)

### Whimsy

![Screenshot](screenshots/whimsy.png)

### WildCherry

![Screenshot](screenshots/wild_cherry.png)

### Wilmersdorf

![Screenshot](screenshots/wilmersdorf.png)

### Wombat

![Screenshot](screenshots/wombat.png)

### Wryan

![Screenshot](screenshots/wryan.png)

### Zenbones

![Screenshot](screenshots/zenbones.png)

### Zenbones Dark

![Screenshot](screenshots/zenbones_dark.png)

### Zenbones Light

![Screenshot](screenshots/zenbones_light.png)

### Zenburn

![Screenshot](screenshots/zenburn.png)

### Zenburned

![Screenshot](screenshots/zenburned.png)

### Zenwritten Dark

![Screenshot](screenshots/zenwritten_dark.png)

### Zenwritten Light

![Screenshot](screenshots/zenwritten_light.png)

## Credits

The schemes Novel, Espresso, Grass, Homebrew, Ocean, Pro, Man Page, Red Sands, and Terminal Basic are ports of the schemes of the same name included with the Mac Terminal application. All of Terminal's schemes have now been ported, with the exception of "Solid Colors" (random backgrounds, which iTerm doesn't support) and "Aerogel" (which is hideous).

Credits for all other themes are listed in [CREDITS.md](./CREDITS.md)

If there are other color schemes you'd like to see included, drop me a line!

## Extra

### X11 Installation

To install under the [X Window System](https://www.x.org/):

- Import the .xrdb file of the scheme you'd like to use:

        #include "/home/mbadolato/iTerm2-Color-Schemes/xrdb/Blazer.xrdb"

- Use the `#define`s provided by the imported .xrdb file:

        Rxvt*color0:       Ansi_0_Color
        Rxvt*color1:       Ansi_1_Color
        Rxvt*color2:       Ansi_2_Color
        Rxvt*color3:       Ansi_3_Color
        Rxvt*color4:       Ansi_4_Color
        Rxvt*color5:       Ansi_5_Color
        Rxvt*color6:       Ansi_6_Color
        Rxvt*color7:       Ansi_7_Color
        Rxvt*color8:       Ansi_8_Color
        Rxvt*color9:       Ansi_9_Color
        Rxvt*color10:      Ansi_10_Color
        Rxvt*color11:      Ansi_11_Color
        Rxvt*color12:      Ansi_12_Color
        Rxvt*color13:      Ansi_13_Color
        Rxvt*color14:      Ansi_14_Color
        Rxvt*color15:      Ansi_15_Color
        Rxvt*colorBD:      Bold_Color
        Rxvt*colorIT:      Italic_Color
        Rxvt*colorUL:      Underline_Color
        Rxvt*foreground:   Foreground_Color
        Rxvt*background:   Background_Color
        Rxvt*cursorColor:  Cursor_Color

        XTerm*color0:      Ansi_0_Color
        XTerm*color1:      Ansi_1_Color
        XTerm*color2:      Ansi_2_Color
        XTerm*color3:      Ansi_3_Color
        XTerm*color4:      Ansi_4_Color
        XTerm*color5:      Ansi_5_Color
        XTerm*color6:      Ansi_6_Color
        XTerm*color7:      Ansi_7_Color
        XTerm*color8:      Ansi_8_Color
        XTerm*color9:      Ansi_9_Color
        XTerm*color10:     Ansi_10_Color
        XTerm*color11:     Ansi_11_Color
        XTerm*color12:     Ansi_12_Color
        XTerm*color13:     Ansi_13_Color
        XTerm*color14:     Ansi_14_Color
        XTerm*color15:     Ansi_15_Color
        XTerm*colorBD:     Bold_Color
        XTerm*colorIT:     Italic_Color
        XTerm*colorUL:     Underline_Color
        XTerm*foreground:  Foreground_Color
        XTerm*background:  Background_Color
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
Window > Apprearance
 Font: Consolas, bold, 14-point
 Font quality:
  ( ) Antialiased     ( ) Non-Antialiased
  (O) ClearType       ( ) Default
Window > Colours
 [X] Allow terminal to specify ANSI colours
 [X] Allow terminal to use xterm 256-colour mode
 Indicate bolded text by changing:
  ( ) The font   (O) The colour   ( ) Both
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

Copy the theme content from `alacritty/` and paste the content to your [alacritty config file](https://github.com/alacritty/alacritty/blob/master/alacritty.yml).

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

---

iTerm Color Schemes | iTerm2 Color Schemes | iTerm 2 Color Schemes | iTerm Themes | iTerm2 Themes | iTerm 2 Themes

[![Analytics](https://ga-beacon.appspot.com/UA-30661340-2/mbadolato/iTerm2-Color-Schemes?pixel)](https://github.com/igrigorik/ga-beacon)
