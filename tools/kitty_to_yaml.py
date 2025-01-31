# Convert a Kitty .conf to the YAML spec.

import re
import sys

kitty_to_yaml_map = {
    "color0": "color_01",
    "color1": "color_02",
    "color2": "color_03",
    "color3": "color_04",
    "color4": "color_05",
    "color5": "color_06",
    "color6": "color_07",
    "color7": "color_08",
    "color8": "color_09",
    "color9": "color_10",
    "color10": "color_11",
    "color11": "color_12",
    "color12": "color_13",
    "color13": "color_14",
    "color14": "color_15",
    "color15": "color_16",
    "foreground": "foreground",
    "background": "background",
    "selection_foreground": "selection_text",
    "selection_background": "selection",
    "cursor": "cursor",
    "cursor_text_color": "cursor_text",
}

conf = {}

for line in sys.stdin:
    line = re.sub(r"#\s+.*", "", line).strip()  # Yeet comments
    if not line:
        continue
    bits = line.split(None, 1)
    conf[bits[0]] = bits[1]

yaml_data = {}

for key, value in conf.items():
    if key in kitty_to_yaml_map:
        value = conf.get(value, value)  # follow references
        if not value.startswith("#"):
            print(f"Malformed color value for {key!r}: {value!r}", file=sys.stderr)
            continue
        yaml_data[kitty_to_yaml_map[key]] = value
    else:
        print(f"Skipping: {key!r} = {value!r}", file=sys.stderr)

for key, value in sorted(yaml_data.items()):
    print(f'{key}: "{value}"')
