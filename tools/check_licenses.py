#!/usr/bin/env python3
"""Check licenses.yml against the schemes in the repository.

usage: check_licenses.py [-h] [--licenses LICENSES] [--schemes-dir SCHEMES_DIR] [--yaml-dir YAML_DIR]

Fails when a scheme has no entry, when an entry names a scheme that does not
exist or when an entry is malformed. The `license` of an entry must be an
SPDX identifier from SPDX_LICENSES below, an SPDX expression joining them with
OR or AND (`MIT OR Apache-2.0`), `unknown` or `nonfree`.
"""

from __future__ import annotations

import argparse
import pathlib
import re
import sys
from typing import Any

import yaml

REPO_PATH = pathlib.Path(__file__).parent.parent
LICENSES_PATH = REPO_PATH / "licenses.yml"
ITERM_SCHEMES_PATH = REPO_PATH / "schemes"
YAML_SCHEMES_PATH = REPO_PATH / "yaml"

UNKNOWN = "unknown"
NONFREE = "nonfree"

# SPDX identifiers accepted in licenses.yml (https://spdx.org/licenses/).
# Add an identifier here when a new scheme needs one that is not listed yet.
SPDX_LICENSES = frozenset(
    {
        "0BSD",
        "AGPL-3.0-only",
        "AGPL-3.0-or-later",
        "Apache-2.0",
        "Artistic-2.0",
        "BSD-2-Clause",
        "BSD-3-Clause",
        "BSL-1.0",
        "CC-BY-3.0",
        "CC-BY-4.0",
        "CC-BY-SA-3.0",
        "CC-BY-SA-4.0",
        "CC0-1.0",
        "EPL-2.0",
        "GPL-2.0-only",
        "GPL-2.0-or-later",
        "GPL-3.0-only",
        "GPL-3.0-or-later",
        "ISC",
        "LGPL-2.1-only",
        "LGPL-2.1-or-later",
        "LGPL-3.0-only",
        "LGPL-3.0-or-later",
        "MIT",
        "MIT-0",
        "MPL-2.0",
        "Unlicense",
        "Vim",
        "WTFPL",
        "Zlib",
    }
)

ALLOWED_LICENSES = SPDX_LICENSES | {UNKNOWN, NONFREE}
REQUIRED_KEYS = {"license", "source"}
OPTIONAL_KEYS = {"note"}


def scheme_names(schemes_dir: pathlib.Path = ITERM_SCHEMES_PATH, yaml_dir: pathlib.Path = YAML_SCHEMES_PATH) -> set[str]:
    """Return the display name of every scheme, as gen.py names them."""
    names = {path.stem for path in schemes_dir.glob("*.itermcolors")}
    for path in yaml_dir.glob("*.yml"):
        with path.open("r", encoding="utf-8") as f:
            data = yaml.safe_load(f) or {}
        names.add(str(data.get("name") or path.stem))
    return names


def load_licenses(path: pathlib.Path = LICENSES_PATH) -> dict[str, Any]:
    with path.open("r", encoding="utf-8") as f:
        data = yaml.safe_load(f)
    if data is None:
        return {}
    if not isinstance(data, dict):
        raise ValueError(f"{path}: expected a mapping of scheme names to entries")
    return {str(name): entry for name, entry in data.items()}


def is_spdx(license_id: Any) -> bool:
    """True for a listed SPDX identifier or an SPDX expression of them, such as `MIT OR Apache-2.0`."""
    if not isinstance(license_id, str):
        return False
    parts = re.split(r"\s+(?:OR|AND)\s+", license_id.strip())
    return all(part in SPDX_LICENSES for part in parts)


def is_allowed(license_id: Any) -> bool:
    """True for anything licenses.yml may record: an SPDX licence or expression, unknown or nonfree."""
    return license_id in (UNKNOWN, NONFREE) or is_spdx(license_id)


def is_redistributable(entry: Any) -> bool:
    """True when the entry names an SPDX licence, so not unknown, nonfree or missing."""
    return isinstance(entry, dict) and is_spdx(entry.get("license"))


def check(licenses: dict[str, Any], names: set[str]) -> list[str]:
    """Return a list of problems; an empty list means licenses.yml is valid."""
    errors = []

    for name in sorted(names - licenses.keys()):
        errors.append(f"{name}: no entry in licenses.yml")

    for name in sorted(licenses.keys() - names):
        errors.append(f"{name}: entry in licenses.yml but no such scheme")

    for name, entry in sorted(licenses.items()):
        if not isinstance(entry, dict):
            errors.append(f"{name}: entry must be a mapping with license and source")
            continue

        keys = set(entry)
        for key in sorted(REQUIRED_KEYS - keys):
            errors.append(f"{name}: missing {key!r}")
        for key in sorted(keys - REQUIRED_KEYS - OPTIONAL_KEYS):
            errors.append(f"{name}: unexpected key {key!r}")

        license_id = entry.get("license")
        if "license" in entry and not is_allowed(license_id):
            errors.append(
                f"{name}: license {license_id!r} is not a listed SPDX identifier, {UNKNOWN!r} or {NONFREE!r}"
            )

        source = entry.get("source")
        if "source" in entry and not (
            isinstance(source, str) and (source == "" or source.startswith(("https://", "http://")))
        ):
            errors.append(f"{name}: source must be a URL or an empty string")

        if "note" in entry and not isinstance(entry["note"], str):
            errors.append(f"{name}: note must be text")

    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description="Check licenses.yml against the schemes in the repository.")
    parser.add_argument("--licenses", type=pathlib.Path, default=LICENSES_PATH, help="licence file (default: licenses.yml)")
    parser.add_argument("--schemes-dir", type=pathlib.Path, default=ITERM_SCHEMES_PATH, help="directory of .itermcolors schemes")
    parser.add_argument("--yaml-dir", type=pathlib.Path, default=YAML_SCHEMES_PATH, help="directory of YAML schemes")
    arguments = parser.parse_args()

    try:
        licenses = load_licenses(arguments.licenses)
    except (OSError, ValueError, yaml.YAMLError) as e:
        print(f"Error: {e}", file=sys.stderr)
        return 1

    names = scheme_names(arguments.schemes_dir, arguments.yaml_dir)
    errors = check(licenses, names)
    for error in errors:
        print(error, file=sys.stderr)

    if errors:
        print(f"\n{len(errors)} problem(s) in {arguments.licenses}", file=sys.stderr)
        return 1

    counts = {UNKNOWN: 0, NONFREE: 0}
    for entry in licenses.values():
        if entry["license"] in counts:
            counts[entry["license"]] += 1
    spdx = len(licenses) - counts[UNKNOWN] - counts[NONFREE]
    print(f"{len(licenses)} schemes: {spdx} SPDX, {counts[UNKNOWN]} unknown, {counts[NONFREE]} nonfree")
    return 0


if __name__ == "__main__":
    sys.exit(main())
