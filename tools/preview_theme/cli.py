#!/usr/bin/env python3
"""Display-only terminal theme preview (no palette mutation)."""

from __future__ import annotations

import argparse
import pathlib
import sys

TOOLS_PATH = pathlib.Path(__file__).resolve().parent.parent
if str(TOOLS_PATH) not in sys.path:
    sys.path.insert(0, str(TOOLS_PATH))

from gen import Theme  # noqa: E402
from preview_theme.loader import resolve_themes  # noqa: E402
from preview_theme.render import render_preview  # noqa: E402
from preview_theme.terminal import clear_screen, is_tty, parse_key, read_key, terminal_width  # noqa: E402


def _write_preview(theme: Theme, *, index: int, total: int, width: int, no_clear: bool) -> None:
    if not no_clear:
        clear_screen()
    sys.stdout.write(render_preview(theme, width, index=index, total=total))
    sys.stdout.flush()


def run_interactive(themes: list[Theme], width: int, no_clear: bool) -> int:
    current = 0
    total = len(themes)

    while True:
        _write_preview(themes[current], index=current, total=total, width=width, no_clear=no_clear)
        action = parse_key(read_key())
        if action == "quit":
            if not no_clear:
                clear_screen()
            print("Preview exited.")
            return 0
        if action == "next":
            current = (current + 1) % total
        elif action == "prev":
            current = (current - 1) % total
        elif action == "redraw":
            continue


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Display a truecolor terminal preview of color schemes (does not modify the terminal palette).",
    )
    parser.add_argument(
        "paths",
        nargs="*",
        type=pathlib.Path,
        help="Path to .itermcolors or .yml theme files",
    )
    parser.add_argument(
        "-s",
        "--scheme",
        nargs="+",
        dest="scheme",
        metavar="NAME",
        help="Theme name(s) to preview (stem of schemes/ or yaml/ file)",
    )
    parser.add_argument(
        "--width",
        type=int,
        default=0,
        help="Preview width in columns (default: terminal width)",
    )
    parser.add_argument(
        "--clear",
        action="store_true",
        help="Clear the screen before drawing (default: append to scrollback)",
    )
    args = parser.parse_args(argv)
    no_clear = not args.clear

    try:
        themes = resolve_themes(args.scheme, list(args.paths))
    except (FileNotFoundError, ValueError) as exc:
        print(exc, file=sys.stderr)
        return 1

    width = args.width or terminal_width()

    if is_tty() and len(themes) > 1:
        return run_interactive(themes, width, no_clear)

    for index, theme in enumerate(themes):
        _write_preview(
            theme,
            index=index,
            total=len(themes),
            width=width,
            no_clear=no_clear,
        )

    if len(themes) == 1 and is_tty() and not no_clear:
        print("Press q to quit.", file=sys.stderr)
        while True:
            action = parse_key(read_key())
            if action in {"quit", "redraw"}:
                if action == "quit" and not no_clear:
                    clear_screen()
                break

    return 0


if __name__ == "__main__":
    raise SystemExit(main())