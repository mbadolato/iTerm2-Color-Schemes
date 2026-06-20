"""Render display-only theme previews using inline truecolor."""

from __future__ import annotations

from typing import Iterable, List

from gen import Color, Theme

from preview_theme.colors import DIM, RESET, hex_display, label_color_for_bg, sgr_fg, styled


def _color(theme: Theme, name: str, fallback: str | None = None) -> Color:
    if name in theme.colors:
        return theme.colors[name]
    if fallback and fallback in theme.colors:
        return theme.colors[fallback]
    return Color(128, 128, 128)


def _ansi(theme: Theme, index: int) -> Color:
    return _color(theme, f"Ansi {index} Color")


def _hline(width: int, char: str = "─") -> str:
    return char * max(width, 20)


def _swatch_cell(index: int, color: Color, cell_width: int = 10) -> str:
    label = label_color_for_bg(color)
    inner = f" {index} "
    pad = max(cell_width - len(inner), 0)
    left = pad // 2
    right = pad - left
    block = " " * left + inner + " " * right
    return styled(block[:cell_width].ljust(cell_width), label, color)


def _swatch_row(theme: Theme, indices: Iterable[int], width: int) -> List[str]:
    colors = [_ansi(theme, i) for i in indices]
    cell_width = 10
    count = len(colors)
    row_width = count * (cell_width + 1)
    if row_width > width:
        cell_width = max(6, (width - count) // count)

    swatches = " ".join(_swatch_cell(i, c, cell_width) for i, c in zip(indices, colors))
    hexes = " ".join(
        f"{DIM}{sgr_fg(_color(theme, 'Foreground Color'))}{hex_display(c):<{cell_width}}{RESET}"
        for c in colors
    )
    return [swatches, hexes]


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

    lines.append(styled(border, fg, bg))
    title = f" {theme.name} "
    if theme.variant:
        title += f"· {theme.variant} "
    if theme.author:
        title += f"· {theme.author} "
    if total > 1:
        title += f"· [{index + 1}/{total}] "
    lines.append(styled(title[: width - 2], fg, bg, bold=True))
    if total > 1:
        lines.append(styled(" ← → navigate   r redraw   q quit ", _ansi(theme, 6), bg))
    lines.append(styled(border, fg, bg))

    lines.append(styled(" ANSI (0–7)", bold, bg, bold=True))
    lines.extend(styled(line, fg, bg) for line in _swatch_row(theme, range(8), width))

    lines.append("")
    lines.append(styled(" ANSI bright (8–15)", bold, bg, bold=True))
    lines.extend(styled(line, fg, bg) for line in _swatch_row(theme, range(8, 16), width))

    lines.append("")
    lines.append(styled(_hline(width), fg, bg))
    lines.append(styled(" Surfaces", bold, bg, bold=True))
    lines.append(
        styled(
            f" {'The quick brown fox jumps over the lazy dog. 0123456789'} ",
            fg,
            bg,
        )
    )
    lines.append(styled(f" {'Bold body text and emphasis sample'} ", bold, bg, bold=True))
    lines.append(
        styled(
            f" {'Selected text on selection background'} ",
            selection_text,
            selection,
        )
    )
    lines.append(
        styled(
            f" {'▌ cursor sample'} ",
            cursor_text,
            cursor,
        )
    )

    lines.append("")
    lines.append(styled(_hline(width), fg, bg))
    lines.append(styled(" Semantic samples", bold, bg, bold=True))
    lines.append(styled(" ERROR: connection refused ", _ansi(theme, 1), bg))
    lines.append(styled(" WARNING: disk space is running low ", _ansi(theme, 3), bg))
    lines.append(styled(" INFO: background tasks completed ", _ansi(theme, 4), bg))
    lines.append(styled(" SUCCESS: all tests passed ", _ansi(theme, 2), bg))

    lines.append("")
    lines.append(styled(" Directory listing ", _ansi(theme, 4), bg) + styled("drwxr-xr-x  ", _ansi(theme, 4), bg) + styled("src/", _ansi(theme, 12), bg))
    lines.append(styled("-rw-r--r--  ", _ansi(theme, 2), bg) + styled("README.md", fg, bg))
    lines.append(styled("-rwxr-xr-x  ", _ansi(theme, 2), bg) + styled("build.sh", _ansi(theme, 10), bg))

    lines.append("")
    lines.append(styled(" Git status ", _ansi(theme, 6), bg))
    lines.append(
        styled("On branch ", _ansi(theme, 6), bg)
        + styled("main", _ansi(theme, 14), bg)
    )
    lines.append(styled("Your branch is up to date with 'origin/main'", _ansi(theme, 2), bg))
    lines.append(styled("modified:   ", _ansi(theme, 3), bg) + styled("tools/preview_theme.py", fg, bg))
    lines.append(styled("deleted:    ", _ansi(theme, 1), bg) + styled("old/preview.rb", fg, bg))

    lines.append(styled(border, fg, bg))
    lines.append(
        styled(
            f" Display-only preview (truecolor SGR) — terminal palette unchanged ",
            _ansi(theme, 8),
            bg,
        )
    )

    return "\n".join(lines) + "\n"