"""
Generate a monochrome font image for the screenshot tool.

This should not be run as part of the normal build process,
but only when the font image needs to be updated.
"""

from screenshot_gen.helpers import font_charset, screenshot_font_path
from PIL import ImageFont, Image


def draw_char(font, ch, target_size):
    features = ["-kern", "-liga", "-clig"]
    mask, offs = font.getmask2(ch, "L", features=features)
    tot_height = offs[1] + mask.size[1]
    assert offs[0] == 0, "X-offset not supported right now"
    tot_width = mask.size[0]
    if tot_height > target_size[1]:
        raise ValueError(f"Char '{ch}' is too high, need {tot_height}")
    if tot_width > target_size[0]:
        raise ValueError(f"Char '{ch}' is too wide, need {tot_width}")
    mask_img = Image.new("1", mask.size, 0)
    mask_img.putdata(mask)
    img = Image.new("1", target_size, 0)
    img.paste(mask_img, offs)
    return img


def main():
    # The original screenshots prescribe Monaco at 13 points,
    # but we'll use a larger monochrome font here and scale it down
    # for better fidelity.
    font = ImageFont.truetype("/System/Library/Fonts/Monaco.ttf", 13 * 4)
    width, height = target_size = (32, 64)
    images = [draw_char(font, ch, target_size=target_size) for ch in font_charset]
    full_img = Image.new("L", (len(images) * width, height), 0)
    for i, img in enumerate(images):
        full_img.paste(img, (i * width, 0))
    full_img.save(screenshot_font_path)
    print(f"Font image saved to {screenshot_font_path}")


if __name__ == "__main__":
    main()
