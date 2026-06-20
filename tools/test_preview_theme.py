#!/usr/bin/env python3

import subprocess
import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
PREVIEW = REPO_ROOT / "tools" / "preview_theme.py"


def run_preview(*args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [sys.executable, str(PREVIEW), *args],
        cwd=REPO_ROOT,
        capture_output=True,
        text=True,
    )


class PreviewThemeTests(unittest.TestCase):
    def test_scheme_renders_hex_values(self) -> None:
        result = run_preview("-s", "Molokai", "--no-clear")
        self.assertEqual(result.returncode, 0, msg=result.stderr)
        self.assertIn("Molokai", result.stdout)
        self.assertIn("#", result.stdout)
        self.assertIn("Semantic samples", result.stdout)
        self.assertIn("Display-only preview", result.stdout)

    def test_no_osc_palette_sequences(self) -> None:
        result = run_preview("-s", "Molokai", "--no-clear")
        self.assertEqual(result.returncode, 0, msg=result.stderr)
        self.assertNotIn("\033]4;", result.stdout)
        self.assertNotIn("\033]10;", result.stdout)
        self.assertNotIn("\033]11;", result.stdout)

    def test_yaml_source(self) -> None:
        result = run_preview("yaml/Clear Dark.yml", "--no-clear")
        self.assertEqual(result.returncode, 0, msg=result.stderr)
        self.assertIn("Clear Dark", result.stdout)

    def test_missing_scheme_exits_nonzero(self) -> None:
        result = run_preview("-s", "No Such Theme 99999")
        self.assertEqual(result.returncode, 1)
        self.assertIn("not found", result.stderr)

    def test_static_mode_uses_truecolor(self) -> None:
        result = run_preview("-s", "Molokai", "--no-clear")
        self.assertIn("38;2;", result.stdout)
        self.assertIn("48;2;", result.stdout)


if __name__ == "__main__":
    unittest.main()