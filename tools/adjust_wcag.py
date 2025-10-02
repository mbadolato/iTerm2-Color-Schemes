#!/usr/bin/env python3
# pyright: basic

import plistlib
import yaml
from pathlib import Path
import math
import argparse
import sys
import datetime
from typing import Dict, Any, Tuple, Optional

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

def get_rgb_plist(color_dict: Dict[str, Any]) -> tuple[float, float, float]:
    """Extract sRGB gamma RGB (0-1) from plist color dict, converting P3 if needed."""
    r = color_dict.get('Red Component', 0.0)
    g = color_dict.get('Green Component', 0.0)
    b = color_dict.get('Blue Component', 0.0)
    color_space = color_dict.get('Color Space', 'sRGB')
    if color_space == 'P3':
        r, g, b = p3_to_srgb(r, g, b)
    return (r, g, b)

def hex_to_rgb(hex_str: str) -> tuple[float, float, float]:
    """Convert hex string (e.g., '#rrggbb') to sRGB gamma RGB (0-1)."""
    hex_str = hex_str.lstrip('#')
    r = int(hex_str[0:2], 16) / 255.0
    g = int(hex_str[2:4], 16) / 255.0
    b = int(hex_str[4:6], 16) / 255.0
    return (r, g, b)

def rgb_to_hex(rgb: tuple[float, float, float]) -> str:
    """Convert sRGB gamma RGB (0-1) to hex string '#rrggbb'."""
    r, g, b = [int(c * 255) for c in rgb]
    return f"#{r:02x}{g:02x}{b:02x}"

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

def suggest_color(fg_rgb: tuple[float, float, float], bg_rgb: tuple[float, float, float], threshold: float) -> tuple[float, float, float]:
    """Suggest an adjusted FG color to meet threshold by lightening/darkening."""
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

def adjust_plist_colors(plist: Dict[str, Any], scheme_name: str, threshold: float, dry_run: bool = False) -> bool:
    """Adjust colors in plist dict for WCAG compliance. Returns True if any changes made."""
    changed = False
    if 'Background Color' not in plist:
        return changed

    bg_dict = plist['Background Color']
    bg_rgb = get_rgb_plist(bg_dict)

    # Targets against background
    targets = ['Foreground Color'] + [f'Ansi {i} Color' for i in range(1, 15)] + ['Cursor Color']
    for color_name in targets:
        if color_name in plist:
            color_dict = plist[color_name]
            fg_rgb = get_rgb_plist(color_dict)
            old_ratio = contrast_ratio(fg_rgb, bg_rgb)
            if not passes_wcag(old_ratio, threshold):
                suggested_rgb = suggest_color(fg_rgb, bg_rgb, threshold)
                new_ratio = contrast_ratio(suggested_rgb, bg_rgb)
                old_rgb_int = tuple(int(c * 255) for c in fg_rgb)
                new_rgb_int = tuple(int(c * 255) for c in suggested_rgb)
                if dry_run:
                    print(
                        f"Would adjust {color_name} in {scheme_name} from RGB{old_rgb_int} to RGB{new_rgb_int}: "
                        f"old ratio {old_ratio:.2f} -> new {new_ratio:.2f}",
                        file=sys.stderr
                    )
                else:
                    # Update plist
                    color_dict['Red Component'] = suggested_rgb[0]
                    color_dict['Green Component'] = suggested_rgb[1]
                    color_dict['Blue Component'] = suggested_rgb[2]
                    print(
                        f"Adjusted {color_name} in {scheme_name} from RGB{old_rgb_int} to RGB{new_rgb_int}: "
                        f"old ratio {old_ratio:.2f} -> new {new_ratio:.2f}",
                        file=sys.stderr
                    )
                    changed = True

    # Selection: Selected Text Color against Selection Color
    if 'Selection Color' in plist and 'Selected Text Color' in plist:
        sel_bg_dict = plist['Selection Color']
        sel_bg_rgb = get_rgb_plist(sel_bg_dict)
        sel_text_dict = plist['Selected Text Color']
        sel_text_rgb = get_rgb_plist(sel_text_dict)
        old_ratio = contrast_ratio(sel_text_rgb, sel_bg_rgb)
        if not passes_wcag(old_ratio, threshold):
            suggested_rgb = suggest_color(sel_text_rgb, sel_bg_rgb, threshold)
            new_ratio = contrast_ratio(suggested_rgb, sel_bg_rgb)
            old_rgb_int = tuple(int(c * 255) for c in sel_text_rgb)
            new_rgb_int = tuple(int(c * 255) for c in suggested_rgb)
            if dry_run:
                print(
                    f"Would adjust Selected Text Color in {scheme_name} from RGB{old_rgb_int} to RGB{new_rgb_int}: "
                    f"old ratio {old_ratio:.2f} -> new {new_ratio:.2f}",
                    file=sys.stderr
                )
            else:
                sel_text_dict['Red Component'] = suggested_rgb[0]
                sel_text_dict['Green Component'] = suggested_rgb[1]
                sel_text_dict['Blue Component'] = suggested_rgb[2]
                print(
                    f"Adjusted Selected Text Color in {scheme_name} from RGB{old_rgb_int} to RGB{new_rgb_int}: "
                    f"old ratio {old_ratio:.2f} -> new {new_ratio:.2f}",
                    file=sys.stderr
                )
                changed = True
    return changed

