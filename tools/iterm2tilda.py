# -*- coding=utf-8 -*-
#!/usr/bin/env python3
import os
import plistlib
from argparse import ArgumentParser

__author__ = 'mgallet'
RED = 'Red Component'
GREEN = 'Green Component'
BLUE = 'Blue Component'
BACKGROUND = 'Background Color'
CURSOR = 'Cursor Color'
FOREGROUND = 'Foreground Color'


def iterm2tilda_component(x):
    return str(int((x * 256)) + int((x * 256)) * 256)


def main(iterm, input_tilda=None, output_tilda=None):
    palette = []
    with open(iterm, 'rb') as fd:
        content = plistlib.load(fd)

    new_values = {}
    for color_index in range(16):
        key = 'Ansi %d Color' % color_index
        palette += [iterm2tilda_component(content[key][RED]), iterm2tilda_component(content[key][GREEN]),
                    iterm2tilda_component(content[key][BLUE])]
    new_values['palette'] = '{%s}' % ', '.join(palette)

    new_values['cursor_red'] = iterm2tilda_component(content[CURSOR][RED])
    new_values['cursor_green'] = iterm2tilda_component(content[CURSOR][GREEN])
    new_values['cursor_blue'] = iterm2tilda_component(content[CURSOR][BLUE])

    new_values['back_red'] = iterm2tilda_component(content[BACKGROUND][RED])
    new_values['back_green'] = iterm2tilda_component(content[BACKGROUND][GREEN])
    new_values['back_blue'] = iterm2tilda_component(content[BACKGROUND][BLUE])

    new_values['text_red'] = iterm2tilda_component(content[FOREGROUND][RED])
    new_values['text_green'] = iterm2tilda_component(content[FOREGROUND][GREEN])
    new_values['text_blue'] = iterm2tilda_component(content[FOREGROUND][BLUE])

    new_content = ''
    if input_tilda:
        input_tilda = os.path.expanduser(input_tilda)
        for line in open(input_tilda, 'r', encoding='utf-8'):
            key, sep, value = line.partition(' = ')
            if sep == ' = ' and key in new_values:
                new_content += '%s = %s\n' % (key, new_values[key])
            else:
                new_content += line
    else:
        for key in sorted(new_values):
            new_content += '%s = %s\n' % (key, new_values[key])

    if output_tilda:
        output_tilda = os.path.expanduser(output_tilda)
        with open(output_tilda, 'w', encoding='utf-8') as fd:
            fd.write(new_content)
    else:
        print(new_content)


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('input', help='.itermcolors filename')
    parser.add_argument('--input-tilda', default=None, help='Input tilda config file (e.g. ~/.config/tilda/config_0)')
    parser.add_argument('--output-tilda', default=None, help='Output tilda config file (e.g. ~/.config/tilda/config_0)')
    args = parser.parse_args()

    main(args.input, args.input_tilda, args.output_tilda)
