import pathlib

def generate_screenshots_readme():
    screenshots_path = pathlib.Path(__file__).parent.parent / "screenshots"
    assert screenshots_path.is_dir()

    with (screenshots_path / "README.md").open("w", encoding="utf-8") as outf:
        outf.write("# Screenshots\n\n")
        screenshots = sorted(screenshots_path.glob("*.png"), key=lambda p: p.name.lower())
        outf.write("\n\n".join(f"`{f.name}`\n\n![image]({f.name})" for f in screenshots))
        outf.write("\n")
        print(outf.name, "written")


if __name__ == "__main__":
    generate_screenshots_readme()
