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


def save_scaling_tests(img, dest_path_base):
    img.save(dest_path_base.with_suffix(".UNSCALED.png"), optimize=True, compress_level=9)
    for resampling in Image.Resampling:
        img2 = img.resize((600, 300), resample=resampling).convert("RGB")
        img2.save(dest_path_base.with_suffix(f".{resampling.name}.png"), optimize=True, compress_level=9)


def save_downscaled(img, dest_path, *, no_optimize: bool = False):
    oxipng_path = shutil.which("oxipng")
    zopflipng_path = shutil.which("zopflipng")
    img = img.resize((600, 300), resample=Image.Resampling.BOX).convert("RGB")
    if not no_optimize and (oxipng_path or zopflipng_path):
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


def generate_images(args, schemes):
    font = PixFont(Image.open(screenshot_font_path).convert("L"), charset=font_charset)

    no_optimize = args.no_optimize
    for name, scheme in rich.progress.track(
        schemes.items(),
        description=f"Generating screenshots for {len(schemes)} schemes...",
    ):
        dest_path_base = screenshots_path / f"{get_screenshot_filename(name)}"
        dest_path = dest_path_base.with_suffix(".png")
        if dest_path.name.startswith("builtin_"):
            # These ones didn't traditionally have screenshots
            continue
        if not args.force:
            if dest_path.exists():
                if args.verbose:
                    print(f"Skipping {name}, it already exists")
                continue
        img = ConsoleScreenshotRenderer(font, scheme).render()

        if args.scaling_test_mode:
            save_scaling_tests(img, dest_path_base)
            print(f"Generated scaling test images for {name}")
        else:
            save_downscaled(img, dest_path, no_optimize=no_optimize)
            print(f"Generated {dest_path.name} for {name}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-f", "--force", action="store_true", help="Force re-rendering")
    ap.add_argument("-v", "--verbose", action="store_true", help="Verbose output")
    ap.add_argument("--no-optimize", action="store_true", help="Don't optimize output, even if tools exist")
    ap.add_argument("--scaling-test-mode", action="store_true", help="Generate images for scaling tests")
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