def adjust_yaml_colors(data: Dict[str, Any], scheme_name: str, threshold: float, dry_run: bool = False) -> bool:
    """Adjust colors in YAML dict for WCAG compliance. Returns True if any changes made."""
    changed = False
    yaml_to_iterm = {
        "foreground": "Foreground Color",
        "color_02": "Ansi 1 Color", "color_03": "Ansi 2 Color", "color_04": "Ansi 3 Color",
        "color_05": "Ansi 4 Color", "color_06": "Ansi 5 Color", "color_07": "Ansi 6 Color",
        "color_08": "Ansi 7 Color", "color_09": "Ansi 8 Color", "color_10": "Ansi 9 Color",
        "color_11": "Ansi 10 Color", "color_12": "Ansi 11 Color", "color_13": "Ansi 12 Color",
        "color_14": "Ansi 13 Color", "cursor": "Cursor Color",
        "selection": "Selection Color", "selection_text": "Selected Text Color",
    }
    iterm_to_yaml = {v: k for k, v in yaml_to_iterm.items()}

    if 'background' not in data:
        return changed

    bg_hex = data['background']
    bg_rgb = hex_to_rgb(bg_hex)

    # Targets against background
    targets = ['foreground'] + [f'color_0{i}' for i in range(2, 15)] + ['cursor']
    for yaml_key in targets:
        if yaml_key in data:
            fg_hex = data[yaml_key]
            fg_rgb = hex_to_rgb(fg_hex)
            old_ratio = contrast_ratio(fg_rgb, bg_rgb)
            if not passes_wcag(old_ratio, threshold):
                suggested_rgb = suggest_color(fg_rgb, bg_rgb, threshold)
                new_ratio = contrast_ratio(suggested_rgb, bg_rgb)
                old_rgb_int = tuple(int(c * 255) for c in fg_rgb)
                new_rgb_int = tuple(int(c * 255) for c in suggested_rgb)
                if dry_run:
                    print(
                        f"Would adjust {yaml_key} in {scheme_name} from RGB{old_rgb_int} to RGB{new_rgb_int}: "
                        f"old ratio {old_ratio:.2f} -> new {new_ratio:.2f}",
                        file=sys.stderr
                    )
                else:
                    data[yaml_key] = rgb_to_hex(suggested_rgb)
                    print(
                        f"Adjusted {yaml_key} in {scheme_name} from RGB{old_rgb_int} to RGB{new_rgb_int}: "
                        f"old ratio {old_ratio:.2f} -> new {new_ratio:.2f}",
                        file=sys.stderr
                    )
                    changed = True

    # Selection: selection_text against selection
    if 'selection' in data and 'selection_text' in data:
        sel_bg_hex = data['selection']
        sel_bg_rgb = hex_to_rgb(sel_bg_hex)
        sel_text_hex = data['selection_text']
        sel_text_rgb = hex_to_rgb(sel_text_hex)
        old_ratio = contrast_ratio(sel_text_rgb, sel_bg_rgb)
        if not passes_wcag(old_ratio, threshold):
            suggested_rgb = suggest_color(sel_text_rgb, sel_bg_rgb, threshold)
            new_ratio = contrast_ratio(suggested_rgb, sel_bg_rgb)
            old_rgb_int = tuple(int(c * 255) for c in sel_text_rgb)
            new_rgb_int = tuple(int(c * 255) for c in suggested_rgb)
            if dry_run:
                print(
                    f"Would adjust selection_text in {scheme_name} from RGB{old_rgb_int} to RGB{new_rgb_int}: "
                    f"old ratio {old_ratio:.2f} -> new {new_ratio:.2f}",
                    file=sys.stderr
                )
            else:
                data['selection_text'] = rgb_to_hex(suggested_rgb)
                print(
                    f"Adjusted selection_text in {scheme_name} from RGB{old_rgb_int} to RGB{new_rgb_int}: "
                    f"old ratio {old_ratio:.2f} -> new {new_ratio:.2f}",
                    file=sys.stderr
                )
                changed = True
    return changed

