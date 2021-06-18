#!/usr/bin/env python3

# This script converts xrdb (X11) color scheme format to
# the VS Code color scheme format
#
# Usage:
# xrdb2vscode.py path/to/xrdb/files -d path/to/vscode/files

import argparse
import json
import os
import re

from xrdbparser import Xrdb


def process_file(data):
    # map to Windows Terminal names
    start_pairs = [
        ("terminal.foreground", "Foreground_Color"),
        ("terminal.background", "Background_Color"),
    ]

    end_pairs = [
        ("terminal.selectionBackground", "Selection_Color"),
        ("terminalCursor.foreground", "Cursor_Color"),
    ]

    ansi = [
        "Black",
        "Red",
        "Green",
        "Yellow",
        "Blue",
        "Magenta",
        "Cyan",
        "White",
    ]

    ansi_bright = [
        "BrightBlack",
        "BrightRed",
        "BrightGreen",
        "BrightYellow",
        "BrightBlue",
        "BrightMagenta",
        "BrightCyan",
        "BrightWhite",
    ]

    scheme = {}
    for local, xrdb in start_pairs:
        color = getattr(data, xrdb, None)
        if color:
            scheme.update({local: color})

    colors = {}
    for i, name in enumerate(ansi):
        color = data.colors[i]
        if color:
            colors.update({f'terminal.ansi{name}': color})

    brights = {}
    for i, name in enumerate(ansi_bright):
        color = data.colors[i + 8]
        if color:
            brights.update({f'terminal.ansi{name}': color})

    scheme.update(dict(sorted(colors.items())))
    scheme.update(dict(sorted(brights.items())))

    for local, xrdb in end_pairs:
        color = getattr(data, xrdb, None)
        if color:
            scheme.update({local: color})

    return json.dumps({'workbench.colorCustomizations': scheme}, indent=4) + "\n"



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
        description='Translate X color schemes to VS Code format')
    parser.add_argument('xrdb_path', type=str, help='path to xrdb files')
    parser.add_argument('-d', '--destiny', type=str, dest='output_path',
                        help='path where VS Code scheme files will be' +
                        ' created, if not provided then will be printed')

    args = parser.parse_args()

    main(args.xrdb_path, args.output_path)
