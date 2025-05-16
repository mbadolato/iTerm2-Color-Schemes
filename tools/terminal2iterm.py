#!/usr/bin/env python3

# Python script to convert Terminal.app themes to iTerm2 themes
#
# Usage:
# python3 -m terminal2iterm /path/to/terminal/file /path/to/target/directory

import plistlib

from argparse import ArgumentParser
from pathlib import Path
from re import search

mappings = {
    "ANSIBlackColor": "Ansi 0 Color",
    "ANSIRedColor": "Ansi 1 Color",
    "ANSIGreenColor": "Ansi 2 Color",
    "ANSIYellowColor": "Ansi 3 Color",
    "ANSIBlueColor": "Ansi 4 Color",
    "ANSIMagentaColor": "Ansi 5 Color",
    "ANSICyanColor": "Ansi 6 Color",
    "ANSIWhiteColor": "Ansi 7 Color",
    "ANSIBrightBlackColor": "Ansi 8 Color",
    "ANSIBrightRedColor": "Ansi 9 Color",
    "ANSIBrightGreenColor": "Ansi 10 Color",
    "ANSIBrightYellowColor": "Ansi 11 Color",
    "ANSIBrightBlueColor": "Ansi 12 Color",
    "ANSIBrightMagentaColor": "Ansi 13 Color",
    "ANSIBrightCyanColor": "Ansi 14 Color",
    "ANSIBrightWhiteColor": "Ansi 15 Color",
    "BackgroundColor": "Background Color",
    "TextColor": "Foreground Color",
    "TextBoldColor": "Bold Color",
    "SelectionColor": "Selection Color",
    "CursorColor": "Cursor Color",
}


def rgb_plist_to_rgb_floats(terminal_plist):
    alpha = 1.0

    if 'NSRGB' in str(terminal_plist):
        rgb_values = search(r'NSRGB\': b\'(.*?)\\x00', str(terminal_plist)).group(1).split()
        r, g, b = rgb_values
    elif 'NSWhite' in str(terminal_plist):
        white_values = search(r'NSWhite\': b\'(.*?)\\x00', str(terminal_plist)).group(1).split()
        r = g = b = white_values[0]
        if len(white_values) > 1:
            alpha = white_values[1]
    else:
        raise ValueError("Unsupported color format")

    return map(float, (r, g, b, alpha))


def create_color_entry(colors):
    color_plist = plistlib.loads(colors, fmt=None, dict_type=dict)
    r, g, b, alpha = rgb_plist_to_rgb_floats(color_plist)
    dictionary = {
        "Alpha Component": alpha,
        "Blue Component": b,
        "Color Space": 'sRGB',
        "Green Component": g,
        "Red Component": r,
    }

    return dictionary


def convert(source, target):
    source_path = (Path(source)).resolve()
    if not source_path.exists():
        raise FileNotFoundError(f"Source file {source_path} does not exist")

    target_path = (Path(target)).resolve()
    if not target_path.exists():
        raise FileNotFoundError(f"Target directory {target_path} does not exist")

    target_filename = f"{source_path.stem}.itermcolors"
    target_path = (target_path / target_filename).resolve()

    with open(source_path, "rb") as file:
        terminal = plistlib.load(file)

    iterm = {}

    for key, value in terminal.items():
        if key in mappings:
            iterm.update({mappings.get(key): create_color_entry(value)})

    with open(target_path, "wb") as output_file:
        plistlib.dump(iterm, output_file)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("source", help="Location of .terminal file to convert")
    parser.add_argument("target", help="Directory in which to save iTerm2 color scheme")
    args = parser.parse_args()

    try:
        convert(args.source, args.target)
    except FileNotFoundError as e:
        print(e)
        exit(1)
