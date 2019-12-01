#!/usr/bin/env python3

# This script converts xrdb (X11) color scheme format to xterm style
# dynamic color OSC escape sequence scripts.
# The generated scripts allow changing the theme of the terminal
# on the fly.  xterm, urxvt and wezterm are known to support these
# sequences.
#
# Usage:
# xrdb2dynamic_color.py path/to/xrdb/files -d /dynamiccolor

import os
import re
import argparse
from xrdbparser import Xrdb


def main(xrdb_path, output_path=None):
    for data in Xrdb.parse_all(xrdb_path):
        output = "#!/bin/sh\n# " + data.name

        output += '\nprintf "\\033]4'
        for i in range(0, 16):
            output += ";%d;%s" % (i, data.colors[i])
        output += '\\007"'

        output += '\nprintf "\\033]10;%s;%s;%s\\007"' % (data.Foreground_Color, data.Background_Color, data.Cursor_Color)
        if hasattr(data, "Selection_Color"):
            output += '\nprintf "\\033]17;%s\\007"' % (data.Selection_Color)
        if hasattr(data, "Selected_Text_Color"):
            output += '\nprintf "\\033]19;%s\\007"' % (data.Selected_Text_Color)
        if hasattr(data, "Bold_Color"):
            output += '\nprintf "\\033]5;0;%s\\007"' % (data.Bold_Color)
        output += "\n"

        if not output_path:
            print(output)
        else:
            dest = '{0}.sh'.format(os.path.join(output_path, data.name))
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
