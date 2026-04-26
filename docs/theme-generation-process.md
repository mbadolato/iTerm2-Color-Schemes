# iTerm2 Color Scheme Generation Process

This document explains how the iTerm2 Color Schemes project generates color themes for various terminal emulators from iTerm2 color schemes.

## Overview

The project automates the conversion of iTerm2 color schemes (`.itermcolors` files) and YAML-defined schemes into formats compatible with over 20 terminal emulators and editors, including Alacritty, Kitty, WezTerm, VS Code, and many others.

The generation process is driven by a Python script (`tools/gen.py`) that uses Jinja2 templating to transform color data into target format files.

## Key Components

### 1. Source Files

Themes can be sourced from two locations:

- **`schemes/` directory**: Contains original iTerm2 `.itermcolors` files (binary plist format).
- **`yaml/` directory**: Contains YAML files with color definitions, often derived from other sources.

### 2. Generation Script (`tools/gen.py`)

This Python script orchestrates the entire process:

1. **Loads iTerm2 schemes**: Parses `.itermcolors` plist files to extract color data.
2. **Loads YAML schemes**: Reads YAML files with color specifications.
3. **Processes themes**: Converts raw color data into `Theme` objects with standardized color representations (hex, RGB, etc.).
4. **Applies templates**: Uses Jinja2 templating to generate output files for each supported format.
5. **Generates JSON data**: Creates `schemes.jsonl` with all theme data in JSON Lines format.

### 3. Templates (`tools/templates/`)

Each target format has a corresponding Jinja2 template file. Templates contain placeholders for color values, such as:

```
color0 #{{ Ansi_0_Color.hex }}
color1 #{{ Ansi_1_Color.hex }}
...
background #{{ Background_Color.hex }}
foreground #{{ Foreground_Color.hex }}
```

The script generates one output file per theme per template.

### 4. Output Structure

Generated files are organized in subdirectories named after the template:

- `alacritty/` - Alacritty configuration files
- `kitty/` - Kitty configuration files
- `wezterm/` - WezTerm configuration files
- And 20+ others

Each subdirectory contains theme files named after the scheme (e.g., `kitty/Dracula.conf`).

## Theme Data Model

Each theme is represented as a `Theme` object containing:

- **Colors**: Dictionary of color names (e.g., "Background Color", "Ansi 0 Color") mapped to `Color` objects
- **Metadata**: Scheme name, author, variant (Dark/Light), and derived properties like `dark_theme`

Colors support multiple formats:
- Hex: `#ff0000`
- RGB: `255,0,0`
- Hexshell: `ff/00/00` (for some formats)

## Generation Workflow

1. **Collect schemes**: Scan `schemes/*.itermcolors` and `yaml/*.yml` files
2. **Parse colors**: Extract and normalize color data, handling color spaces (sRGB, P3)
3. **Apply fallbacks**: Ensure all required colors are defined, using defaults where needed
4. **Determine variants**: Classify themes as "Dark" or "Light" based on background brightness
5. **Render templates**: For each scheme and template combination, substitute color placeholders
6. **Output files**: Write generated content to appropriate subdirectories with proper permissions
7. **Export JSON**: Compile all theme data into `schemes.jsonl` for programmatic access

## Adding New Themes

### From iTerm2

1. Export theme from iTerm2 as `.itermcolors` file
2. Place in `schemes/` directory
3. Run generation: `python3 tools/gen.py`

### From Other Sources

1. Convert to YAML format (see `tools/kitty_to_yaml.py` or `tools/ghostty_to_yaml.py` as examples)
2. Place YAML file in `yaml/` directory
3. Run generation

## YAML Format Specification

