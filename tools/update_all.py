#!/usr/bin/env python3

import subprocess
from glob import glob

from os.path import basename, splitext, join

import xrdb2konsole
import xrdb2terminator
import xrdb2Xresources
import xrdb2putty
import xrdb2xfce_terminal

if __name__ == '__main__':

    for f in glob("../schemes/*.itermcolors"):
        base_name = splitext(basename(f))[0]
        xrdb_filepath = join('../xrdb', base_name + '.xrdb')
        with open(xrdb_filepath, 'w') as fout:
            ret_code = subprocess.Popen(['./iterm2xrdb', f], stdout=fout).wait()
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
