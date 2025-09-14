#!/bin/sh

source ../.venv/bin/activate
pip install -r ../requirements.txt
python gen.py
python iterm2terminal.py ../schemes ../terminal
python -m screenshot_gen
python generate_screenshots_readme.py
