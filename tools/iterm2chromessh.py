import plistlib
from argparse import ArgumentParser


__author__ = 'junhan'
RED = 'Red Component'
GREEN = 'Green Component'
BLUE = 'Blue Component'


def color_to_hex(color):
    # Not sure about the exact conversion from real (0-1?) to integer
    return '%02x' % int(256 * color)


def itermcolors_to_palette(iterm_colorscheme_file):
    with open(iterm_colorscheme_file, 'rb') as fd:
        content = plistlib.load(fd)

    palette = []
    for color_index in range(16):
        key = f'Ansi {color_index} Color'
        red_hex = color_to_hex(content[key][RED])
        green_hex = color_to_hex(content[key][GREEN])
        blue_hex = color_to_hex(content[key][BLUE])

        palette.append(f'  "{color_index}": "#{red_hex}{green_hex}{blue_hex}"')

    print('{')
    print(",\n".join(palette))
    print('}')


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('itermcolors', help='.itermcolros file path.')
    args = parser.parse_args()

    itermcolors_to_palette(args.itermcolors)



