#!/usr/bin/env python
# coding: utf-8
#
# This script converts xrdb (X11) color scheme  MobaXterm.ini file format
# Users can paste the color configuration in the MobaXterm.ini file (Must close the MobaXterm beforehand)
# Modify from "xrdb2putty.py"
#
# Usage:
# xrdb2moba.py path/to/xrdb/files -d path/to/moba/files
#



import os
import sys
import re
import argparse

# Takes #000A0B and returns (0, 10, 11)
def hex_to_rgb(color):
    return (int(color[1:3], 16), int(color[3:5], 16), int(color[5:7], 16))

def build_moba_color(name, r, g, b):
    return "%s=%d,%d,%d\n" % (name, r, g, b)

def main(xrdb_path, output_path=None):

    # The regexes to match the colors
    color_regex = re.compile("#define +Ansi_(\d+)_Color +(#[A-Fa-f0-9]{6})")
    bg_regex = re.compile("#define +Background_Color +(#[A-Fa-f0-9]{6})")
    fg_regex = re.compile("#define +Foreground_Color +(#[A-Fa-f0-9]{6})")
    bold_regex = re.compile("#define +Bold_Color +(#[A-Fa-f0-9]{6})")
    cursor_regex = re.compile("#define +Cursor_Color +(#[A-Fa-f0-9]{6})")
    cursor_text_regex = re.compile("#define +Cursor_Text_Color +(#[A-Fa-f0-9]{6})")

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
                output = open('{0}.ini'.format(dest), 'w+')
            else:
                output.write('\n%s:\n' % name)

            # Emit header
            output.write(";Paste the following configurations in the corresponding place in MobaXterm.ini.\n")
            output.write(";Theme: %s\n" % name)
            output.write("[Colors]\n")
            output.write("DefaultColorScheme=0\n")
            # Emit background color
            bg_color = hex_to_rgb(bg_regex.search(xrdb_data).group(1))
            output.write(build_moba_color('BackgroundColour', *bg_color))

            # Emit foreground color
            fg_color = hex_to_rgb(fg_regex.search(xrdb_data).group(1))
            output.write(build_moba_color('ForegroundColour', *fg_color))
            
            # Emit cursor color
            cursor_color = hex_to_rgb(cursor_regex.search(xrdb_data).group(1))
            output.write(build_moba_color('CursorColour', *cursor_color))


            # The table for the ANSI colors mapping to the mobaxterm color name
            xrdb_to_moba_dict = {
                0 :  "Black",
                1 :  "Red",
                2 :  "Green",
                3 :  "Yellow",
                4 :  "Blue",
                5 :  "Magenta",
                6 :  "Cyan",
                7 :  "White",
                8 :  "BoldBlack",
                9 :  "BoldRed",
                10 : "BoldGreen",
                11 : "BoldYellow",
                12 : "BoldBlue",
                13 : "BoldMagenta",
                14 : "BoldCyan",
                15 : "BoldWhite",
            }

            # Emit other colors
            for match in color_regex.findall(xrdb_data):
                color_index = int(match[0])
                color_rgb = hex_to_rgb(match[1])
                color_name = xrdb_to_moba_dict[color_index]
                output.write(build_moba_color(color_name, *color_rgb))

            if output_path:
                output.flush()
                output.close()

if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description='Translate X color schemes to termiantor format')
    parser.add_argument('xrdb_path', type=str, help='path to xrdb files')
    parser.add_argument('-d', '--out-directory', type=str, dest='output_path',
                        help='path where putty config files will be' +
                        ' created, if not provided then will be printed')

    args = parser.parse_args()
    main(args.xrdb_path, args.output_path)


