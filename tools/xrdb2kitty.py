#!/usr/bin/env python
from __future__ import print_function

import argparse
import sys
from collections import OrderedDict
from glob import glob
from os.path import basename, join, splitext

XRDB2KITTY = OrderedDict(("ansi_%s_color" % c, "color%s" % c) for c in range(16))
for k, v in [
        ("background_color", "background selection_foreground"),
        ("cursor_color", "cursor"),
        ("foreground_color", "foreground selection_background"),
        ("underline_color", "underline_color url_color"),
    ]:
    XRDB2KITTY[k] = v


def convert(xrdb_colors):
    for xrdb_key, kitty_keys in XRDB2KITTY.items():
        if xrdb_key in xrdb_colors:
            for kitty_key in kitty_keys.split():
                yield "{} {}".format(kitty_key, xrdb_colors[xrdb_key])


def read_xrdb(xrdb_input):
    return {
        parts[1].lower(): parts[2]
        for parts in (line.split() for line in xrdb_input)
        if not parts[1].startswith("!")
    }


def main(xrdb_path, output_path=None):
    for path in glob(join(xrdb_path, "*.xrdb")):
        with open(path) as f:
            xrdb_in = read_xrdb(f)
        base_name, _ = splitext(basename(path))
        kitty_out = (
            open(join(output_path, base_name + ".conf"), "w")
            if output_path
            else sys.stdout
        )
        for line in convert(xrdb_in):
            print(line, file=kitty_out)


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description="Translate X color schemes to kitty .conf format"
    )
    parser.add_argument("xrdb_path", type=str, help="path to xrdb files")
    parser.add_argument(
        "-d",
        "--out-directory",
        type=str,
        dest="output_path",
        help="path where kitty config files will be"
        + " created, if not provided then will be printed",
    )

    args = parser.parse_args()
    main(args.xrdb_path, args.output_path)
