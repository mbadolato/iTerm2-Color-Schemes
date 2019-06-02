#!/usr/bin/env python3

# This script converts xrdb (X11) color scheme format to xterm style
# dynamic color OSC escape sequence scripts.
# The generated scripts allow changing the theme of the terminal
# on the fly.  xterm, urxvt and wezterm are known to support these
# sequences.
#
# Usage:
# xrdb2dynamic_color.py path/to/xrdb/files -d /dynamiccolor
#
# Author: Xabier Larrakoetxea

import os
import re
import argparse


def main(xrdb_path, output_path=None):
    global color_regex, xrdb_regex
    # The regexes to match the colors
    color_regex = re.compile("#define +Ansi_(\d+)_Color +(#[A-Fa-f0-9]{6})")
    bg_regex = re.compile("#define +Background_Color +(#[A-Fa-f0-9]{6})")
    fg_regex = re.compile("#define +Foreground_Color +(#[A-Fa-f0-9]{6})")
    cursor_regex = re.compile("#define +Cursor_Color +(#[A-Fa-f0-9]{6})")
    # File regex
    xrdb_regex = re.compile("(.+)\.[xX][rR][dD][bB]")
    for i in filter(lambda x: xrdb_regex.match(x), os.listdir(xrdb_path)):

        # per file
        with open(os.path.join(xrdb_path, i)) as f:
            lines = f.readlines()

        # Search special colors
        color_file = "\n".join(lines)

        bg_color = bg_regex.search(color_file).group(1)
        fg_color = fg_regex.search(color_file).group(1)
        cursor_color = cursor_regex.search(color_file).group(1)

        # Search palette
        colors = sorted(filter(lambda x: color_regex.match(x), lines),
                        key=lambda x: int(color_regex.match(x).group(1)))

        # Create the color string
        colors = list(map(lambda x: color_regex.match(x).group(2), colors))

        name = xrdb_regex.match(i).group(1)
        output = "#!/bin/sh\n# " + name

        output += '\nprintf "\\033]4'
        for i in range(0, 16):
            output += ";%d;%s" % (i, colors[i])
        output += '\\007"'

        output += '\nprintf "\\033]10;%s;%s;%s\\007"\n' % (fg_color, bg_color, cursor_color)

        if not output_path:
            print(output)
        else:
            dest = '{0}.sh'.format(os.path.join(output_path, name))
            with open(dest, 'w+') as f:
                f.write(output)
            # Make sure these scripts are executable
            os.chmod(dest, 0o755)

if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description='Translate X color schemes to wezterm format')
    parser.add_argument('xrdb_path', type=str, help='path to xrdb files')
    parser.add_argument('-d', '--destiny', type=str, dest='output_path',
                        help='path where wezterm config files will be' +
                        ' created, if not provided then will be printed')

    args = parser.parse_args()

    main(args.xrdb_path, args.output_path)
