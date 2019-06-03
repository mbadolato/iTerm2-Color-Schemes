import os
import re


xrdb_regex = re.compile("(.+)\.[xX][rR][dD][bB]$")


class Xrdb(object):
    def __init__(self, filename):
        """Parse an xrdb file"""

        self.name = xrdb_regex.match(os.path.basename(filename)).group(1)
        self.colors = [None] * 16

        color_regex = re.compile("#define +Ansi_(\d+)_Color +(#[A-Fa-f0-9]{6})")
        named_color = re.compile("#define +(\S+) +(#[A-Fa-f0-9]{6})")

        with open(filename) as f:
            for line in f:
                m = color_regex.match(line)
                if m:
                    self.colors[int(m.group(1))] = m.group(2)
                    continue

                m = named_color.match(line)
                if m:
                    prop_name = m.group(1)
                    setattr(self, prop_name, m.group(2))

    @classmethod
    def parse_all(cls, xrdb_dir):
        """Parse all of the xrdb files in the provided dir"""

        for name in filter(lambda x: xrdb_regex.match(x), os.listdir(xrdb_dir)):
            filename = os.path.join(xrdb_dir, name)
            yield cls(filename)
