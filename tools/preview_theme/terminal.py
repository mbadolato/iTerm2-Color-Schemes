"""Terminal utilities for interactive preview."""

from __future__ import annotations

import shutil
import sys
import termios
import tty
from typing import Optional


def is_tty() -> bool:
    return sys.stdout.isatty() and sys.stdin.isatty()


def terminal_width(default: int = 80) -> int:
    try:
        return shutil.get_terminal_size((default, 24)).columns
    except OSError:
        return default


def clear_screen() -> None:
    sys.stdout.write("\033[2J\033[H")
    sys.stdout.flush()


def read_key() -> str:
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        tty.setraw(fd)
        ch = sys.stdin.read(1)
        if ch == "\x03":
            return "ctrl-c"
        if ch == "\x1b":
            ch += sys.stdin.read(2)
        elif ch == "\x7f":
            return "backspace"
        return ch
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)


def parse_key(key: str) -> Optional[str]:
    if key in {"q", "Q", "\x1b"}:
        return "quit"
    if key == "r":
        return "redraw"
    if key in {"\x1b[C", "\x1b[6~"}:
        return "next"
    if key in {"\x1b[D", "\x1b[5~"}:
        return "prev"
    if key == "ctrl-c":
        return "quit"
    return None