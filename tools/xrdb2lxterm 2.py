#!/usr/bin/env python
# coding: utf-8
#
# This script converts xrdb (X11) color scheme to lxterminal.conf file format
# Users can paste the color configuration in the lxterminal.conf file
# Modify from "xrdb2moba.py"
#
# Usage:
# xrdb2lxterm.py path/to/xrdb/files -d path/to/lxterm/files
#

import os
import sys
import re
import argparse


def hex_to_rgb(color):
    # Takes #000A0B and returns (0, 10, 11)
    return (int(color[1:3], 16), int(color[3:5], 16), int(color[5:7], 16))


def build_lxterm_color(name, r, g, b):
    return "%s=rgb(%d,%d,%d)\n" % (name, r, g, b)


def build_lxterm_bgcolor(name, r, g, b):
    return "%s=rgba(%d,%d,%d,1)\n" % (name, r, g, b)


def main(xrdb_path, output_path=None):

    # The regexes to match the colors
    color_regex = re.compile("#define +Ansi_(\d+)_Color +(#[A-Fa-f0-9]{6})") # noqa
    bg_regex = re.compile("#define +Background_Color +(#[A-Fa-f0-9]{6})")
    fg_regex = re.compile("#define +Foreground_Color +(#[A-Fa-f0-9]{6})")

    # File regex
    xrdb_regex = re.compile("(.+)\.[xX][rR][dD][bB]") # noqa

    for i in filter(lambda x: xrdb_regex.match(x), os.listdir(xrdb_path)):
        name = xrdb_regex.match(i).group(1)

        # Read XRDB file
        with open(os.path.join(xrdb_path, i)) as f:
            xrdb_data = f.read()

            # Open output file
            output = sys.stdout

            if output_path:
                dest = os.path.join(output_path, name)
                output = open('{0}.conf'.format(dest), 'w+')
            else:
                output.write('\n%s:\n' % name)

            # Emit header
            output.write(";Paste the following configurations in the")
            output.write("corresponding place in lxterminal.conf.\n")
            # Emit background color
            bg_color = hex_to_rgb(bg_regex.search(xrdb_data).group(1))
            output.write(build_lxterm_bgcolor('bgcolor', *bg_color))

            # Emit foreground color
            fg_color = hex_to_rgb(fg_regex.search(xrdb_data).group(1))
            output.write(build_lxterm_color('fgcolor', *fg_color))

            # Emit other colors
            for match in color_regex.findall(xrdb_data):
                color_index = int(match[0])
                color_rgb = hex_to_rgb(match[1])
                color_name = "palette_color_%s" % color_index
                output.write(build_lxterm_color(color_name, *color_rgb))

            # Emit color scheme name
            output.write("color_preset=%s\n" % name)

            if output_path:
                output.flush()
                output.close()


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description='Translate X color schemes to lxterminal format')
    parser.add_argument('xrdb_path', type=str, help='path to xrdb files')
    parser.add_argument('-d', '--out-directory', type=str, dest='output_path',
                        help='path where putty config files will be' +
                        ' created, if not provided then will be printed')

    args = parser.parse_args()
    main(args.xrdb_path, args.output_path)
