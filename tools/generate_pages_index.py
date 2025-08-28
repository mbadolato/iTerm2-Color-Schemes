#!/usr/bin/env python

import jinja2
from pathlib import Path
from screenshot_gen.helpers import (
    get_screenshot_filename,
)

# Set up paths relative to the script's location
script_dir = Path(__file__).parent
gh_pages_dir = script_dir.parent / 'gh-pages'
schemes_dir = script_dir.parent / 'schemes'

# Set up Jinja2 environment to load template from gh-pages directory
env = jinja2.Environment(loader=jinja2.FileSystemLoader(gh_pages_dir))

# Load the template from gh-pages
template = env.get_template('index.j2')

# Get list of scheme files
schemes = []
for filename in schemes_dir.iterdir():
    if filename.suffix == '.itermcolors':
        name = filename.stem
        screenshot_name = get_screenshot_filename(name)
        schemes.append({
            'name': name,
            'url': f'https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/{filename.name}',
            'screenshot': f'https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/screenshots/{screenshot_name}.png'
        })

# Sort schemes alphabetically by name
schemes.sort(key=lambda x: x['name'])

# Render the template
output = template.render(schemes=schemes)

# Write to index.html in gh-pages directory
with open(gh_pages_dir / 'index.html', 'w') as f:
    f.write(output)
