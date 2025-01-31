.PHONY: default

default:
	cd tools/ && python gen.py
	cd tools/ && python -m screenshot_gen
	cd tools/ && python generate_screenshots_readme.py
