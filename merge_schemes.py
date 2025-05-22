import json
import os

# Local folder where all the color scheme JSON files are stored
theme_dir = r"C:\Users\Taylor\Terminal\Schemes\windowsterminal"

# List the color scheme JSON filenames you want to include
selected_themes = [
    "Novel.json",
    "Espresso.json",
    "Grass.json",
    "Homebrew.json",
    "Ocean.json",
    "Pro.json",
    "Man Page.json",
    "Red Sands.json",
    "Terminal Basic.json",
    "rose-pine.json",
    "Dracula.json",
    "Gruvbox Dark.json",            # Ensure this file exists
    "12-bit Rainbow.json",
    "Galaxy.json",
    "GitHub Dark.json",
    "GitHub-Dark-Colorblind.json",
    "GitHub-Dark-Default.json",
    "iTerm2 Smoooooth.json",
    "iTerm2 Dark Background.json",
    "rose-pine-dawn.json",
    "rose-pine-moon.json"
]

combined_schemes = []

for theme_file in selected_themes:
    path = os.path.join(theme_dir, theme_file)
    if os.path.exists(path):
        with open(path, "r") as f:
            try:
                theme_json = json.load(f)
                combined_schemes.append(theme_json)
            except json.JSONDecodeError:
                print(f"❌ Error decoding {theme_file}")
    else:
        print(f"❌ {theme_file} not found in directory!")

# Output to a file
with open("selected_schemes.json", "w") as out_file:
    json.dump(combined_schemes, out_file, indent=4)

print("✅ Done! Copy the contents of 'selected_schemes.json' into your settings.json under \"schemes\".")
