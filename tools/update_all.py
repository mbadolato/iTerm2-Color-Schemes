#!/usr/bin/env python3

import subprocess
from glob import glob

from os.path import basename, splitext, join

import tilda_converter
import xrdb2konsole
import xrdb2terminator
import xrdb2Xresources
import xrdb2putty
import xrdb2xfce_terminal
import xrdb2Remmina
import xrdb2Termite
import xrdb2freebsd_vt
import xrdb2kitty
import xrdb2moba
import xrdb2lxterm
import xrdb2pantheon_terminal
import xrdb2wezterm
import xrdb2windowsterminal
import xrdb2dynamic_color
import xrdb2alacritty
import xrdb2electerm
import xrdb2vscode

if __name__ == '__main__':

    for f in glob("../schemes/*.itermcolors"):
        base_name = splitext(basename(f))[0]
        xrdb_filepath = join('../xrdb', base_name + '.xrdb')
        with open(xrdb_filepath, 'w') as fout:
            ret_code = subprocess.Popen(
                ['./iterm2xrdb', f], stdout=fout).wait()
            print(ret_code and "ERROR" or "OK" + " --> " + xrdb_filepath)

    print()
    xrdb2konsole.main('../xrdb/', '../konsole/')
    print('OK --> ' + '../konsole/')
    xrdb2terminator.main('../xrdb/', '../terminator/')
    print('OK --> ' + '../terminator/')
    xrdb2Xresources.main('../xrdb/', '../Xresources/')
    print('OK --> ' + '../Xresources/')
    xrdb2putty.main('../xrdb/', '../putty/')
    print('OK --> ' + '../putty/')
    xrdb2xfce_terminal.main('../xrdb/', '../xfce4terminal/colorschemes/')
    print('OK --> ' + '../xfce4terminal/colorschemes/')
    xrdb2Remmina.main('../xrdb/', '../remmina/')
    print('OK --> ' + '../Remmina/')
    xrdb2Termite.main('../xrdb/', '../termite/')
    print('OK --> ' + '../termite/')
    xrdb2freebsd_vt.main('../xrdb/', '../freebsd_vt/')
    print('OK --> ' + '../freebsd_vt/')
    xrdb2kitty.main('../xrdb/', '../kitty/')
    print('OK --> ' + '../kitty/')
    xrdb2moba.main('../xrdb', '../mobaxterm')
    print('OK --> ' + '../mobaxterm/')
    xrdb2lxterm.main('../xrdb', '../lxterminal')
    print('OK --> ' + '../lxterminal/')
    xrdb2pantheon_terminal.main('../xrdb/', '../pantheonterminal/')
    print('OK --> ' + '../pantheonterminal/')
    xrdb2wezterm.main('../xrdb/', '../wezterm/')
    print('OK --> ' + '../wezterm/')
    xrdb2windowsterminal.main('../xrdb/', '../windowsterminal/')
    print('OK --> ' + '../windowsterminal/')
    xrdb2dynamic_color.main('../xrdb/', '../dynamic-colors/')
    print('OK --> ' + '../dynamic-colors/')
    xrdb2alacritty.main('../xrdb/', '../alacritty/')
    print('OK --> ' + '../alacritty/')
    xrdb2electerm.main('../xrdb/', '../electerm/')
    print('OK --> ' + '../electerm/')
    xrdb2vscode.main('../xrdb/', '../vscode/')
    print('OK --> ' + '../vscode/')
    tilda_converter.main('../schemes/', '../tilda/')
    print('OK --> ' + '../tilda/')
