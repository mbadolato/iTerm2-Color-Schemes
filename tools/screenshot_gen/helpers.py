import json
import re
import string
from pathlib import Path
from unidecode import unidecode

screenshot_gen_path = Path(__file__).parent
repo_path = screenshot_gen_path.parent.parent
screenshot_font_path = screenshot_gen_path / "screenshot_font.png"
schemes_jsonl_path = repo_path / "schemes.jsonl"
screenshots_path = repo_path / "screenshots"

font_charset = ";" + string.digits + string.ascii_letters


def read_schemes_jsonl():
    schemes = {}
    with schemes_jsonl_path.open("r", encoding="utf-8") as inf:
        for line in inf:
            data = json.loads(line)
            schemes[data["scheme_name"]] = data
    return schemes

def slugify(name):
    """Convert theme name to a slug (lowercase, replace spaces with hyphens)."""
    name = unidecode(name)
    name = name.lower()
    name = name.replace(' ', '-').replace('_', '-')
    name = re.sub(r'[^0-9a-z-]', '', name)
    return name

def get_screenshot_filename(name):
    return slugify(name)
