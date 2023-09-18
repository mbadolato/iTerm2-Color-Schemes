import logging
import os
import plistlib
import re
import sys

from jinja2 import Environment
from rich.progress import Progress

iterm_re = re.compile("(.+)\.itermcolors$")
iterm_ext = ".itermcolors"
hex_format = "%02x%02x%02x"

red_comp = "Red Component"
green_comp = "Green Component"
blue_comp = "Blue Component"


class Converter(object):
    def __init__(
        self,
        schemes: list,
        templates: list,
        loader: Environment,
        bar: Progress,
        path_to_iterm_schemes: str,
        output_dir: str,
    ):
        self.bar = bar
        self.loader = loader
        self.iterm_dir = path_to_iterm_schemes
        self.out_dir = output_dir

        self.templates = self.get_all_templates(templates)

        self.schemes = schemes
        if self.schemes is None:
            self.schemes = self.get_all_schemes()

    def get_all_schemes(self):
        schemes = []

        for name in os.listdir(self.iterm_dir):
            schemes.append(iterm_re.match(name).group(1))

        return schemes

    def get_all_templates(self, templates_arg):
        templates = {}

        for template in self.loader.list_templates():
            name, ext = os.path.splitext(template)

            if templates_arg is None or name in templates_arg:
                templates.update({name: template})

        return templates

    def parse_scheme(self, scheme):
        colors_dict = {}

        iterm_path = self.iterm_dir + scheme + iterm_ext

        if not os.path.isfile(iterm_path):
            logging.error("Scheme " + iterm_path + " doesn't exist")
            sys.exit(1)

        with open(iterm_path, "rb") as f:
            plist = plistlib.load(f)
            guint16_pallete = []

            for color_name in plist:
                color_components = plist[color_name]
                color_hex, rgb = self.calculate_color(color_components)
                guint16 = self.calculcate_color_components_guint16(color_components)
                hexchat = " ".join(
                    [color_hex[i : i + 2] * 2 for i in range(0, len(color_hex), 2)]
                )
                colors_dict[color_name.replace(" ", "_")] = {
                    "hex": color_hex,
                    "rgb": ",".join(map(lambda x: str(x), rgb)),
                    "guint16": guint16,
                    "hexchat": hexchat,
                }

            # we need second loop because guint16 palette must have colors in sorted order
            for color_index in range(16):
                key = "Ansi %d Color" % color_index
                guint16_pallete += self.calculcate_color_components_guint16(plist[key])

            colors_dict["Guint16_Palette"] = "{%s}" % ", ".join(guint16_pallete)
            colors_dict["Dark_Theme"] = self.detect_dark_theme(
                int(colors_dict["Background_Color"]["hex"], 16)
            )

        f.close()

        return colors_dict

    def detect_dark_theme(self, hex):
        r = (hex >> 16) & 0xFF
        g = (hex >> 8) & 0xFF
        b = (hex >> 0) & 0xFF

        return 0.2126 * r + 0.7152 * g + 0.0722 * b < 40

    def calculate_color(self, color_components):
        r = round(color_components[red_comp] * 255)
        g = round(color_components[green_comp] * 255)
        b = round(color_components[blue_comp] * 255)
        rgb = (r, g, b)
        color_hex = hex_format % rgb

        return color_hex, rgb

    def calculcate_color_components_guint16(self, color_components):
        r = self.calculate_guint16(color_components[red_comp])
        g = self.calculate_guint16(color_components[green_comp])
        b = self.calculate_guint16(color_components[blue_comp])

        return (r, g, b)

    def calculate_guint16(self, x):
        return str(int((x * 256)) + int((x * 256)) * 256)

    def generate_from_template(self, task_id, colors, template):
        self.bar.update(task_id, total=len(self.schemes))

        t = self.loader.get_template(self.templates[template])
        name, ext = os.path.splitext(self.templates[template])

        self.bar.start_task(task_id)

        for scheme in colors:
            data = colors[scheme]
            data["scheme_name"] = scheme
            result = t.render(data)
            destination = self.out_dir + template + "/" + scheme + ext
            f = open(destination, "w")
            f.write(result)
            f.close()
            if result.startswith("#!"):
                os.chmod(destination, 0o755)
            self.bar.update(task_id, advance=1)

    def run(self):
        colors = {}

        with self.bar:
            task_id = self.bar.add_task(
                "process", template="Parse iTerm schemes", start=False
            )
            self.bar.update(task_id, total=len(self.schemes))
            self.bar.start_task(task_id)

            for scheme in self.schemes:
                colors[scheme] = self.parse_scheme(scheme)
                self.bar.update(task_id, advance=1)

            for template in self.templates:
                task_id_tmp = self.bar.add_task(
                    "process", template="Generating " + template, start=False
                )
                self.generate_from_template(task_id_tmp, colors, template)
