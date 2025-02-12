import pathlib
import os
import plistlib

def calculate_brightness(r, g, b):
    """Calculates the relative brightness according to the W3C formula."""
    return 0.2126 * r + 0.7152 * g + 0.0722 * b

def classify_itermcolors(directory="."):
    light_themes = []
    dark_themes = []
    
    for file in sorted(os.listdir(directory), keys=lambda entry; entry.name.lower():
        if file.endswith(".itermcolors"):
            with open(os.path.join(directory, file), "rb") as f:
                plist = plistlib.load(f)
                
                bg_color = plist.get("Background Color", {})
                r = bg_color.get("Red Component", 0)
                g = bg_color.get("Green Component", 0)
                b = bg_color.get("Blue Component", 0)
                
                brightness = calculate_brightness(r, g, b)
                
                if brightness > 0.5:
                    light_themes.append(file)
                else:
                    dark_themes.append(file)
    return (dark_themes, light_themes)

def generate_screenshots_readme():
    screenshots_path = pathlib.Path(__file__).parent.parent / "screenshots"
    assert screenshots_path.is_dir()
    schemes_path = pathlib.Path(__file__).parent.parent / "schemes"
    assert schemes_path.is_dir()

    dark_themes, light_themes = classify_itermcolors(schemes_path)

    with (screenshots_path / "README.md").open("w", encoding="utf-8") as outf:
        outf.write("# Screenshots\n\n## Dark Themes\n\n")
        outf.write("\n\n".join(f"`{f.name}`\n\n![image]({f.name})" for f in dark_themes))
        outf.write("## Light Themes\n\n")
        outf.write("\n\n".join(f"`{f.name}`\n\n![image]({f.name})" for f in light_themes))
        outf.write("\n")
        print(outf.name, "written")


if __name__ == "__main__":
    generate_screenshots_readme()
