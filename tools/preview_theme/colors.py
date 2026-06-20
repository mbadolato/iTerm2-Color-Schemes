"""Truecolor SGR helpers for display-only terminal preview."""

from __future__ import annotations

from gen import Color

RESET = "\033[0m"
BOLD = "\033[1m"
DIM = "\033[2m"


def sgr_fg(color: Color) -> str:
    return f"\033[38;2;{color.r};{color.g};{color.b}m"


def sgr_bg(color: Color) -> str:
    return f"\033[48;2;{color.r};{color.g};{color.b}m"


def sgr_fg_bg(fg: Color, bg: Color, *, bold: bool = False) -> str:
    prefix = BOLD if bold else ""
    return f"{prefix}{sgr_fg(fg)}{sgr_bg(bg)}"


def hex_display(color: Color) -> str:
    return f"#{color.hex.upper()}"


def label_color_for_bg(bg: Color) -> Color:
    luminance = 0.2126 * bg.r + 0.7152 * bg.g + 0.0722 * bg.b
    return Color(30, 30, 30) if luminance > 140 else Color(240, 240, 240)


def styled(text: str, fg: Color, bg: Color | None = None, *, bold: bool = False) -> str:
    if bg is None:
        prefix = (BOLD if bold else "") + sgr_fg(fg)
        return f"{prefix}{text}{RESET}"
    return f"{sgr_fg_bg(fg, bg, bold=bold)}{text}{RESET}"


def fill_line(text: str, fg: Color, bg: Color, width: int, *, bold: bool = False) -> str:
    """Render text on bg, padded with spaces to full terminal width."""
    truncated = text[:width]
    padding = " " * max(width - len(truncated), 0)
    return f"{sgr_fg_bg(fg, bg, bold=bold)}{truncated}{padding}{RESET}"


def fill_line_segments(
    width: int,
    bg: Color,
    pad_fg: Color,
    segments: list[tuple[str, Color, bool]],
) -> str:
    """Render colored segments on a shared bg, padded to full terminal width."""
    out = sgr_bg(bg)
    visible = 0
    for text, fg, is_bold in segments:
        out += (BOLD if is_bold else "") + sgr_fg(fg) + text
        visible += len(text)
    if visible < width:
        out += sgr_fg(pad_fg) + (" " * (width - visible))
    return out + RESET