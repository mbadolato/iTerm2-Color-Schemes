#!/usr/bin/env python3
"""Add, update, rename or remove entries in licenses.yml.

usage: set_license.py [-h] [--licenses LICENSES] {set,rename,remove} ...

  set_license.py set "Paper Crane" --license MIT --source https://terminalthemes.com/themes/paper-crane
  set_license.py rename "Old Name" "New Name"
  set_license.py remove "Old Name"

Meant for scripts that add schemes, such as the daily sync, so licenses.yml
keeps up with schemes/ and yaml/ without hand edits. The header comment and
every untouched entry are written back exactly as they were, and entries stay
in case-insensitive alphabetical order. Run check_licenses.py afterwards.
"""

from __future__ import annotations

import argparse
import pathlib
import re
import sys

import yaml

from check_licenses import ALLOWED_LICENSES, LICENSES_PATH, NONFREE, UNKNOWN

# an entry starts at a line that is neither indented nor a comment
ENTRY_START = re.compile(r"(?m)^(?=[^\s#])")


def split_entries(text: str) -> tuple[str, dict[str, str]]:
    """Split licenses.yml into its header and the text of each entry, keyed by scheme name."""
    match = ENTRY_START.search(text)
    if match is None:
        return text, {}
    header = text[: match.start()]
    entries = {}
    for block in ENTRY_START.split(text[match.start() :]):
        if not block:
            continue
        data = yaml.safe_load(block)
        if not isinstance(data, dict) or len(data) != 1:
            raise ValueError(f"cannot read the entry starting {block.splitlines()[0]!r}")
        entries[str(next(iter(data)))] = block
    return header, entries


def format_entry(name: str, license_id: str, source: str, note: str | None = None) -> str:
    entry: dict[str, str] = {"license": license_id, "source": source}
    if note:
        entry["note"] = note
    # the same dump settings reproduce every existing entry byte for byte
    return yaml.safe_dump({name: entry}, sort_keys=False, allow_unicode=True, width=10**6)


def join_entries(header: str, entries: dict[str, str]) -> str:
    return header + "".join(entries[name] for name in sorted(entries, key=str.lower))


def set_entry(entries: dict[str, str], name: str, license_id: str, source: str, note: str | None) -> None:
    if license_id not in ALLOWED_LICENSES:
        raise ValueError(
            f"license {license_id!r} is not a listed SPDX identifier, {UNKNOWN!r} or {NONFREE!r}"
            " (add new identifiers to SPDX_LICENSES in check_licenses.py)"
        )
    if source and not source.startswith(("https://", "http://")):
        raise ValueError("source must be a URL or an empty string")
    entries[name] = format_entry(name, license_id, source, note)


def rename_entry(entries: dict[str, str], old: str, new: str) -> None:
    if old not in entries:
        raise ValueError(f"{old}: no entry in licenses.yml")
    if new in entries:
        raise ValueError(f"{new}: already has an entry in licenses.yml")
    data = yaml.safe_load(entries.pop(old))[old]
    entries[new] = yaml.safe_dump({new: data}, sort_keys=False, allow_unicode=True, width=10**6)


def remove_entry(entries: dict[str, str], name: str) -> None:
    if entries.pop(name, None) is None:
        raise ValueError(f"{name}: no entry in licenses.yml")


def main() -> int:
    parser = argparse.ArgumentParser(description="Add, update, rename or remove entries in licenses.yml.")
    parser.add_argument("--licenses", type=pathlib.Path, default=LICENSES_PATH, help="licence file (default: licenses.yml)")
    commands = parser.add_subparsers(dest="command", required=True)

    set_parser = commands.add_parser("set", help="add an entry or replace an existing one")
    set_parser.add_argument("name", help="the scheme's display name")
    set_parser.add_argument("--license", required=True, help=f"an SPDX identifier, {UNKNOWN} or {NONFREE}")
    set_parser.add_argument("--source", default="", help="where the scheme or its licence comes from")
    set_parser.add_argument("--note", help="optional, for example why a licence is unclear")

    rename_parser = commands.add_parser("rename", help="move an entry to a scheme's new name")
    rename_parser.add_argument("old")
    rename_parser.add_argument("new")

    remove_parser = commands.add_parser("remove", help="remove the entry of a deleted scheme")
    remove_parser.add_argument("name")

    arguments = parser.parse_args()

    try:
        header, entries = split_entries(arguments.licenses.read_text(encoding="utf-8"))
        if arguments.command == "set":
            set_entry(entries, arguments.name, arguments.license, arguments.source, arguments.note)
        elif arguments.command == "rename":
            rename_entry(entries, arguments.old, arguments.new)
        else:
            remove_entry(entries, arguments.name)
    except (OSError, ValueError, yaml.YAMLError) as e:
        print(f"Error: {e}", file=sys.stderr)
        return 1

    arguments.licenses.write_text(join_entries(header, entries), encoding="utf-8")
    return 0


if __name__ == "__main__":
    sys.exit(main())
