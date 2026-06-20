#!/usr/bin/env python3

import subprocess
import sys
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
WCAG_CHECK = REPO_ROOT / "tools" / "wcag_check.py"


def run_wcag_check(*args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [sys.executable, str(WCAG_CHECK), *args],
        cwd=REPO_ROOT,
        capture_output=True,
        text=True,
    )


class WcagCheckCliTests(unittest.TestCase):
    def test_default_threshold_is_175(self) -> None:
        result = run_wcag_check("--help")
        self.assertEqual(result.returncode, 0)
        self.assertIn("default: 1.75", result.stdout)

    def test_single_existing_scheme(self) -> None:
        result = run_wcag_check("-s", "Molokai")
        self.assertEqual(result.returncode, 0, msg=result.stderr)
        self.assertIn("Molokai:", result.stdout)
        self.assertTrue("PASS" in result.stdout or "FAIL" in result.stdout)

    def test_missing_scheme_exits_nonzero(self) -> None:
        result = run_wcag_check("-s", "Definitely Not A Real Scheme Name 99999")
        self.assertEqual(result.returncode, 1)
        self.assertIn("not found", result.stderr)

    def test_yaml_stem_without_itermcolors_hints_gen_py(self) -> None:
        yaml_only = "SeedFlip_Amethyst"
        self.assertFalse((REPO_ROOT / "schemes" / f"{yaml_only}.itermcolors").exists())
        self.assertTrue((REPO_ROOT / "yaml" / f"{yaml_only}.yml").exists())

        result = run_wcag_check("-s", yaml_only)
        self.assertEqual(result.returncode, 1)
        self.assertIn("gen.py", result.stderr)
        self.assertIn(yaml_only, result.stderr)

    def test_bulk_mode_still_runs(self) -> None:
        result = run_wcag_check("--schemes-dir", "schemes")
        self.assertEqual(result.returncode, 0, msg=result.stderr)
        self.assertIn("Summary:", result.stdout)


if __name__ == "__main__":
    unittest.main()