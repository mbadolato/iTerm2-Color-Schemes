#!/usr/bin/env python3
# pyright: basic

import plistlib
from pathlib import Path
import math
import argparse
import sys
import datetime
from typing import Tuple, Optional, List

def srgb_to_linear(c: float) -> float:
    """Convert sRGB gamma (0-1) to linear light."""
    if c <= 0.04045:
        return c / 12.92
    else:
        return math.pow((c + 0.055) / 1.055, 2.4)

def linear_to_srgb(c: float) -> float:
    """Convert linear light to sRGB gamma (0-1)."""
    if c <= 0.0031308:
        return 12.92 * c
    else:
        return 1.055 * math.pow(c, 1 / 2.4) - 0.055

def p3_to_srgb(r: float, g: float, b: float) -> tuple[float, float, float]:
    """Convert P3 gamma-encoded RGB (0-1) to sRGB gamma-encoded RGB (0-1)."""
    # Convert to linear
    r_lin = srgb_to_linear(r)
    g_lin = srgb_to_linear(g)
    b_lin = srgb_to_linear(b)

    # Matrix: P3 linear to sRGB linear
    matrix = [
        [1.22494018, -0.22469880, -0.00012973],
        [-0.04205631, 1.04203282, -0.00000601],
        [-0.01963755, -0.07862814, 1.09826365]
    ]

    # Apply matrix
    r_s_lin = max(0.0, min(1.0, matrix[0][0] * r_lin + matrix[0][1] * g_lin + matrix[0][2] * b_lin))
    g_s_lin = max(0.0, min(1.0, matrix[1][0] * r_lin + matrix[1][1] * g_lin + matrix[1][2] * b_lin))
    b_s_lin = max(0.0, min(1.0, matrix[2][0] * r_lin + matrix[2][1] * g_lin + matrix[2][2] * b_lin))

    # Convert back to gamma
    r_out = linear_to_srgb(r_s_lin)
    g_out = linear_to_srgb(g_s_lin)
    b_out = linear_to_srgb(b_s_lin)

    return (r_out, g_out, b_out)

def get_rgb(color_dict: dict) -> tuple[float, float, float]:
    """Extract sRGB gamma RGB (0-1) from color dict, converting P3 if needed."""
    r = color_dict.get('Red Component', 0.0)
    g = color_dict.get('Green Component', 0.0)
    b = color_dict.get('Blue Component', 0.0)
    color_space = color_dict.get('Color Space', 'sRGB')
    if color_space == 'P3':
        r, g, b = p3_to_srgb(r, g, b)
    return (r, g, b)

def relative_luminance(rgb: tuple[float, float, float]) -> float:
    """Compute relative luminance per WCAG (sRGB gamma input)."""
    r_lin, g_lin, b_lin = [srgb_to_linear(c) for c in rgb]
    return 0.2126 * r_lin + 0.7152 * g_lin + 0.0722 * b_lin

def contrast_ratio(fg_rgb: tuple[float, float, float], bg_rgb: tuple[float, float, float]) -> float:
    """Compute WCAG contrast ratio between foreground and background."""
    l_fg = relative_luminance(fg_rgb)
    l_bg = relative_luminance(bg_rgb)
    if l_fg < l_bg:
        l_fg, l_bg = l_bg, l_fg  # Ensure l_fg >= l_bg
    return (l_fg + 0.05) / (l_bg + 0.05)

def passes_wcag(ratio: float, threshold: float) -> bool:
    """Check if contrast meets WCAG (threshold:1)."""
    return ratio >= threshold

