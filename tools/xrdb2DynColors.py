#!/usr/bin/env python

import argparse
from collections import OrderedDict

import sys
from glob import glob

from os.path import join, splitext, basename


XRDB2DYNC = (
    ("background_color", "background='{}'"),
    ("cursor_color",     "cursor='{}'"),
    ("foreground_color", "foreground='{}'"),
    ("ansi_0_color",     "color0='{}'"),
    ("ansi_1_color",     "color1='{}'"),
    ("ansi_2_color",     "color2='{}'"),
    ("ansi_3_color",     "color3='{}'"),
    ("ansi_4_color",     "color4='{}'"),
    ("ansi_5_color",     "color5='{}'"),
    ("ansi_6_color",     "color6='{}'"),
    ("ansi_7_color",     "color7='{}'"),
    ("ansi_8_color",     "color8='{}'"),
    ("ansi_9_color",     "color9='{}'"),
    ("ansi_10_color",    "color10='{}'"),
    ("ansi_11_color",    "color11='{}'"),
    ("ansi_12_color",    "color12='{}'"),
    ("ansi_13_color",    "color13='{}'"),
    ("ansi_14_color",    "color14='{}'"),
    ("ansi_15_color",    "color15='{}'"),
    ("selection_color",  "highlight='{}'"),
    # Not sure these are supported by dynamic-color so commented for now
    # ("bold_color",       "colorBD='{}'"),
    # ("italic_color",     "colorIT='{}'"),
    # ("underline_color",  "colorUL='{}'"),
    # The following are supported by dynamic-color but are not present in xrdb
    # ("mouse_foreground", "mouse_foreground='{}'"),
    # ("mouse_background", "mouse_background='{}'"),
    # ("border",           "border='{}'"),
)


class XrdbEntry(object):
    def __init__(self, define: str, key: str, value: str, *args: str):
        super().__init__()
        self.define = define
        self.key = key.lower()
        self.value = value

    def commented(self):
        return self.define.strip().startswith("!")


def convert(xrdb_colors, dyncol_out=sys.stdout):
    try:
        f = dyncol_out
        if not hasattr(f, 'close'):
            f = open(dyncol_out, 'w')

        for xrdb_key, value in XRDB2DYNC:
            if xrdb_key in xrdb_colors:
                f.write(value.format(xrdb_colors[xrdb_key]) + '\n')
    finally:
        if f != sys.stdout:
            f.close()


def read_xrdb(itermcolors_input=sys.stdin):
    xrdb_colors = dict()

    try:
        f = itermcolors_input
        if not hasattr(f, 'close'):
            f = open(itermcolors_input, 'r')

        for line in f:
            xrdb_entry = XrdbEntry(*line.split())
            if not xrdb_entry.commented():
                xrdb_colors.setdefault(xrdb_entry.key, xrdb_entry.value)
    finally:
        f.close()

    return xrdb_colors


def main(xrdb_path, output_path=None):
    for f in glob(join(xrdb_path, '*.xrdb')):
        xrdb_in = read_xrdb(f)
        base_name = splitext(basename(f))[0]
        dyncol_out = output_path and join(output_path, base_name + '.sh') or sys.stdout
        convert(xrdb_in, dyncol_out)


if __name__ == '__main__':

    parser = argparse.ArgumentParser(
        description='Translate X color schemes to dynamic-color .sh format')
    parser.add_argument('xrdb_path', type=str, help='path to xrdb files')
    parser.add_argument('-d', '--out-directory', type=str, dest='output_path',
                        help=('path where dynamic-colors .sh files will be'
                              ' created, if not provided then will be printed'))

    args = parser.parse_args()
    main(args.xrdb_path, args.output_path)
