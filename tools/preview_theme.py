#!/usr/bin/env python3
"""Entry point for python tools/preview_theme.py"""

import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).parent))

from preview_theme.cli import main

if __name__ == "__main__":
    raise SystemExit(main())