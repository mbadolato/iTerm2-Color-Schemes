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

from __future__ import annotations

import argparse
import dataclasses
import json
import os
import pathlib
import sys

import yaml
import plistlib
from functools import cached_property
from typing import Any

import rich.progress
from jinja2 import Environment, FileSystemLoader

TOOLS_PATH = pathlib.Path(__file__).parent
TEMPLATES_PATH = TOOLS_PATH / "templates"
REPO_PATH = pathlib.Path(__file__).parent.parent
ITERM_SCHEMES_PATH = REPO_PATH / "schemes"
YAML_SCHEMES_PATH = REPO_PATH / "yaml"


@dataclasses.dataclass(frozen=True)
class Color:
    # Assumed to be sRGB
    r: int
    g: int
    b: int

    # Only required for legacy guint16 conversion:
    _raw_float_rgb: tuple[float, float, float] | None = None

    @classmethod
    def from_iterm_color_dict(cls, data: dict[str, Any]) -> Color:
        # TODO: add support for colorspace conversion here!
        r = data["Red Component"]
        g = data["Green Component"]
        b = data["Blue Component"]
        return cls(round(r * 255), round(g * 255), round(b * 255), _raw_float_rgb=(r, g, b))

    @classmethod
    def from_hex(cls, value: str) -> Color:
        value = value.lstrip("#")
        return cls(int(value[:2], 16), int(value[2:4], 16), int(value[4:6], 16))

    @cached_property
    def hex(self) -> str:
        return f"{self.r:02x}{self.g:02x}{self.b:02x}"

    @cached_property
    def rgb(self) -> str:
        return f"{self.r:d},{self.g:d},{self.b:d}"

    @cached_property
    def hexshell(self) -> str:
        return f"{self.r:02x}/{self.g:02x}/{self.b:02x}"

    @cached_property
    def hexchat(self) -> str:
        return f"{self.r:02x}{self.r:02x} {self.g:02x}{self.g:02x} {self.b:02x}{self.b:02x}"

    @cached_property
    def guint16(self) -> tuple[int, ...]:
        if self._raw_float_rgb:
            # If we have raw float values, use them directly (so as to keep the legacy conversion behavior).
            # TODO: this should probably be removed, and just use the quantized sRGB values directly,
            #       so there's no special behavior here.
            float_rgbs = self._raw_float_rgb
        else:
            float_rgbs = (self.r / 255, self.g / 255, self.b / 255)

        # NB: this is likely wrong – the multiplier shouldn't be 256,
        #     but 255, as the values are in the range 0-1.

        return tuple(int(x * 256) + int(x * 256) * 256 for x in float_rgbs)

    def to_dict(self) -> dict[str, Any]:
        return {
            "r": self.r,
            "g": self.g,
            "b": self.b,
            "hex": self.hex,
            "rgb": self.rgb,
            "hexshell": self.hexshell,
        }

    @property
    def r_float(self) -> float:
        return self.r / 255

    @property
    def g_float(self) -> float:
        return self.g / 255

    @property
    def b_float(self) -> float:
        return self.b / 255


@dataclasses.dataclass(frozen=True)
class Theme:
    source_path: pathlib.Path
    name: str
    colors: dict[str, Color]

    @cached_property
    def guint16_palette(self) -> str:
        guint16_palette: list[str] = []
        for color_index in range(16):
            color = self.colors[f"Ansi {color_index:d} Color"]
            guint16_palette.extend(str(c) for c in color.guint16)
        return "{%s}" % ", ".join(guint16_palette)

    @cached_property
    def dark_theme(self) -> bool:
        color = self.colors["Background Color"]
        return (0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b) < 127

    def to_dict(self) -> dict[str, Any]:
        return {
            **{key.replace(" ", "_"): color for key, color in self.colors.items()},
            "colors": self.colors,
            "scheme_name": self.name,
            "Dark_Theme": self.dark_theme,
            "Guint16_Palette": self.guint16_palette,
        }


def read_itermcolors_file(iterm_path: pathlib.Path) -> Theme:
    colors_dict = {}

    with iterm_path.open("rb") as f:
        plist = plistlib.load(f)

    for color_name, color_data in plist.items():
        colors_dict[color_name] = Color.from_iterm_color_dict(color_data)

    return Theme(
        source_path=iterm_path,
        name=iterm_path.stem,
        colors=colors_dict,
    )


