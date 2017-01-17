#!/usr/bin/env python3

import subprocess
from glob import glob

from os.path import basename, splitext, join

if __name__ == '__main__':

    for f in glob("../schemes/*.itermcolors"):
        base_name = splitext(basename(f))[0]
        xrdb_filepath = join('../xrdb', base_name + '.xrdb')
        with open(xrdb_filepath, 'w') as fout:
            print("--> " + xrdb_filepath)
            subprocess.Popen(['./iterm2xrdb', f], stdout=fout).wait()

    konsole_path = "../konsole/"
    print("--> " + konsole_path)
    subprocess.Popen(['./xrdb2konsole.py', '../xrdb/', '-d', konsole_path])

    terminator_path = '../terminator/'
    print("--> " + terminator_path)
    subprocess.Popen(['./xrdb2terminator.py', '../xrdb/', '-d', terminator_path])

    putty_path = '../putty/'
    print("--> " + putty_path)
    subprocess.Popen(['./xrdb2putty.py', '../xrdb/', '-d', putty_path])