def suggest_color(fg_rgb: tuple[float, float, float], bg_rgb: tuple[float, float, float], threshold: float) -> Optional[tuple[float, float, float]]:
    """Suggest a adjusted FG color to meet threshold by lightening/darkening."""
    current_ratio = contrast_ratio(fg_rgb, bg_rgb)
    if current_ratio >= threshold:
        return fg_rgb

    l_bg = relative_luminance(bg_rgb)
    step = 0.05  # Small adjustment step
    max_steps = 20  # Prevent infinite loop
    fg = list(fg_rgb)

    # Dark BG: lighten FG towards white
    if l_bg < 0.5:
        for _ in range(max_steps):
            for i in range(3):
                fg[i] = min(1.0, fg[i] + step)
            new_fg = tuple(fg)
            if contrast_ratio(new_fg, bg_rgb) >= threshold:
                return new_fg
    # Light BG: darken FG towards black
    else:
        for _ in range(max_steps):
            for i in range(3):
                fg[i] = max(0.0, fg[i] - step)
            new_fg = tuple(fg)
            if contrast_ratio(new_fg, bg_rgb) >= threshold:
                return new_fg

    # Fallback: extreme (white or black)
    if l_bg < 0.5:
        return (1.0, 1.0, 1.0)
    else:
        return (0.0, 0.0, 0.0)


def check_scheme(plist: dict, scheme_name: str, threshold: float) -> tuple[bool, list[Tuple[str, bool, float, Optional[tuple[float, float, float]], Optional[tuple[float, float, float]], Optional[tuple[float, float, float]]]]]:
    """Run WCAG checks for a single scheme."""
    bg_key = 'Background Color'
    if bg_key not in plist:
        print(f"Warning: {scheme_name} missing {bg_key}, skipping.")
        return False, []

    background_rgb = get_rgb(plist[bg_key])
    checks = []

    # Foreground vs background
    fg_key = 'Foreground Color'
    if fg_key in plist:
        fg_rgb = get_rgb(plist[fg_key])
        ratio = contrast_ratio(fg_rgb, background_rgb)
        passed = passes_wcag(ratio, threshold)
        suggested_fg = suggest_color(fg_rgb, background_rgb, threshold) if not passed else None
        checks.append((fg_key, passed, ratio, fg_rgb, background_rgb, suggested_fg))
    else:
        checks.append((fg_key, False, 0.0, None, None, None))

    # ANSI 1-14 vs background
    for i in range(1, 15):
        key = f'Ansi {i} Color'
        if key in plist:
            ansi_rgb = get_rgb(plist[key])
            ratio = contrast_ratio(ansi_rgb, background_rgb)
            passed = passes_wcag(ratio, threshold)
            suggested_fg = suggest_color(ansi_rgb, background_rgb, threshold) if not passed else None
            checks.append((key, passed, ratio, ansi_rgb, background_rgb, suggested_fg))
        else:
            checks.append((key, False, 0.0, None, None, None))  # Missing = fail

    # Cursor color vs background
    cursor_key = 'Cursor Color'
    if cursor_key in plist:
        cursor_rgb = get_rgb(plist[cursor_key])
        ratio = contrast_ratio(cursor_rgb, background_rgb)
        passed = passes_wcag(ratio, threshold)
        suggested_fg = suggest_color(cursor_rgb, background_rgb, threshold) if not passed else None
        checks.append((cursor_key, passed, ratio, cursor_rgb, background_rgb, suggested_fg))
    else:
        checks.append((cursor_key, False, 0.0, None, None, None))

    # Selected text vs selection background
    sel_bg_key = 'Selection Color'
    sel_text_key = 'Selected Text Color'
    if sel_bg_key in plist and sel_text_key in plist:
        sel_bg_rgb = get_rgb(plist[sel_bg_key])
        sel_text_rgb = get_rgb(plist[sel_text_key])
        ratio = contrast_ratio(sel_text_rgb, sel_bg_rgb)
        passed = passes_wcag(ratio, threshold)
        suggested_fg = suggest_color(sel_text_rgb, sel_bg_rgb, threshold) if not passed else None
        checks.append(('Selection (text on bg)', passed, ratio, sel_text_rgb, sel_bg_rgb, suggested_fg))
    else:
        checks.append(('Selection', False, 0.0, None, None, None))

    all_pass = all(passed for _, passed, _, _, _, _ in checks)
    return all_pass, checks

def generate_html(total_failing: int, total_schemes: int, failing_schemes: list, threshold: float) -> str:
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WCAG Contrast Check Results</title>
</head>
<body style="font-family: monospace; margin: 20px; line-height: 1.4;">
    <pre style="font-size: 1.2em; font-weight: bold; margin: 0;">Summary: {total_failing}/{total_schemes} schemes fail WCAG checks (threshold {threshold}:1). Generated: {timestamp}</pre>