yaml_to_iterm_color_name_map = {
    "background": "Background Color",
    "bold": "Bold Color",
    "color_01": "Ansi 0 Color",
    "color_02": "Ansi 1 Color",
    "color_03": "Ansi 2 Color",
    "color_04": "Ansi 3 Color",
    "color_05": "Ansi 4 Color",
    "color_06": "Ansi 5 Color",
    "color_07": "Ansi 6 Color",
    "color_08": "Ansi 7 Color",
    "color_09": "Ansi 8 Color",
    "color_10": "Ansi 9 Color",
    "color_11": "Ansi 10 Color",
    "color_12": "Ansi 11 Color",
    "color_13": "Ansi 12 Color",
    "color_14": "Ansi 13 Color",
    "color_15": "Ansi 14 Color",
    "color_16": "Ansi 15 Color",
    "cursor": "Cursor Color",
    "cursor_guide": "Cursor Guide Color",
    "cursor_text": "Cursor Text Color",
    "foreground": "Foreground Color",
    "link": "Link Color",
    "selection": "Selection Color",
    "selection_text": "Selected Text Color",
    "tab": "Tab Color",
    "underline": "Underline Color",
    "badge": "Badge Color",
}

fallback_color_map = {
    "Cursor Guide Color": "Cursor Color",
    "Cursor Text Color": "Foreground Color",
    "Selected Text Color": "Background Color",
    "Selection Color": "Foreground Color",
    "Bold Color": "Foreground Color",
}


def read_yaml_file(yaml_file_path: pathlib.Path) -> Theme:
    with yaml_file_path.open("r", encoding="utf-8") as f:
        data = yaml.safe_load(f)

    name = yaml_file_path.stem

    colors_dict = {}
    for key, value in data.items():
        if key == "name":
            name = str(value)
            continue
        if key in yaml_to_iterm_color_name_map:
            colors_dict[yaml_to_iterm_color_name_map[key]] = Color.from_hex(value)
        else:
            print(f"{yaml_file_path}: Unknown key {key!r} with value {value!r}", file=sys.stderr)

    for dest_key, src_key in fallback_color_map.items():
        if dest_key not in colors_dict:
            colors_dict[dest_key] = colors_dict[src_key]

    return Theme(
        source_path=yaml_file_path,
        name=name,
        colors=colors_dict,
    )


def generate_from_template(
    jinja_env: Environment,
    template_name: str,
    out_dir: pathlib.Path,
    schemes: dict[str, Theme],
) -> None:
    t = jinja_env.get_template(template_name)
    template_name, template_ext = os.path.splitext(template_name)

    for name, scheme in schemes.items():
        if scheme.source_path.suffix == ".itermcolors" == template_ext == ".itermcolors":
            # Special case: don't overwrite the original iTerm scheme a regeneration of itself.
            continue
        result = t.render(**scheme.to_dict())
        dest_path = out_dir / f"{template_name}/{name}{template_ext}"
        dest_path.write_text(result, encoding="utf-8")
        if result.startswith("#!"):
            dest_path.chmod(0o755)


def generate_jsonl(out_dir: pathlib.Path, themes: dict[str, Theme]) -> None:
    with (out_dir / "schemes.jsonl").open("w", encoding="utf-8") as outf:
        for name, theme in sorted(themes.items()):
            data = json.dumps(theme, sort_keys=True, ensure_ascii=False, default=lambda o: o.to_dict())
            outf.write(data + "\n")


def main() -> None:
    parser = argparse.ArgumentParser(
        description="A script for generating themes based on a set of schemes and templates. "
        + "If run with no arguments, everything will be re-generated."
    )

    parser.add_argument(
        "-s",
        "--scheme",
        nargs="*",
        dest="scheme",
        help="list of schemes for which themes will be generated, default: all",
    )
    parser.add_argument(
        "-t",
        "--template",
        nargs="*",
        dest="template",
        help="list of templates for which themes will be generated, default: all",
    )

    arguments = parser.parse_args()

    jinja_env = Environment(
        loader=FileSystemLoader(TEMPLATES_PATH),
        trim_blocks=True,
        lstrip_blocks=True,
        keep_trailing_newline=True,
    )

    scheme_arg = arguments.scheme
    schemes = {}
    for iterm_scheme in rich.progress.track(ITERM_SCHEMES_PATH.glob("*.itermcolors"), description="Reading iTerm schemes"):
        name = iterm_scheme.stem
        if scheme_arg is None or name in scheme_arg:
            theme = read_itermcolors_file(iterm_scheme)
            schemes[theme.name] = theme

    # Note: we read iTerm schemes first, then _overwrite_ with the YAML schemes.

    for yml_scheme in rich.progress.track(YAML_SCHEMES_PATH.glob("*.yml"), description="Reading YAML schemes"):
        name = yml_scheme.stem
        if scheme_arg is None or name in scheme_arg:
            theme = read_yaml_file(yml_scheme)
            schemes[theme.name] = theme

    if not schemes:
        parser.error("No schemes found (if you used `-s`, nothing matched)")
        return

    templates = []
    for template in jinja_env.list_templates():
        name, ext = os.path.splitext(template)
        if arguments.template is None or name in arguments.template:
            templates.append(template)

    if not templates:
        parser.error("No templates found (if you used `-t`, nothing matched)")
        return

    out_dir = REPO_PATH
    for template in rich.progress.track(templates, description="Generating themes"):
        generate_from_template(jinja_env, template, out_dir, schemes)

    generate_jsonl(out_dir, schemes)


if __name__ == "__main__":
    main()
