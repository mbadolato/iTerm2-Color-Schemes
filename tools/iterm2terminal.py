#!/usr/bin/env python3

# Python script to convert iTerm2 themes to Terminal.app themes
#
# Usage:
# python3 -m iterm2terminal /path/to/itermcolors/file /path/to/target/directory

import plistlib

from argparse import ArgumentParser
from pathlib import Path

RED = "Red Component"
GREEN = "Green Component"
BLUE = "Blue Component"

mappings = {
    "Ansi 0 Color": "ANSIBlackColor",
    "Ansi 1 Color": "ANSIRedColor",
    "Ansi 2 Color": "ANSIGreenColor",
    "Ansi 3 Color": "ANSIYellowColor",
    "Ansi 4 Color": "ANSIBlueColor",
    "Ansi 5 Color": "ANSIMagentaColor",
    "Ansi 6 Color": "ANSICyanColor",
    "Ansi 7 Color": "ANSIWhiteColor",
    "Ansi 8 Color": "ANSIBrightBlackColor",
    "Ansi 9 Color": "ANSIBrightRedColor",
    "Ansi 10 Color": "ANSIBrightGreenColor",
    "Ansi 11 Color": "ANSIBrightYellowColor",
    "Ansi 12 Color": "ANSIBrightBlueColor",
    "Ansi 13 Color": "ANSIBrightMagentaColor",
    "Ansi 14 Color": "ANSIBrightCyanColor",
    "Ansi 15 Color": "ANSIBrightWhiteColor",
    "Background Color": "BackgroundColor",
    "Foreground Color": "TextColor",
    "Bold Color": "TextBoldColor",
    "Selection Color": "SelectionColor",
    "Cursor Color": "CursorColor",
}


def rgb_dict_to_rgb_bytes(iterm_dict):
    r = iterm_dict[RED]
    g = iterm_dict[GREEN]
    b = iterm_dict[BLUE]

    rgb = f"{r} {g} {b}\x00"

    return bytes(rgb, "utf-8")


def create_color_entry(colors):
    rgb = rgb_dict_to_rgb_bytes(colors)
    plist = {
        "$version": 100000,
        "$objects": [
            "$null",
            {
                "NSRGB": rgb,
                "NSColorSpace": 2,
                "$class": plistlib.UID(2)
            },
            {
                "$classname": "NSColor",
                "$classes": ["NSColor", "NSObject"]
            }
        ],
        "$archiver": "NSKeyedArchiver",
        "$top": {"root": plistlib.UID(1)}
    }

    return plistlib.dumps(plist, fmt=plistlib.FMT_BINARY, sort_keys=False)


def convert(source, target):
    source_path = (Path(source)).resolve()
    if not source_path.exists():
        raise FileNotFoundError(f"Source file {source_path} does not exist")

    target_path = (Path(target)).resolve()
    if not target_path.exists():
        raise FileNotFoundError(f"Target directory {target_path} does not exist")

    target_filename = f"{source_path.stem}.terminal"
    target_path = (target_path / target_filename).resolve()

    with open(source_path, "rb") as file:
        iterm = plistlib.load(file)

    terminal = {
        "name": source_path.stem,
        "type": "Window Settings",
        "ProfileCurrentVersion": 2.04,
        "columnCount": 90,
        "rowCount": 50,
    }

    for key, value in iterm.items():
        if key in mappings:
            terminal.update({mappings.get(key): create_color_entry(value)})

    with open(target_path, "wb") as output_file:
        plistlib.dump(terminal, output_file)


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("source", help="Location of .itermcolors file to convert")
    parser.add_argument("target", help="Directory in which to save Terminal.app color scheme")
    args = parser.parse_args()

    try:
        convert(args.source, args.target)
    except FileNotFoundError as e:
        print(e)
        exit(1)
