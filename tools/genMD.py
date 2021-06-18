from pathlib import Path

screenshot_dir = (Path(__file__).parent / '../screenshots').resolve()
screenshot_paths = list(screenshot_dir.glob('**/*.png'))
screenshots = map(lambda path: path.name, screenshot_paths)

readme_path = (screenshot_dir / 'README.md')
with open(readme_path, 'w') as readme:
    readme.write('# Screenshots\n\n')
    for ss in sorted(screenshots, key=str.lower):
        readme.write(f'`{ss}`\n\n')
        readme.write(f'![image]({ss})\n\n')
