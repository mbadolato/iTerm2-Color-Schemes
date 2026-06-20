"""Load themes from .itermcolors or YAML source files."""

from __future__ import annotations

import pathlib
import sys
from typing import List

TOOLS_PATH = pathlib.Path(__file__).resolve().parent.parent
if str(TOOLS_PATH) not in sys.path:
    sys.path.insert(0, str(TOOLS_PATH))

from gen import REPO_PATH, Theme, read_itermcolors_file, read_yaml_file  # noqa: E402

SCHEMES_PATH = REPO_PATH / "schemes"
YAML_PATH = REPO_PATH / "yaml"


def load_theme_path(path: pathlib.Path) -> Theme:
    suffix = path.suffix.lower()
    if suffix == ".itermcolors":
        return read_itermcolors_file(path)
    if suffix in {".yml", ".yaml"}:
        return read_yaml_file(path)
    raise ValueError(f"Unsupported theme file type: {path}")


def resolve_theme_name(name: str) -> Theme:
    iterm_path = SCHEMES_PATH / f"{name}.itermcolors"
    if iterm_path.exists():
        return read_itermcolors_file(iterm_path)

    yaml_path = YAML_PATH / f"{name}.yml"
    if yaml_path.exists():
        return read_yaml_file(yaml_path)

    raise FileNotFoundError(
        f'Theme "{name}" not found in {SCHEMES_PATH}/ or {YAML_PATH}/.'
    )


def resolve_themes(
    scheme_names: List[str] | None,
    paths: List[pathlib.Path],
) -> List[Theme]:
    themes: List[Theme] = []
    seen: set[str] = set()

    for path in paths:
        theme = load_theme_path(path.expanduser().resolve())
        if theme.name not in seen:
            themes.append(theme)
            seen.add(theme.name)

    if scheme_names:
        for name in scheme_names:
            theme = resolve_theme_name(name)
            if theme.name not in seen:
                themes.append(theme)
                seen.add(theme.name)

    if not themes:
        raise ValueError("No themes to preview.")

    return themes