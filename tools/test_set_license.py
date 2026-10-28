#!/usr/bin/env python3

import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
TOOLS_PATH = REPO_ROOT / "tools"
SET_LICENSE = TOOLS_PATH / "set_license.py"
LICENSES = REPO_ROOT / "licenses.yml"

if str(TOOLS_PATH) not in sys.path:
    sys.path.insert(0, str(TOOLS_PATH))

from set_license import join_entries, split_entries  # noqa: E402

HEADER = "# Licence of every colour scheme.\n\n"
ENTRIES = """\
Alpha:
  license: MIT
  source: https://example.com/alpha
beta:
  license: unknown
  source: ''
  note: No licence found.
Gamma:
  license: CC0-1.0
  source: ''
"""


def run(*args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run([sys.executable, str(SET_LICENSE), *args], capture_output=True, text=True)


class SetLicenseTests(unittest.TestCase):
    def setUp(self) -> None:
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.licenses = Path(self.tmp.name) / "licenses.yml"
        self.licenses.write_text(HEADER + ENTRIES, encoding="utf-8")

    def set_license(self, *args: str) -> subprocess.CompletedProcess[str]:
        return run("--licenses", str(self.licenses), *args)

    def text(self) -> str:
        return self.licenses.read_text(encoding="utf-8")

    def test_repository_file_round_trips_unchanged(self) -> None:
        text = LICENSES.read_text(encoding="utf-8")
        self.assertEqual(join_entries(*split_entries(text)), text)

    def test_set_adds_in_alphabetical_order(self) -> None:
        result = self.set_license("set", "Bee & Moss: Night", "--license", "MIT", "--source", "https://example.com/bee")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            self.text(),
            HEADER
            + ENTRIES.replace(
                "beta:",
                "'Bee & Moss: Night':\n  license: MIT\n  source: https://example.com/bee\nbeta:",
            ),
        )

    def test_set_replaces_an_existing_entry(self) -> None:
        result = self.set_license("set", "beta", "--license", "MIT", "--source", "https://example.com/beta")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("beta:\n  license: MIT\n  source: https://example.com/beta\nGamma:", self.text())
        self.assertNotIn("No licence found.", self.text())

    def test_rename_keeps_the_entry(self) -> None:
        result = self.set_license("rename", "Alpha", "Zeta")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(self.text().endswith("Zeta:\n  license: MIT\n  source: https://example.com/alpha\n"))
        self.assertNotIn("Alpha:", self.text())

    def test_remove_deletes_the_entry(self) -> None:
        result = self.set_license("remove", "Gamma")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertNotIn("Gamma", self.text())

    def test_invalid_input_leaves_the_file_untouched(self) -> None:
        for args in (
            ("set", "Delta", "--license", "Made-Up-1.0"),
            ("set", "Delta", "--license", "MIT", "--source", "example.com"),
            ("rename", "Missing", "Delta"),
            ("rename", "Alpha", "Gamma"),
            ("remove", "Missing"),
        ):
            with self.subTest(args=args):
                result = self.set_license(*args)
                self.assertEqual(result.returncode, 1)
                self.assertEqual(self.text(), HEADER + ENTRIES)


if __name__ == "__main__":
    unittest.main()
