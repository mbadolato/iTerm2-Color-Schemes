#!/usr/bin/env python
"""iTerm2 Schemes Converter Tool

usage: gen.py [-h] [-s [SCHEME [SCHEME ...]]] [-t [TEMPLATE [TEMPLATE ...]]]

A script for generating themes based on a set of schemes and templates.
If run with no arguments, everything will be re-generated.

optional arguments:
  -h, --help            show this help message and exit
  -s [SCHEME [SCHEME ...]], --scheme [SCHEME [SCHEME ...]]
                        list of schemes for which themes will be generated, default: all
  -t [TEMPLATE [TEMPLATE ...]], --template [TEMPLATE [TEMPLATE ...]]
                        list of templates for which themes will be generated, default: all

Author: Mikhail Shlyakhov <mike@aleph.space>

Based on code by:
Alexey Ten <alexeyten@gmail.com>
Antenore Gatta <antenore@simbiosi.org>
Caesar Kabalan <caesar.kabalan@gmail.com>
Eric Franz <rericfranz@gmail.com>
gBopHuk <gbophuk_alt@mail.ru>
hhchung <hhchung@users.noreply.github.com>
John Hodges <jdhmtl@users.noreply.github.com>
Jonathan Couldridge <beforan86@gmail.com>
Justin Grote <JustinGrote@users.noreply.github.com>
Leiser Fernández Gallo <leiserfg@gmail.com>
mgallet <flanker@19pouces.net>
Mike Wallio <miwalli@microsoft.com>
Nicolas Cornette <nicolas.cornette@gmail.com>
Stéphane Travostino <steph@combo.cc>
Suraj N. Kurapati <sunaku@gmail.com>tig
Thomas Sarboni <max-k@post.com>
Tobias Kortkamp <t6@users.noreply.github.com>
Wez Furlong <wez@wezfurlong.org>
Xabier Larrakoetxea <slok69@gmail.com>
ZHAO Xudong <986839138@qq.com>
"""

import argparse

from jinja2 import Environment, FileSystemLoader
from rich.progress import Progress, TextColumn, BarColumn

from converter import Converter

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='A script for generating themes based on a set of schemes and templates. ' +
                    'If run with no arguments, everything will be re-generated.')

    parser.add_argument('-s', '--scheme', nargs='*', dest='scheme',
                        help='list of schemes for which themes will be generated, default: all')
    parser.add_argument('-t', '--template', nargs='*', dest='template',
                        help='list of templates for which themes will be generated, default: all')

    arguments = vars(parser.parse_args())

    scheme_arg = arguments['scheme']
    template = arguments['template']

    file_system_loader = Environment(
        loader=FileSystemLoader('templates/'),
        trim_blocks=True,
        lstrip_blocks=True,
        keep_trailing_newline=True
    )

    progress_bar = Progress(
        TextColumn('[bold green]{task.fields[template]}', justify='left'),
        BarColumn(),
        '[progress.percentage]{task.percentage:>3.1f}%'
    )

    converter = Converter(
        schemes=arguments['scheme'],
        templates=arguments['template'],
        loader=file_system_loader,
        bar=progress_bar,
        path_to_iterm_schemes='../schemes/',
        output_dir='../'
    )

    converter.run()
