import tomllib
import shutil
import os

LIB_DIR = "lib"
TEMPLATES_DIR = "templates"
OUTPUT_DIR = "generated"


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
                f.write(f"{"" if first_row else "\n"}[{key}]\n")  # Write section header
                for sub_key, sub_value in value.items():
                    f.write(f"{sub_key} = {format_value(sub_value)}\n")
            else:
                f.write(f"{key} = {format_value(value)}\n")
            first_row = False


def make_package(src: str, dst: str):
    base_config = read_toml("typst.toml")
    version = base_config["package"]["version"]

    package_config = read_toml(f"./{src}/typst.toml")
    name = package_config["package"]["name"]

    # Copy files to output folder
    shutil.copytree(src=src, dst=f"{dst}/{name}/{version}")

    # Merge base_config with package_config
    merged_config = package_config
    for item in base_config:
        merged_config[item].update(base_config[item])
    write_toml(merged_config, f"./{dst}/{name}/{version}/typst.toml")

    # Copy license
    shutil.copy("LICENSE", f"./{dst}/{name}/{version}/LICENSE")


# Delete old generated releases
if os.path.exists(f"./{OUTPUT_DIR}"):
    shutil.rmtree(f"./{OUTPUT_DIR}")
os.mkdir(OUTPUT_DIR)

# Generate main lib
make_package(LIB_DIR, OUTPUT_DIR)

# Generate templates
dirs = os.listdir(TEMPLATES_DIR)
for dir in dirs:
    make_package(f"{TEMPLATES_DIR}/{dir}", OUTPUT_DIR)
