#!/usr/bin/env python

import tomllib
import shutil
import os
import subprocess

LIB_DIR = "lib"
TEMPLATES_DIR = "templates"
OUTPUT_DIR = "generated"


def get_git_commit():
    """Return the full SHA of the currently checked out commit."""
    return (
        subprocess.check_output(["git", "rev-parse", "HEAD"]).decode("utf-8").strip()
    )


def pin_readme_links(package_dir, repository, commit):
    """Rewrite README links from the default branch to a commit permalink.

    The source READMEs link to `.../tree/main/...` so they stay browsable on
    GitHub, but the published package must point at an immutable revision so the
    linked resources always match this exact version (see the Typst package
    checker warning about links to the default branch).
    """
    readme_path = f"{package_dir}/README.md"
    if not os.path.exists(readme_path):
        return

    with open(readme_path, "r", encoding="utf-8") as f:
        content = f.read()

    for kind in ("tree", "blob"):
        content = content.replace(
            f"{repository}/{kind}/main/",
            f"{repository}/{kind}/{commit}/",
        )

    with open(readme_path, "w", encoding="utf-8") as f:
        f.write(content)


def read_toml(path):
    with open(path, "rb") as f:
        config = tomllib.load(f)

    return config


def write_toml(data, path):
    def format_value(value):
        """Format the value for TOML representation."""
        if isinstance(value, str):
            return f'"{value}"'  # Use double quotes for strings
        elif isinstance(value, bool):
            return "true" if value else "false"
        else:
            return str(value)  # Convert numbers and other types to string

    with open(path, "w") as f:
        first_row = True
        for key, value in data.items():
            if isinstance(value, dict):
                f.write(f"{'' if first_row else '\n'}[{key}]\n")  # Write section header
                for sub_key, sub_value in value.items():
                    f.write(f"{sub_key} = {format_value(sub_value)}\n")
            else:
                f.write(f"{key} = {format_value(value)}\n")
            first_row = False


def make_package(src: str, dst: str, commit: str):
    base_config = read_toml("typst.toml")
    version = base_config["package"]["version"]
    repository = base_config["package"]["repository"]

    package_config = read_toml(f"./{src}/typst.toml")
    name = package_config["package"]["name"]

    package_dir = f"{dst}/{name}/{version}"

    # Copy files to output folder
    shutil.copytree(src=src, dst=package_dir)

    # Merge base_config with package_config
    merged_config = package_config
    for item in base_config:
        merged_config[item].update(base_config[item])
    write_toml(merged_config, f"./{package_dir}/typst.toml")

    # Copy license
    shutil.copy("LICENSE", f"./{package_dir}/LICENSE")

    # Pin default-branch links to the current commit so they always match this version
    pin_readme_links(package_dir, repository, commit)


# Delete old generated releases
if os.path.exists(f"./{OUTPUT_DIR}"):
    shutil.rmtree(f"./{OUTPUT_DIR}")
os.mkdir(OUTPUT_DIR)

# Resolve the commit to pin README links to
commit = get_git_commit()

# Generate main lib
make_package(LIB_DIR, OUTPUT_DIR, commit)

# Generate templates
dirs = os.listdir(TEMPLATES_DIR)
for dir in dirs:
    make_package(f"{TEMPLATES_DIR}/{dir}", OUTPUT_DIR, commit)
