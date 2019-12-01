#!/usr/bin/env python
# coding: utf-8
#
# This script converts xrdb (X11) color scheme format to Konsole color
# scheme format
#
# Usage:
# xrdb2konsole.py path/to/xrdb/files -d /konsole/schemes/output
#
# Author: Stéphane Travostino
# Adapted from xrdb2terminator by Xabier Larrakoetxea

import os
import sys
import re
import argparse

# Takes #000A0B and returns (0, 10, 11)

def hex_to_rgb(color):
    return (int(color[1:3], 16), int(color[3:5], 16), int(color[5:7], 16))


def build_konsole_color(name, r, g, b):
    return "[%s]\nColor=%d,%d,%d\n\n" % (name, r, g, b)


def main(xrdb_path, output_path=None):

    global xrdb_regex
    # The regexes to match the colors
    color_regex = re.compile("#define +Ansi_(\d+)_Color +(#[A-Fa-f0-9]{6})")
    bg_regex = re.compile("#define +Background_Color +(#[A-Fa-f0-9]{6})")
    fg_regex = re.compile("#define +Foreground_Color +(#[A-Fa-f0-9]{6})")
    bold_regex = re.compile("#define +Bold_Color +(#[A-Fa-f0-9]{6})")
    cursor_regex = re.compile("#define +Cursor_Color +(#[A-Fa-f0-9]{6})")

    # File regex
    xrdb_regex = re.compile("(.+)\.[xX][rR][dD][bB]")
    for i in filter(lambda x: xrdb_regex.match(x), os.listdir(xrdb_path)):
        name = xrdb_regex.match(i).group(1)

        # Read XRDB file
        with open(os.path.join(xrdb_path, i)) as f:
            xrdb_data = f.read()

        # Open output file
        output = sys.stdout

        if output_path:
            dest = os.path.join(output_path, name)
            output = open('{0}.colorscheme'.format(dest), 'w+')
        else:
            output.write('\n%s:\n' % name)

        # Emit header
        output.write("[General]\nDescription=%s\nOpacity=1\nWallpaper=\n\n" % name)

        # Emit background color
        bg_color = hex_to_rgb(bg_regex.search(xrdb_data).group(1))
        output.write(build_konsole_color('Background', *bg_color))
        output.write(build_konsole_color('BackgroundIntense', *bg_color))

        # Emit foreground color
        fg_color = hex_to_rgb(fg_regex.search(xrdb_data).group(1))
        output.write(build_konsole_color('Foreground', *fg_color))

        # Emit bold color, if any
        match = bold_regex.search(xrdb_data)
        if match:
            bold_color = hex_to_rgb(match.group(1))
            output.write(build_konsole_color('ForegroundIntense', *bold_color))
        else:
            output.write(build_konsole_color('ForegroundIntense', *fg_color))

        # Emit other colors
        for match in color_regex.findall(xrdb_data):
            color_index = int(match[0])
            color_rgb = hex_to_rgb(match[1])

            color_name = 'Color%d' % color_index if color_index < 8 else 'Color%dIntense' % (
            color_index - 8)

            output.write(build_konsole_color(color_name, *color_rgb))

        if output_path:
            output.close()


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description='Translate X color schemes to termiantor format')
    parser.add_argument('xrdb_path', type=str, help='path to xrdb files')
    parser.add_argument('-d', '--out-directory', type=str, dest='output_path',
                        help='path where terminator config files will be' +
                        ' created, if not provided then will be printed')

    args = parser.parse_args()

    main(args.xrdb_path, args.output_path)
