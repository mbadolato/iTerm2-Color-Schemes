#!/usr/bin/env python3

import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
TOOLS_PATH = REPO_ROOT / "tools"
CHECK_LICENSES = TOOLS_PATH / "check_licenses.py"
GEN = TOOLS_PATH / "gen.py"

if str(TOOLS_PATH) not in sys.path:
    sys.path.insert(0, str(TOOLS_PATH))

from check_licenses import is_allowed, is_redistributable  # noqa: E402

VALID_LICENSES = """\
Alpha:
  license: MIT
  source: https://example.com/alpha
Beta Two:
  license: unknown
  source: ''
  note: No licence found.
"""


def run(*args: str, cwd: Path = REPO_ROOT) -> subprocess.CompletedProcess[str]:
    return subprocess.run([sys.executable, *args], cwd=cwd, capture_output=True, text=True)


class CheckLicensesCliTests(unittest.TestCase):
    def setUp(self) -> None:
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        root = Path(self.tmp.name)
        self.schemes_dir = root / "schemes"
        self.yaml_dir = root / "yaml"
        self.licenses = root / "licenses.yml"
        self.schemes_dir.mkdir()
        self.yaml_dir.mkdir()
        (self.schemes_dir / "Alpha.itermcolors").write_text("", encoding="utf-8")
        # the display name of a YAML scheme comes from `name:` when it is set
        (self.yaml_dir / "Beta_Two.yml").write_text('name: "Beta Two"\n', encoding="utf-8")

    def check(self, licenses: str) -> subprocess.CompletedProcess[str]:
        self.licenses.write_text(licenses, encoding="utf-8")
        return run(
            str(CHECK_LICENSES),
            "--licenses",
            str(self.licenses),
            "--schemes-dir",
            str(self.schemes_dir),
            "--yaml-dir",
            str(self.yaml_dir),
        )

    def test_repository_licenses_file_is_valid(self) -> None:
        result = run(str(CHECK_LICENSES))
        self.assertEqual(result.returncode, 0, msg=result.stderr)
        self.assertIn("SPDX", result.stdout)

    def test_valid_file_passes(self) -> None:
        result = self.check(VALID_LICENSES)
        self.assertEqual(result.returncode, 0, msg=result.stderr)
        self.assertIn("2 schemes: 1 SPDX, 1 unknown, 0 nonfree", result.stdout)

    def test_missing_entry_fails(self) -> None:
        (self.schemes_dir / "Gamma.itermcolors").write_text("", encoding="utf-8")
        result = self.check(VALID_LICENSES)
        self.assertEqual(result.returncode, 1)
        self.assertIn("Gamma: no entry in licenses.yml", result.stderr)

    def test_entry_without_scheme_fails(self) -> None:
        result = self.check(VALID_LICENSES + "Removed:\n  license: MIT\n  source: ''\n")
        self.assertEqual(result.returncode, 1)
        self.assertIn("Removed: entry in licenses.yml but no such scheme", result.stderr)

    def test_invalid_license_fails(self) -> None:
        result = self.check(VALID_LICENSES.replace("license: MIT", "license: GPL"))
        self.assertEqual(result.returncode, 1)
        self.assertIn("Alpha: license 'GPL'", result.stderr)

    def test_invalid_source_and_extra_key_fail(self) -> None:
        result = self.check(VALID_LICENSES.replace("https://example.com/alpha", "example.com") + "  author: someone\n")
        self.assertEqual(result.returncode, 1)
        self.assertIn("Alpha: source must be a URL", result.stderr)
        self.assertIn("Beta Two: unexpected key 'author'", result.stderr)


class LicenseExpressionTests(unittest.TestCase):
    def test_expressions_of_listed_identifiers_are_allowed(self) -> None:
        self.assertTrue(is_allowed("MIT OR Apache-2.0"))
        self.assertTrue(is_allowed("MIT AND CC0-1.0"))
        self.assertTrue(is_redistributable({"license": "MIT OR Apache-2.0", "source": ""}))

    def test_expressions_with_an_unlisted_part_are_refused(self) -> None:
        self.assertFalse(is_allowed("MIT OR Made-Up-1.0"))
        self.assertFalse(is_allowed("MIT OR"))
        self.assertFalse(is_allowed("unknown OR MIT"))
        self.assertFalse(is_redistributable({"license": "unknown", "source": ""}))


class RedistributableTests(unittest.TestCase):
    def test_is_redistributable(self) -> None:
        self.assertTrue(is_redistributable({"license": "MIT", "source": ""}))
        self.assertFalse(is_redistributable({"license": "unknown", "source": ""}))
        self.assertFalse(is_redistributable({"license": "nonfree", "source": ""}))
        self.assertFalse(is_redistributable(None))

    def test_gen_redistributable_skips_unknown_and_nonfree(self) -> None:
        with tempfile.TemporaryDirectory() as out_dir:
            result = run(
                str(GEN),
                "-s",
                "Zacess Dark",
                "Monokai Pro",
                "-t",
                "kitty",
                "--redistributable",
                "-o",
                out_dir,
                cwd=TOOLS_PATH,
            )
            self.assertEqual(result.returncode, 0, msg=result.stderr)
            generated = sorted(path.name for path in (Path(out_dir) / "kitty").iterdir())
            self.assertEqual(generated, ["Zacess Dark.conf"])


if __name__ == "__main__":
    unittest.main()
