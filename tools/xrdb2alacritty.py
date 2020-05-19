#!/usr/bin/env python3

# This script converts .xrdb files to alacritty color schemes
#
# Usage:
# xrdb2alacritty.py path/to/xrdb/files -d /alacritty/schemes/output
#
# Based on xrdb2dynamic_color.py by Wez Furlong
# Patched by Shlyakhov Mikhail

import argparse
import os

import yaml
from xrdbparser import Xrdb


def main(xrdb_path, output_path=None):
    for data in Xrdb.parse_all(xrdb_path):
        scheme = dict(
            colors=dict(
                primary=dict(
                    background=data.Background_Color,
                    foreground=data.Foreground_Color
                ),
                cursor=dict(
                    text=data.Cursor_Text_Color,
                    cursor=data.Cursor_Color
                ),
                normal=dict(
                    black=data.colors[0],
                    red=data.colors[1],
                    green=data.colors[2],
                    yellow=data.colors[3],
                    blue=data.colors[4],
                    magenta=data.colors[5],
                    cyan=data.colors[6],
                    white=data.colors[7]
                ),
                bright=dict(
                    black=data.colors[8],
                    red=data.colors[9],
                    green=data.colors[10],
                    yellow=data.colors[11],
                    blue=data.colors[12],
                    magenta=data.colors[13],
                    cyan=data.colors[14],
                    white=data.colors[15]
                )
            )
        )

        if hasattr(data, "Selection_Color") and hasattr(data, "Selected_Text_Color"):
            scheme['colors']['selection'] = dict(
                text=data.Selected_Text_Color,
                background=data.Selection_Color
            )

        destination = '{0}.yml'.format(os.path.join(output_path, data.name))
        with open(destination, 'w+') as output_file:
            header = "# Colors (" + data.name + ")\n"
            output_file.write(header)
            yaml.dump(scheme, output_file, default_flow_style=False)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Convert .xrdb files to alacritty color schemes')
    parser.add_argument('xrdb_path', type=str, help='path to xrdb files')
    parser.add_argument('-d', '--destiny', type=str, dest='output_path',
                        help='path where alacritty config files will be' +
                             ' created, if not provided then will be printed')

    args = parser.parse_args()

    main(args.xrdb_path, args.output_path)
