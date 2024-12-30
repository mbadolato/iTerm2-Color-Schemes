import json
import re
import string
from pathlib import Path

screenshot_gen_path = Path(__file__).parent
repo_path = screenshot_gen_path.parent.parent
screenshot_font_path = screenshot_gen_path / "screenshot_font.png"
schemes_jsonl_path = repo_path / "schemes.jsonl"
screenshots_path = repo_path / "screenshots"

font_charset = ";" + string.digits + string.ascii_letters


def hex_color_to_rgb(hex_color):
    return tuple(int(hex_color[i : i + 2], 16) for i in (0, 2, 4))


def read_schemes_jsonl():
    schemes = {}
    with schemes_jsonl_path.open("r", encoding="utf-8") as inf:
        for line in inf:
            data = json.loads(line)
            schemes[data["scheme_name"]] = data
    return schemes


# This maps the generated filenames to the legacy names found
# in the screenshot directory. You probably don't need to edit this,
# but it could be removed in the future if the legacy names are
# no longer required.
filename_map = {
    "apple_classic": "apple-classic",
    "apple_system_colors": "apple-system-colors",
    "atelier_sulphurpool": "atelier-sulphurpool_dark",
    "blue_berry_pie": "blueberry_pie",
    "blue_dolphin": "BlueDolphin",
    "coffee_theme": "Coffee",
    "cutie_pro": "CutiePro",
    "dark+": "dark_plus",
    "django_reborn_again": "DjangoRebornAgain",
    "django_smooth": "DjangoSmoothy",
    "embers-dark": "embers",
    "firefly_traditional": "firefly-traditional",
    "gruvbox-material": "gruvbox_material",
    "hopscotch.256": "hopscotch_256",
    "iceberg-dark": "iceberg",
    "idle_toes": "idleToes",
    "iterm2_dark_background": "iterm2-dark-background",
    "iterm2_default": "iterm2-default",
    "iterm2_light_background": "iterm2-light-background",
    "iterm2_pastel_dark_background": "iterm2-pastel-dark-background",
    "iterm2_smoooooth": "iterm2-smoooooth",
    "iterm2_solarized_dark": "iterm2-solarized-dark",
    "iterm2_solarized_light": "iterm2-solarized-light",
    "iterm2_tango_dark": "iterm2-tango-dark",
    "iterm2_tango_light": "iterm2-tango-light",
    "kanagawa_dragon": "kanagawa-dragon",
    "kanagawa_wave": "kanagawa-wave",
    "midnight-in-mojave": "midnight_in_mojave",
    "night_lion_v1": "nightlion_v1",
    "night_lion_v2": "nightlion_v2",
    "nord-light": "nord_light",
    "nvim_dark": "NvimDark",
    "nvim_light": "NvimLight",
    "oceanic-next": "oceanic_next",
    "one_half_dark": "onehalfdark",
    "one_half_light": "onehalflight",
    "pale_night_hc": "PaleNightHC",
    "retro_legends": "RetroLegends",
    "shades-of-purple": "ShadesOfPurple",
    "sleepy_hollow": "SleepyHollow",
    "spacegray": "space_gray",
    "tokyonight_moon": "tokyonight-moon",
    "tokyonight_night": "tokyonight-night",
    "ultra_dark": "ultradark",
}


def get_screenshot_filename(name):
    name = name.replace(" - ", " ")
    name = re.sub(r"[()]", "", name)
    name = re.sub(r"([a-z])([A-Z])", r"\1 \2", name)
    name = re.sub(r"\s+", "_", name.lower())
    name = name.replace("i_term2", "iterm2")
    name = name.replace("git_hub", "github")
    name = name.replace("jet_brains", "jetbrains")
    name = name.replace("space_gray", "spacegray")
    name = name.replace("ha_x0r", "hax0r")
    return filename_map.get(name, name)
