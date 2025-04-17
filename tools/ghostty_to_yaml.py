# Convert a Ghostty configuration fragment to the YAML spec.

import re
import sys

ghostty_to_yaml_map = {
    "background": "background",
    "cursor-color": "cursor",
    "cursor-text": "cursor_text",
    "foreground": "foreground",
    "selection-background": "selection",
    "selection-foreground": "selection_text",
}

yaml_data = {}

for line in sys.stdin:
    line = re.sub(r"#\s+.*", "", line).strip()  # Yeet comments
    if not line:
        continue
    key, _, value = line.partition(" = ")
    if key == "palette":
        ansi, _, hex = value.partition("=")
        yaml_data[f"color_{int(ansi) + 1:02d}"] = hex
    elif key in ghostty_to_yaml_map:
        yaml_data[ghostty_to_yaml_map[key]] = value
    else:
        print(f"Skipping: {key!r} = {value!r}", file=sys.stderr)

for key, value in sorted(yaml_data.items()):
    print(f'{key}: "{value}"')
