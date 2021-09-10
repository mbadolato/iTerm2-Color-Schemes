import plistlib
from argparse import ArgumentParser


__author__ = 'junhan'
RED = 'Red Component'
GREEN = 'Green Component'
BLUE = 'Blue Component'


def color_to_hex(color):
    # Not sure about the exact conversion from real (0-1?) to integer
    return '%02x' % int(255 * color)

def get_color_hex(color_dict): 
    rgb = []
    for color in [RED, GREEN, BLUE]:
        hex_value = color_to_hex(color_dict[color])
        rgb.append(hex_value)
    color_hex = ''.join(rgb)

    return f'#{color_hex}'

def itermcolors_to_palette(iterm_colorscheme_file):
    with open(iterm_colorscheme_file, 'rb') as fd:
        content = plistlib.load(fd)

    palette = []
    palette_keys = set()
    for color_index in range(16):
        key = f'Ansi {color_index} Color'
        palette_keys.add(key)
        color_hex = get_color_hex(content[key])

        palette.append(f'  "{color_index}": "{color_hex}"')

    print('Initial Palette:')
    print('{')
    print(",\n".join(palette))
    print('}')
    
    # Print the rest colors in hex format
    for key in content.keys():
        if key in palette_keys:
            continue
        print()
        print(f'{key}:')
        print(get_color_hex(content[key]))


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('itermcolors', help='.itermcolros file path.')
    args = parser.parse_args()

    itermcolors_to_palette(args.itermcolors)
