from __future__ import annotations
from PIL import Image, ImageDraw

from screenshot_gen.helpers import font_charset


class PixFont:
    def __init__(self, font_img, charset):
        self.charset = charset
        char_width, remainder = divmod(font_img.width, len(font_charset))
        assert not remainder, f"Font image width {font_img.width} is not divisible by {len(font_charset)}"
        self.char_width = char_width
        self.char_height = font_img.height
        self.char_images = {}
        for i, c in enumerate(font_charset):
            self.char_images[c] = font_img.crop((i * char_width, 0, (i + 1) * char_width, self.char_height))

    def draw(self, img, coords, text, color):
        cx, cy = coords
        for i, c in enumerate(text):
            if c.isspace():
                continue
            img.paste(color, (cx + i * self.char_width, cy), mask=self.char_images[c])


class ConsoleScreenshotRenderer:
    bg_stripe_width = 7
    bg_stripe_start_x = 9

    def __init__(self, pix_font: PixFont, scheme):
        self.pix_font = pix_font
        self.scheme = scheme

        self.img = Image.new("RGB", self._xc(80, 19))
        self.draw = ImageDraw.Draw(self.img)
        self.rgb_colors = {
            name: (col["r"], col["g"], col["b"]) for name, col in scheme.items() if name.endswith("Color")
        }

    def _xc(self, cx, cy):
        # short for "xlate coords", i.e. translate character coords to pixel coords
        return cx * self.pix_font.char_width, cy * self.pix_font.char_height

    def _fill_rect(self, x0, y0, x1, y1, fill):
        self.draw.rectangle([self._xc(x0, y0), self._xc(x1, y1)], fill=fill)

    def _draw_bg_stripes(self):
        stripe_width_with_margin = self.bg_stripe_width + 1
        for i in range(9):
            color = i - 1
            self.pix_font.draw(
                self.img,
                self._xc(self.bg_stripe_start_x + i * stripe_width_with_margin, 0),
                (f"{40 + color}m" if i > 0 else "def").center(self.bg_stripe_width),
                color=self.rgb_colors["Foreground_Color"],
            )
            if color < 0:
                continue
            self._fill_rect(
                self.bg_stripe_start_x + i * stripe_width_with_margin,
                1,
                self.bg_stripe_start_x + self.bg_stripe_width + i * stripe_width_with_margin,
                19,
                fill=self.rgb_colors[f"Ansi_{color}_Color"],
            )

    def _draw_texts(self):
        for i in range(9):
            color = i - 1
            for bright_bit in (0, 1):
                y = 1 + i * 2 + bright_bit
                self._draw_color_desc(y, bright_bit, color)
                for bg_color in range(9):
                    x = self.bg_stripe_start_x + bg_color * (self.bg_stripe_width + 1)
                    if color < 0:
                        pil_color = self.rgb_colors["Bold_Color"] if bright_bit else self.rgb_colors["Foreground_Color"]
                    else:
                        ansi_color_index = color + 8 * bright_bit
                        pil_color = self.rgb_colors[f"Ansi_{ansi_color_index}_Color"]
                    self.pix_font.draw(
                        self.img,
                        self._xc(x, y),
                        "qYw".center(self.bg_stripe_width),
                        color=pil_color,
                    )

    def _draw_color_desc(self, y, bright_bit, color):
        desc = "m"
        if color >= 0:
            desc = f"{30 + color}{desc}"
        if bright_bit:
            desc = f"1;{desc}"
        self.pix_font.draw(
            self.img,
            self._xc(1, y),
            desc.rjust(6),
            color=self.rgb_colors["Foreground_Color"],
        )

    def _draw_cursor_color(self):
        self._fill_rect(0, 0, 3, 1, fill=self.rgb_colors["Cursor_Color"])
        cursor_text_color = self.rgb_colors.get("Cursor_Text_Color") or self.rgb_colors["Background_Color"]
        self.pix_font.draw(self.img, self._xc(0, 0), "Cur", color=cursor_text_color)

    def _draw_selection_color(self):
        self._fill_rect(4, 0, 7, 1, fill=self.rgb_colors["Selection_Color"])
        selection_text_color = self.rgb_colors.get("Selected_Text_Color") or self.rgb_colors["Foreground_Color"]
        self.pix_font.draw(self.img, self._xc(4, 0), "Sel", color=selection_text_color)

    def render(self):
        self.img.paste(
            self.rgb_colors["Background_Color"],
            (0, 0, self.img.width, self.img.height),
        )
        self._draw_bg_stripes()
        self._draw_texts()
        if "Cursor_Color" in self.rgb_colors:
            self._draw_cursor_color()
        if "Selection_Color" in self.rgb_colors:
            self._draw_selection_color()
        return self.img