Themes in the `yaml/` directory use a YAML format based on the [Gogh](https://github.com/Gogh-Co/Gogh/) specification, with additional optional keys.

### Required Colors

The basic color mapping follows the standard terminal color palette:

```yaml
background: "#282a36"
foreground: "#f8f8f2"
color_01: "#000000"  # black
color_02: "#ff5555"  # red
color_03: "#50fa7b"  # green
color_04: "#f1fa8c"  # yellow
color_05: "#bd93f9"  # blue
color_06: "#ff79c6"  # magenta
color_07: "#8be9fd"  # cyan
color_08: "#bbbbbb"  # white
color_09: "#ff5555"  # bright red
color_10: "#50fa7b"  # bright green
color_11: "#f1fa8c"  # bright yellow
color_12: "#bd93f9"  # bright blue
color_13: "#ff79c6"  # bright magenta
color_14: "#8be9fd"  # bright cyan
color_15: "#ffffff"  # bright white
color_16: "#f8f8f2"  # additional color
```

### Optional Metadata and Colors

Additional optional keys:

- `name`: Theme name (defaults to filename)
- `author`: Theme author
- `variant`: "Dark" or "Light" (auto-detected if not specified)
- `badge`: Badge color
- `bold`: Bold text color (defaults to `foreground`)
- `cursor`: Cursor color
- `cursor_guide`: Cursor guide color (defaults to `cursor`)
- `cursor_text`: Cursor text color (defaults to `foreground`)
- `link`: Link color
- `selection`: Selection background color (defaults to `foreground`)
- `selection_text`: Selection text color (defaults to `background`)
- `tab`: Tab color
- `underline`: Underline color

### Example YAML File

```yaml
name: Dracula
author: Dracula Team
variant: Dark

background: "#282a36"
foreground: "#f8f8f2"
cursor: "#f8f8f2"
selection: "#44475a"

color_01: "#000000"
color_02: "#ff5555"
# ... etc
```

## Adding New Output Formats

1. Create a Jinja2 template in `tools/templates/` with appropriate placeholders
2. Add the template name to the generation script (or use `-t` flag)
3. Run generation to produce output in a new subdirectory

## Usage

### Generate All Themes

```bash
python3 tools/gen.py
```

### Generate Specific Schemes

```bash
python3 tools/gen.py -s Dracula -s Nord
```

### Generate Specific Templates

```bash
python3 tools/gen.py -t kitty -t alacritty
```

### Full Generation without Docker

To perform the complete generation workflow without Docker (ideal for macOS users needing full support including Apple Terminal.app themes), use the provided script:

```bash
./generate-all-nodocker.sh
```

This script automates the entire process:

1. **Setup virtual environment**: Creates a Python virtual environment (`.venv`) if it doesn't exist and activates it.
2. **Install dependencies**: Upgrades `pip` and installs all required packages from `requirements.txt`.
3. **Theme generation**: Changes to the `tools/` directory and runs `./gen.py` (or `python gen.py`) to generate theme files for all supported formats in their respective directories (e.g., `alacritty/`, `kitty/`, etc.).
4. **Terminal theme generation**: Runs `python iterm2terminal.py ../schemes ../terminal` to convert iTerm2 schemes into Apple Terminal.app profile files (`.terminal` format) in the `terminal/` directory.
5. **Screenshot generation**: Runs `python -m screenshot_gen` to generate preview screenshots of themes in the `screenshots/` directory.
6. **README updates**: Runs `python generate_screenshots_readme.py` to update the screenshots section in `README.md` with the newly generated images.

**Prerequisites**: 
- Python 3.8+ and `pip` installed on the host system.
- For screenshot generation: ImageMagick, a compatible terminal emulator (e.g., iTerm2), and other tools as specified in `screenshot_gen/` setup instructions.
- macOS recommended for `iterm2terminal.py` and screenshot generation due to native dependencies.

This script ensures a self-contained environment and handles the full workflow locally.

### Using Docker (alternative)

```bash
./generate-all.sh
```

This builds a Docker container and runs the generation process inside it, including:

1. **Theme generation**: Executes `tools/gen.py` to generate all theme files
2. **Screenshot generation**: Runs the screenshot generator to create theme previews
3. **README updates**: Updates the screenshots section in README.md

Note: The Docker-based process skips the Apple Terminal.app theme generation step (`tools/iterm2terminal.py`), as it requires macOS-specific tools not available in the container. It also assumes screenshot generation works in the Linux-based Docker environment (may require adjustments for full compatibility). Use the no-Docker script for complete macOS-native support.

#### Docker Debugging

To debug issues within the Docker container:

```bash
./generate-all.sh debug
```

This starts an interactive shell inside the container for troubleshooting.

#### Docker Image Details

- **Base image**: Based on the Dockerfile in the repository root
- **Working directory**: `/colors` (mounted from the host project directory)
- **Image tag**: `itermcolors:latest`
- **Dependencies**: All Python requirements are pre-installed in the container

## Dependencies

- Python 3.8+
- `pyyaml`
- `jinja2`
- `rich` (for progress bars)

Install via: `pip install -r requirements.txt`

## Helper Tools

- `kitty_to_yaml.py`: Convert Kitty configuration files to YAML format for easy inclusion as source themes.
- `ghostty_to_yaml.py`: Convert Ghostty configuration files to YAML format for inclusion as source themes.
- `iterm2terminal.py`: Convert iTerm2 `.itermcolors` schemes to Apple Terminal.app profile files (`.terminal` format) placed in the `terminal/` directory.
- `generate_screenshots_readme.py`: Script to automatically embed the latest generated screenshots into the `README.md` file's screenshots section.
- `screenshot_gen/`: Module for generating visual previews of themes; requires setup with tools like ImageMagick and a terminal emulator (see documentation for details).

## JSON Data Format

The `schemes.jsonl` file contains one JSON object per line, each representing a theme:

```json
{
  "scheme_name": "Dracula",
  "variant": "Dark",
  "author": "",
  "Dark_Theme": true,
  "Background_Color": {"hex": "282a36", "rgb": "40,42,54", ...},
  "Foreground_Color": {"hex": "f8f8f2", "rgb": "248,248,242", ...},
  // ... all colors
}
```

This format is useful for programmatic access to theme data.