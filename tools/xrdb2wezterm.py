#!/usr/bin/env python3

# This script converts xrdb (X11) color scheme format to wezterm color
# scheme format
#
# Usage:
# xrdb2wezterm.py path/to/xrdb/files -d /wezterm/output

import os
import re
import argparse
from xrdbparser import Xrdb


def process_file(data):
    quoted_colors = [f'"{c}"' for c in data.colors]
    ansi = ",".join(quoted_colors[0:8])
    brights = ",".join(quoted_colors[8:])

    # map to wezterm names
    pairs = [
        ("foreground", "Foreground_Color"),
        ("background", "Background_Color"),
        ("cursor_bg", "Cursor_Color"),
        ("cursor_border", "Cursor_Color"),
        ("cursor_fg", "Cursor_Text_Color"),
        ("selection_bg", "Selection_Color"),
        ("selection_fg", "Selected_Text_Color"),
    ]

    lines = ""
    for wezterm, xrdb in pairs:
        color = getattr(data, xrdb, None)
        if color:
            lines += f'{wezterm} = "{color}"\n'

    return f"""# {data.name}
[colors]
{lines}
ansi = [{ansi}]
brights = [{brights}]
"""


def main(xrdb_path, output_path=None):
    for data in Xrdb.parse_all(xrdb_path):
        output = process_file(data)
        if not output_path:
            print(output)
        else:
            dest = os.path.join(output_path, data.name)
            with open('{0}.toml'.format(dest), 'w+') as f:
                f.write(output)

if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description='Translate X color schemes to wezterm format')
    parser.add_argument('xrdb_path', type=str, help='path to xrdb files')
    parser.add_argument('-d', '--destiny', type=str, dest='output_path',
                        help='path where wezterm config files will be' +
                        ' created, if not provided then will be printed')

    args = parser.parse_args()

    main(args.xrdb_path, args.output_path)
