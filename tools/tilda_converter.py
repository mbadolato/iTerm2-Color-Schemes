#!/usr/bin/env python3

# Wrapper for converting a directory of iTerm color schemes to Tilda format
# 
# Usage:
# python3 tilda_converter.py /path/to/iterm/schemes --target /path/to/tilda/schemes

import iterm2tilda

from argparse import ArgumentParser
from pathlib import Path


def main(source, target=None):
    source_dir = (Path(source)).resolve()
    themes = list(source_dir.glob('**/*.itermcolors'))
    for theme in themes:
        output_file = None
        if target:
            destination = (Path(target)).resolve()
            output_file = str(destination / theme.name) + '_config_0'

        iterm2tilda.main(theme, output_tilda=output_file)


if __name__ == '__main__':
    parser = ArgumentParser(description='Convert iTerm color schemes to Tilda format')
    parser.add_argument('source', type=str, help='Path to iTerm color schemes')
    parser.add_argument('--target', type=str, help='Path to save Tilda schemes')
    args = parser.parse_args()

    main(args.source, args.target)