"""
    if total_failing == 0:
        html += f'<p style="font-size: 1.1em; color: green;">All schemes pass! 🎉</p>'
    else:
        html += '<h2 style="color: #333; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Failing schemes:</h2>'
        for name, checks in failing_schemes:
            html += f'<div style="margin-top: 20px;"><h3 style="margin: 0; color: #555;">{name}</h3><ul style="margin: 10px 0; padding-left: 20px;">'
            for check_name, passed, ratio, fg_rgb, bg_rgb, suggested_fg in checks:
                if not passed:
                    status = "FAIL" if ratio == 0.0 else f"FAIL ({ratio:.2f}:1)"
                    if fg_rgb is None or bg_rgb is None:
                        html += f'<li style="margin: 5px 0;">{check_name}: <span style="color: red; font-weight: bold;">{status}</span> (needs &ge; {threshold}:1)</li>'
                    else:
                        r_fg, g_fg, b_fg = [int(c * 255) for c in fg_rgb]
                        r_bg, g_bg, b_bg = [int(c * 255) for c in bg_rgb]
                        demo_style = f'background-color: rgb({r_bg}, {g_bg}, {b_bg}); color: rgb({r_fg}, {g_fg}, {b_fg}); padding: 2px 4px; margin: 0 2px; border: 1px solid #ccc;'
                        html += f'<li style="margin: 5px 0;"><span style="{demo_style}">{check_name}</span> {check_name}: <span style="color: red; font-weight: bold;">{status}</span> (needs &ge; {threshold}:1)'
                        if suggested_fg:
                            r_s, g_s, b_s = [int(c * 255) for c in suggested_fg]
                            new_ratio = contrast_ratio(suggested_fg, bg_rgb)
                            suggest_style = f'background-color: rgb({r_bg}, {g_bg}, {b_bg}); color: rgb({r_s}, {g_s}, {b_s}); padding: 2px 4px; margin: 0 2px; border: 1px solid #ccc;'
                            html += f' | Suggested: <span style="{suggest_style}">RGB({r_s},{g_s},{b_s}) ratio {new_ratio:.2f}:1</span></li>'
                        else:
                            html += '</li>'
            html += '</ul></div>'
    html += "</body></html>"
    return html

def generate_markdown(total_failing: int, total_schemes: int, failing_schemes: list, threshold: float) -> str:
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    md = "# WCAG Contrast Check Results\n\n"
    md += f"**Summary:** {total_failing}/{total_schemes} schemes fail WCAG checks (threshold {threshold}:1). Generated: {timestamp}\n\n"
    if total_failing == 0:
        md += "All schemes pass! 🎉\n"
    else:
        md += "## Failing schemes\n\n"
        for name, checks in failing_schemes:
            md += f"### {name}\n\n"
            for check_name, passed, ratio, fg_rgb, bg_rgb, suggested_fg in checks:
                if not passed:
                    status = "FAIL" if ratio == 0.0 else f"FAIL ({ratio:.2f}:1)"
                    if fg_rgb is None or bg_rgb is None:
                        md += f"- {check_name}: **{status}** (needs >= {threshold}:1)\n"
                    else:
                        r_fg, g_fg, b_fg = [int(c * 255) for c in fg_rgb]
                        r_bg, g_bg, b_bg = [int(c * 255) for c in bg_rgb]
                        fg_hex = f"{r_fg:02x}{g_fg:02x}{b_fg:02x}".upper()
                        bg_hex = f"{r_bg:02x}{g_bg:02x}{b_bg:02x}".upper()
                        md += f"- `{check_name}` (FG: #{fg_hex} BG: #{bg_hex}): **{status}** (needs >= {threshold}:1)"
                        if suggested_fg:
                            r_s, g_s, b_s = [int(c * 255) for c in suggested_fg]
                            new_ratio = contrast_ratio(suggested_fg, bg_rgb)
                            suggest_hex = f"{r_s:02x}{g_s:02x}{b_s:02x}".upper()
                            md += f" | Suggested FG: #{suggest_hex} (RGB: ({r_s},{g_s},{b_s}) new ratio: {new_ratio:.2f}:1)"
                        md += "\n"
            md += "\n"
    return md

def main():
    parser = argparse.ArgumentParser(description="WCAG contrast checker for iTerm2 schemes.")
    parser.add_argument('--schemes-dir', default='schemes', help="Directory containing .itermcolors files (default: 'schemes')")
    parser.add_argument('--threshold', type=float, default=4.5, help="WCAG contrast threshold (default: 4.5)")
    parser.add_argument('--output', choices=['console', 'html', 'markdown'], default='console', help="Output format (default: 'console')")
    args = parser.parse_args()

    output_mode = args.output

    schemes_dir = Path(args.schemes_dir)
    threshold = args.threshold
    iterm_files = list(schemes_dir.glob('*.itermcolors'))
    if not iterm_files:
        print(f"No .itermcolors files found in {schemes_dir}.")
        return

    if output_mode == 'console':
        print(f"Checking {len(iterm_files)} schemes for WCAG compliance ({threshold}:1 contrast)...\n", file=sys.stderr)

    failing_schemes = []
    for file_path in sorted(iterm_files):  # Sort for consistent output
        try:
            with open(file_path, 'rb') as f:
                plist = plistlib.load(f)
            name = file_path.stem
            all_pass, checks = check_scheme(plist, name, threshold)
            if not all_pass:
                failing_schemes.append((name, checks))
        except Exception as e:
            print(f"Error parsing {file_path.name}: {e}")

    total_failing = len(failing_schemes)
    total_schemes = len(iterm_files)
    if output_mode == 'console':
        print(f"\nSummary: {total_failing}/{total_schemes} schemes fail WCAG checks.")
        if total_failing == 0:
            print("All schemes pass! 🎉")
            return

        # ANSI codes
        RESET = "\033[0m"
        RED = "\033[31m"

        print(f"\nSummary: {total_failing}/{total_schemes} schemes fail WCAG checks.")
        timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        print(f"Generated: {timestamp}")
        if total_failing == 0:
            print("All schemes pass! 🎉")
            return

        # ANSI codes
        RESET = "\033[0m"
        RED = "\033[31m"

        print("\nFailing schemes:")
        for name, checks in failing_schemes:
            print(f"\n{name}:")
            for check_name, passed, ratio, fg_rgb, bg_rgb, suggested_fg in checks:
                if not passed:
                    status = "FAIL" if ratio == 0.0 else f"FAIL ({ratio:.2f}:1)"
                    if fg_rgb is None or bg_rgb is None:
                        # Missing colors: plain red FAIL
                        print(f"  - {check_name}: {RED}{status}{RESET} (needs >= {threshold}:1)")
                    else:
                        # Visual demo with true color
                        r_fg, g_fg, b_fg = [int(c * 255) for c in fg_rgb]
                        r_bg, g_bg, b_bg = [int(c * 255) for c in bg_rgb]
                        color_demo = f"\033[48;2;{r_bg};{g_bg};{b_bg}m\033[38;2;{r_fg};{g_fg};{b_fg}m{check_name}{RESET}"
                        print(f"  - {color_demo} {check_name}: {status} (needs >= {threshold}:1)")
                        if suggested_fg:
                            r_s, g_s, b_s = [int(c * 255) for c in suggested_fg]
                            new_ratio = contrast_ratio(suggested_fg, bg_rgb)
                            suggest_demo = f"\033[48;2;{r_bg};{g_bg};{b_bg}m\033[38;2;{r_s};{g_s};{b_s}mSuggested RGB({r_s},{g_s},{b_s}){RESET}"
                            print(f"    Suggested: {suggest_demo} (new ratio: {new_ratio:.2f}:1)")
    elif output_mode == 'markdown':
        md = generate_markdown(total_failing, total_schemes, failing_schemes, threshold)
        print(md)
    else:
        html = generate_html(total_failing, total_schemes, failing_schemes, threshold)
        print(html)

if __name__ == "__main__":
    main()
