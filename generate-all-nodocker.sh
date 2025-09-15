#!/usr/bin/env bash

[[ ! -d ".venv" ]] && python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
cd tools
python gen.py
python iterm2terminal.py ../schemes ../terminal
python -m screenshot_gen
python generate_screenshots_readme.py
