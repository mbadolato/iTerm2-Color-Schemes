import hashlib
import plistlib
import unittest
from pathlib import Path

from gen import Color, read_itermcolors_file

REPO_ROOT = Path(__file__).parent.parent
PALETTES = {
    "Gruber Darker": (
        "181818 f43841 73c936 ffdd33 96a6c8 9e95c7 95a99f e4e4ef "
        "52494e ff4f58 73c936 ffdd33 96a6c8 afafd7 95a99f f5f5f5"
    ).split(),
    "Gruber Darker Legacy": (
        "181818 ff0a36 42dc00 ffdb00 92a7cb a095cb 90aa9e e4e4e4 "
        "54494e ff3851 42dc00 ffdb00 92a7cb afafda 90aa9e f5f5f5"
    ).split(),
}


class GruberDarkerTests(unittest.TestCase):
    def source_path(self, name: str) -> Path:
        return REPO_ROOT / "schemes" / f"{name}.itermcolors"

    def test_legacy_source_is_preserved_exactly(self) -> None:
        source = self.source_path("Gruber Darker Legacy").read_bytes()
        self.assertEqual(
            hashlib.sha256(source).hexdigest(),
            "04d1e8eda0ad1775ced0ca772be6d48e385510003f0d0d0474bcf99971b01e09",
        )

    def test_corrected_default_and_dark_source_colors(self) -> None:
        source = plistlib.loads(self.source_path("Gruber Darker").read_bytes())
        expected = {
            **{f"Ansi {i} Color": color for i, color in enumerate(PALETTES["Gruber Darker"])},
            "Background Color": "181818",
            "Foreground Color": "e4e4ef",
            "Bold Color": "f5f5f5",
            "Cursor Color": "ffdd33",
            "Cursor Text Color": "ffffff",
            "Selection Color": "ffffff",
            "Selected Text Color": "52494e",
        }
        for suffix in ("", " (Dark)"):
            for key, color in expected.items():
                with self.subTest(key=key + suffix):
                    entry = source[key + suffix]
                    self.assertEqual(entry.get("Color Space", "sRGB"), "sRGB")
                    self.assertEqual(Color.from_iterm_color_dict(entry).hex, color)

    def test_light_overrides_are_unchanged(self) -> None:
        corrected = plistlib.loads(self.source_path("Gruber Darker").read_bytes())
        legacy = plistlib.loads(self.source_path("Gruber Darker Legacy").read_bytes())
        self.assertEqual(
            {key: value for key, value in corrected.items() if key.endswith(" (Light)")},
            {key: value for key, value in legacy.items() if key.endswith(" (Light)")},
        )

    def test_generator_palettes(self) -> None:
        for name, palette in PALETTES.items():
            with self.subTest(name=name):
                theme = read_itermcolors_file(self.source_path(name))
                self.assertEqual(
                    [theme.colors[f"Ansi {i} Color"].hex for i in range(16)],
                    palette,
                )
                self.assertEqual(theme.colors["Foreground Color"].hex, palette[7])
                self.assertEqual(theme.colors["Background Color"].hex, "181818")
                self.assertEqual(theme.colors["Cursor Color"].hex, palette[3])

    def test_ghostty_exports(self) -> None:
        for name, palette in PALETTES.items():
            with self.subTest(name=name):
                lines = (REPO_ROOT / "ghostty" / name).read_text().splitlines()
                actual = [line for line in lines if line.startswith("palette = ")]
                self.assertEqual(
                    actual,
                    [f"palette = {i}=#{color}" for i, color in enumerate(palette)],
                )
                self.assertIn(f"foreground = #{palette[7]}", lines)
                self.assertIn(f"cursor-color = #{palette[3]}", lines)


if __name__ == "__main__":
    unittest.main()
