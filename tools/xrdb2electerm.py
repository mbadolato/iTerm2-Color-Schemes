#!/usr/bin/env python3

# This script converts xrdb (X11) color scheme format to
# the new electerm(https://github.com/electerm/electerm) color scheme format
#
# Usage:
# xrdb2electerm.py path/to/xrdb/files -d path/to/electerm/output

# Modify from "tools/xrdb2windowsterminal.py"

import os
import re
import argparse
from xrdbparser import Xrdb

def isDarkColor(color):
  a = color[1:]
  rgb = int(a, 16)

  r = (rgb >> 16) & 0xff
  g = (rgb >>  8) & 0xff
  b = (rgb >>  0) & 0xff
  luma = 0.2126 * r + 0.7152 * g + 0.0722 * b

  return luma < 40

def process_file(data):
    # map to electerm theme prop names
    ui = [
        ("main", "Background_Color")
    ]
    # map to electerm theme prop names
    pairs = [
        ("background", "Background_Color"),
        ("foreground", "Foreground_Color"),
        ("cursor", "Cursor_Color"),
        ("selection", "Selection_Color"),
        ("cursorAccent", "Background_Color")
    ]

    ansi = [
        "black",
        "red",
        "green",
        "yellow",
        "blue",
        "magenta",
        "cyan",
        "white",
        "brightBlack",
        "brightRed",
        "brightGreen",
        "brightYellow",
        "brightMagenta",
        "brightPurple",
        "brightCyan",
        "brightWhite",
    ]

    lines = ""
    extra = '''main-dark=#000
main-light=#2E3338
text=#ddd
text-light=#fff
text-dark=#888
text-disabled=#777
primary=#08c
info=#FFD166
success=#06D6A0
error=#EF476F'''
    extraLight = '''main=#ededed
main-dark=#cccccc
main-light=#fefefe
text=#555
text-light=#777
text-dark=#444
text-disabled=#888
primary=#08c
info=#FFD166
success=#06D6A0
error=#EF476F
warn=#E55934'''
    isDark = True
    for attr, xrdb in ui:
        color = getattr(data, xrdb, None)
        if color:
            lines += f'\n{attr}={color}'

    for attr, xrdb in pairs:
        color = getattr(data, xrdb, None)
        if color:
            lines += f'\nterminal:{attr}={color}'
            if attr == "background":
              isDark = isDarkColor(color)


    for i, name in enumerate(ansi):
        color = data.colors[i]
        if color:
            lines += f'\nterminal:{name}={color}'


    lines.rstrip(",")
    if not isDark:
      extra = extraLight
    return f'''
themeName={data.name}
{extra}
warn=#E55934{lines}
'''


def main(xrdb_path, output_path=None):
    for data in Xrdb.parse_all(xrdb_path):
        output = process_file(data)
        if not output_path:
            print(output)
        else:
            dest = os.path.join(output_path, data.name)
            with open('{0}.txt'.format(dest), 'w+') as f:
                f.write(output)


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description='Translate X color schemes to electerm format')
    parser.add_argument('xrdb_path', type=str, help='path to xrdb files')
    parser.add_argument('-d', '--destiny', type=str, dest='output_path',
                        help='path where electerm config files will be' +
                        ' created, if not provided then will be printed')

    args = parser.parse_args()

    main(args.xrdb_path, args.output_path)
