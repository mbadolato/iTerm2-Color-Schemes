import argparse
import shutil
import subprocess

import rich.progress
from PIL import Image

from screenshot_gen.helpers import (
    screenshot_font_path,
    screenshots_path,
    read_schemes_jsonl,
    get_screenshot_filename,
    font_charset,
)
from screenshot_gen.renderer import ConsoleScreenshotRenderer, PixFont


def generate_images(args, schemes):
    font = PixFont(Image.open(screenshot_font_path).convert("L"), charset=font_charset)
    oxipng_path = shutil.which("oxipng")
    zopflipng_path = shutil.which("zopflipng")
    for name, scheme in rich.progress.track(
        schemes.items(),
        description=f"Generating screenshots for {len(schemes)} schemes...",
    ):
        dest_path = screenshots_path / f"{get_screenshot_filename(name)}.png"
        if dest_path.name.startswith("builtin_"):
            # These ones didn't traditionally have screenshots
            continue
        if not args.force:
            if dest_path.exists():
                if args.verbose:
                    print(f"Skipping {name}, it already exists")
                continue
        img = ConsoleScreenshotRenderer(font, scheme).render()
        img = img.resize((600, 300), resample=Image.Resampling.LANCZOS).convert("RGB")
        if not args.no_optimize and (oxipng_path or zopflipng_path):
            # No need to optimize in PIL
            img.save(dest_path, optimize=False, compress_level=0)
            if oxipng_path:
                subprocess.check_call([oxipng_path, "-o", "max", "--strip", "all", "-q", dest_path])
            if zopflipng_path:
                subprocess.check_call(
                    [zopflipng_path, "-m", "-y", dest_path, dest_path],
                    stdout=subprocess.DEVNULL,
                )
        else:
            img.save(dest_path, optimize=True, compress_level=9)
        print(f"Generated {dest_path.name} for {name}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-f", "--force", action="store_true", help="Force re-rendering")
    ap.add_argument("-v", "--verbose", action="store_true", help="Verbose output")
    ap.add_argument("--no-optimize", action="store_true", help="Don't optimize output, even if tools exist")
    ap.add_argument("schemes", nargs="*", help="Scheme names to render; default: all")
    args = ap.parse_args()

    try:
        schemes = read_schemes_jsonl()
    except FileNotFoundError as fnfe:
        raise RuntimeError("Please run `tools/gen.py` first") from fnfe

    if args.schemes:
        try:
            schemes_to_generate = {name: schemes[name] for name in args.schemes}
        except KeyError as ke:
            raise RuntimeError("Invalid scheme name(s)") from ke
    else:
        schemes_to_generate = schemes

    generate_images(args, schemes=schemes_to_generate)


if __name__ == "__main__":
    main()
