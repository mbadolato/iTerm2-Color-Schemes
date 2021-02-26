#!/usr/bin/env python3

# This script converts xrdb (X11) color scheme format to
# the new Windows Terminal color scheme format
#
# Usage:
# xrdb2windowsterminal.py path/to/xrdb/files -d /windowsterminal/output

import os
import re
import argparse
from xrdbparser import Xrdb


def process_file(data):
    # map to Windows Terminal names
    pairs = [
        ("background", "Background_Color"),
        ("foreground", "Foreground_Color"),
        ("cursorColor", "Cursor_Color"),
        ("selectionBackground", "Selection_Color")
    ]

    ansi = [
        "black",
        "red",
        "green",
        "yellow",
        "blue",
        "purple",
        "cyan",
        "white",
        "brightBlack",
        "brightRed",
        "brightGreen",
        "brightYellow",
        "brightBlue",
        "brightPurple",
        "brightCyan",
        "brightWhite",
    ]

    lines = ""
    for i, name in enumerate(ansi):
        color = data.colors[i]
        if color:
            lines += f',\n  "{name}": "{color}"'

    for windowsterminal, xrdb in pairs:
        color = getattr(data, xrdb, None)
        if color:
            lines += f',\n  "{windowsterminal}": "{color}"'

    lines.rstrip(",")

    return f'''{{
  "name": "{data.name}"{lines}
}}
'''


def main(xrdb_path, output_path=None):
    for data in Xrdb.parse_all(xrdb_path):
        output = process_file(data)
        if not output_path:
            print(output)
        else:
            dest = os.path.join(output_path, data.name)
            with open('{0}.json'.format(dest), 'w+') as f:
                f.write(output)


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description='Translate X color schemes to Windows Terminal format')
    parser.add_argument('xrdb_path', type=str, help='path to xrdb files')
    parser.add_argument('-d', '--destiny', type=str, dest='output_path',
                        help='path where Windows Terminal config files will be' +
                        ' created, if not provided then will be printed')

    args = parser.parse_args()

    main(args.xrdb_path, args.output_path)
