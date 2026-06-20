"""Render display-only theme previews using inline truecolor."""

from __future__ import annotations

from typing import Iterable, List

from gen import Color, Theme

from preview_theme.colors import (
    DIM,
    RESET,
    fill_line,
    fill_line_segments,
    hex_display,
    label_color_for_bg,
    sgr_bg,
    sgr_fg,
)


def _color(theme: Theme, name: str, fallback: str | None = None) -> Color:
    if name in theme.colors:
        return theme.colors[name]
    if fallback and fallback in theme.colors:
        return theme.colors[fallback]
    return Color(128, 128, 128)


def _ansi(theme: Theme, index: int) -> Color:
    return _color(theme, f"Ansi {index} Color")


def _hline(width: int, char: str = "─") -> str:
    return char * width


def _swatch_row(theme: Theme, indices: Iterable[int], width: int) -> List[str]:
    fg = _color(theme, "Foreground Color")
    bg = _color(theme, "Background Color")
    colors = [_ansi(theme, i) for i in indices]
    cell_width = 10
    count = len(colors)
    row_width = count * (cell_width + 1) - 1
    if row_width > width:
        cell_width = max(6, (width - max(count - 1, 0)) // count)

    swatch_out = sgr_bg(bg)
    hex_out = sgr_bg(bg)
    visible = 0

    for index, (ansi_index, color) in enumerate(zip(indices, colors)):
        if index:
            swatch_out += sgr_fg(fg) + " "
            hex_out += sgr_fg(fg) + " "
            visible += 1

        label = label_color_for_bg(color)
        inner = f" {ansi_index} "
        cell = inner.center(cell_width)[:cell_width]
        swatch_out += sgr_fg(label) + sgr_bg(color) + cell
        hex_out += f"{DIM}{sgr_fg(fg)}{hex_display(color):<{cell_width}}"
        visible += cell_width

    if visible < width:
        pad = " " * (width - visible)
        swatch_out += sgr_fg(fg) + pad
        hex_out += sgr_fg(fg) + pad

    return [swatch_out + RESET, hex_out + RESET]


def render_preview(theme: Theme, width: int = 80, *, index: int = 0, total: int = 1) -> str:
    fg = _color(theme, "Foreground Color")
    bg = _color(theme, "Background Color")
    bold = _color(theme, "Bold Color", "Foreground Color")
    selection = _color(theme, "Selection Color")
    selection_text = _color(theme, "Selected Text Color", "Background Color")
    cursor = _color(theme, "Cursor Color", "Foreground Color")
    cursor_text = _color(theme, "Cursor Text Color", "Background Color")

    lines: List[str] = []
    border = _hline(width, "═")

    lines.append(fill_line(border, fg, bg, width))
    title = f" {theme.name} "
    if theme.variant:
        title += f"· {theme.variant} "
    if theme.author:
        title += f"· {theme.author} "
    if total > 1:
        title += f"· [{index + 1}/{total}] "
    lines.append(fill_line(title, fg, bg, width, bold=True))
    if total > 1:
        lines.append(fill_line(" ← → navigate   r redraw   q quit ", _ansi(theme, 6), bg, width))
    lines.append(fill_line(border, fg, bg, width))

    lines.append(fill_line(" ANSI (0–7)", bold, bg, width, bold=True))
    lines.extend(_swatch_row(theme, range(8), width))

    lines.append(fill_line("", fg, bg, width))
    lines.append(fill_line(" ANSI bright (8–15)", bold, bg, width, bold=True))
    lines.extend(_swatch_row(theme, range(8, 16), width))

    lines.append(fill_line("", fg, bg, width))
    lines.append(fill_line(_hline(width), fg, bg, width))
    lines.append(fill_line(" Surfaces", bold, bg, width, bold=True))
    lines.append(
        fill_line(
            " The quick brown fox jumps over the lazy dog. 0123456789 ",
            fg,
            bg,
            width,
        )
    )
    lines.append(fill_line(" Bold body text and emphasis sample ", bold, bg, width, bold=True))
    lines.append(
        fill_line(
            " Selected text on selection background ",
            selection_text,
            selection,
            width,
        )
    )
    lines.append(fill_line(" ▌ cursor sample ", cursor_text, cursor, width))

    lines.append(fill_line("", fg, bg, width))
    lines.append(fill_line(_hline(width), fg, bg, width))
    lines.append(fill_line(" Semantic samples", bold, bg, width, bold=True))
    lines.append(fill_line(" ERROR: connection refused ", _ansi(theme, 1), bg, width))
    lines.append(fill_line(" WARNING: disk space is running low ", _ansi(theme, 3), bg, width))
    lines.append(fill_line(" INFO: background tasks completed ", _ansi(theme, 4), bg, width))
    lines.append(fill_line(" SUCCESS: all tests passed ", _ansi(theme, 2), bg, width))

    lines.append(fill_line("", fg, bg, width))
    lines.append(
        fill_line_segments(
            width,
            bg,
            fg,
            [
                (" Directory listing ", _ansi(theme, 4), False),
                ("drwxr-xr-x  ", _ansi(theme, 4), False),
                ("src/", _ansi(theme, 12), False),
            ],
        )
    )
    lines.append(
        fill_line_segments(
            width,
            bg,
            fg,
            [
                ("-rw-r--r--  ", _ansi(theme, 2), False),
                ("README.md", fg, False),
            ],
        )
    )
    lines.append(
        fill_line_segments(
            width,
            bg,
            fg,
            [
                ("-rwxr-xr-x  ", _ansi(theme, 2), False),
                ("build.sh", _ansi(theme, 10), False),
            ],
        )
    )

    lines.append(fill_line("", fg, bg, width))
    lines.append(fill_line(" Git status ", _ansi(theme, 6), bg, width))
    lines.append(
        fill_line_segments(
            width,
            bg,
            fg,
            [
                ("On branch ", _ansi(theme, 6), False),
                ("main", _ansi(theme, 14), False),
            ],
        )
    )
    lines.append(
        fill_line(
            "Your branch is up to date with 'origin/main'",
            _ansi(theme, 2),
            bg,
            width,
        )
    )
    lines.append(
        fill_line_segments(
            width,
            bg,
            fg,
            [
                ("modified:   ", _ansi(theme, 3), False),
                ("tools/preview_theme.py", fg, False),
            ],
        )
    )
    lines.append(
        fill_line_segments(
            width,
            bg,
            fg,
            [
                ("deleted:    ", _ansi(theme, 1), False),
                ("old/preview.rb", fg, False),
            ],
        )
    )

    lines.append(fill_line(border, fg, bg, width))
    lines.append(
        fill_line(
            " Display-only preview (truecolor SGR) — terminal palette unchanged ",
            _ansi(theme, 8),
            bg,
            width,
        )
    )

    return "\n".join(lines) + "\n"