def process_itermcolors(schemes_dir: Path, threshold: float, dry_run: bool) -> None:
    """Process all .itermcolors files in schemes_dir."""
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    print(f"WCAG Adjustment started: {timestamp} (threshold {threshold}:1, dry-run: {dry_run})", file=sys.stderr)

    for file_path in schemes_dir.glob('*.itermcolors'):
        try:
            with open(file_path, 'rb') as f:
                plist = plistlib.load(f)
            scheme_name = file_path.stem
            changed = adjust_plist_colors(plist, scheme_name, threshold, dry_run)
            if changed:
                if not dry_run:
                    with open(file_path, 'wb') as f:
                        plistlib.dump(plist, f)
                    print(f"Updated {file_path.name}", file=sys.stderr)
                else:
                    print(f"Dry-run: Would update {file_path.name}", file=sys.stderr)
            else:
                print(f"No changes needed for {file_path.name}", file=sys.stderr)
        except Exception as e:
            print(f"Error processing {file_path.name}: {e}", file=sys.stderr)

def process_yaml(yaml_dir: Path, threshold: float, dry_run: bool) -> None:
    """Process all .yml files in yaml_dir."""
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    print(f"WCAG Adjustment started: {timestamp} (threshold {threshold}:1, dry-run: {dry_run})", file=sys.stderr)

    for file_path in yaml_dir.glob('*.yml'):
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = yaml.safe_load(f)
            scheme_name = file_path.stem
            changed = adjust_yaml_colors(data, scheme_name, threshold, dry_run)
            if changed:
                if not dry_run:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        yaml.dump(data, f, default_flow_style=False, sort_keys=False)
                    print(f"Updated {file_path.name}", file=sys.stderr)
                else:
                    print(f"Dry-run: Would update {file_path.name}", file=sys.stderr)
            else:
                print(f"No changes needed for {file_path.name}", file=sys.stderr)
        except Exception as e:
            print(f"Error processing {file_path.name}: {e}", file=sys.stderr)

def main():
    parser = argparse.ArgumentParser(description="Adjust iTerm2 schemes for WCAG contrast compliance.")
    parser.add_argument('--threshold', type=float, default=1.75, help="WCAG contrast threshold (default: 1.75)")
    parser.add_argument('--dry-run', action='store_true', help="Log changes without overwriting files")
    parser.add_argument('--schemes-dir', default='schemes', help="Directory for .itermcolors files (default: 'schemes')")
    parser.add_argument('--yaml-dir', default='yaml', help="Directory for .yml files (default: 'yaml')")
    args = parser.parse_args()

    schemes_dir = Path(args.schemes_dir)
    yaml_dir = Path(args.yaml_dir)
    threshold = args.threshold
    dry_run = args.dry_run

    if schemes_dir.exists():
        process_itermcolors(schemes_dir, threshold, dry_run)
    else:
        print(f"Schemes dir '{schemes_dir}' not found.", file=sys.stderr)

    if yaml_dir.exists():
        process_yaml(yaml_dir, threshold, dry_run)
    else:
        print(f"YAML dir '{yaml_dir}' not found.", file=sys.stderr)

    print("WCAG Adjustment completed.", file=sys.stderr)

if __name__ == "__main__":
    main()