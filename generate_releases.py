#!/usr/bin/env python

import tomllib
import shutil
import os
import sys
import re

LIB_DIR = "lib"
TEMPLATES_DIR = "templates"
OUTPUT_DIR = "generated"


def read_toml(path):
    """Read and parse a TOML file."""
    try:
        with open(path, "rb") as f:
            config = tomllib.load(f)
        return config
    except FileNotFoundError:
        print(f"Error: TOML file not found: {path}", file=sys.stderr)
        sys.exit(1)
    except tomllib.TOMLDecodeError as e:
        print(f"Error: Invalid TOML in {path}: {e}", file=sys.stderr)
        sys.exit(1)


def write_toml(data, path):
    """Write data to a TOML file with proper escaping."""
    def escape_string(s):
        """Escape special characters in strings for TOML."""
        # Escape backslash first, then other special characters
        s = s.replace("\\", "\\\\")
        s = s.replace('"', '\\"')
        s = s.replace("\n", "\\n")
        s = s.replace("\r", "\\r")
        s = s.replace("\t", "\\t")
        return s

    def format_value(value):
        """Format the value for TOML representation."""
        if isinstance(value, str):
            return f'"{escape_string(value)}"'
        elif isinstance(value, bool):
            return "true" if value else "false"
        elif isinstance(value, (list, tuple)):
            # Handle arrays
            formatted_items = [format_value(item) for item in value]
            return "[" + ", ".join(formatted_items) + "]"
        elif isinstance(value, dict):
            # Nested dicts not handled inline, should use sections
            raise ValueError("Nested dictionaries should be written as TOML sections")
        else:
            return str(value)  # Convert numbers and other types to string

    try:
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
    except IOError as e:
        print(f"Error: Failed to write TOML file {path}: {e}", file=sys.stderr)
        sys.exit(1)


def validate_package_name(name):
    """Validate that package name is safe and doesn't contain path traversal."""
    # Only allow alphanumeric characters, hyphens, and underscores
    if not re.match(r'^[a-zA-Z0-9_-]+$', name):
        print(f"Error: Invalid package name '{name}'. Only alphanumeric characters, hyphens, and underscores are allowed.", file=sys.stderr)
        sys.exit(1)
    
    # Explicitly check for path traversal attempts
    if ".." in name or "/" in name or "\\" in name:
        print(f"Error: Package name '{name}' contains invalid path characters.", file=sys.stderr)
        sys.exit(1)
    
    return True


def make_package(src: str, dst: str):
    """Generate a package from source template."""
    try:
        base_config = read_toml("typst.toml")
        version = base_config["package"]["version"]

        package_config = read_toml(f"./{src}/typst.toml")
        name = package_config["package"]["name"]
        
        # Validate package name for security
        validate_package_name(name)

        # Copy files to output folder
        output_path = f"{dst}/{name}/{version}"
        try:
            shutil.copytree(src=src, dst=output_path)
        except FileExistsError:
            print(f"Warning: Output directory {output_path} already exists. Skipping.", file=sys.stderr)
            return
        except IOError as e:
            print(f"Error: Failed to copy directory {src} to {output_path}: {e}", file=sys.stderr)
            sys.exit(1)

        # Merge base_config with package_config
        merged_config = package_config.copy()
        for item in base_config:
            if item in merged_config:
                merged_config[item].update(base_config[item])
            else:
                merged_config[item] = base_config[item]
        write_toml(merged_config, f"./{dst}/{name}/{version}/typst.toml")

        # Copy license
        try:
            shutil.copy("LICENSE", f"./{dst}/{name}/{version}/LICENSE")
        except IOError as e:
            print(f"Error: Failed to copy LICENSE: {e}", file=sys.stderr)
            sys.exit(1)
            
        print(f"Successfully generated package: {name} v{version}")
        
    except Exception as e:
        print(f"Error: Failed to make package from {src}: {e}", file=sys.stderr)
        sys.exit(1)


# Delete old generated releases
if os.path.exists(f"./{OUTPUT_DIR}"):
    try:
        shutil.rmtree(f"./{OUTPUT_DIR}")
    except IOError as e:
        print(f"Error: Failed to remove old {OUTPUT_DIR} directory: {e}", file=sys.stderr)
        sys.exit(1)

try:
    os.mkdir(OUTPUT_DIR)
except IOError as e:
    print(f"Error: Failed to create {OUTPUT_DIR} directory: {e}", file=sys.stderr)
    sys.exit(1)

# Generate main lib
make_package(LIB_DIR, OUTPUT_DIR)

# Generate templates
try:
    entries = os.listdir(TEMPLATES_DIR)
    # Filter to only process directories
    dirs = [d for d in entries if os.path.isdir(os.path.join(TEMPLATES_DIR, d))]
    for dir_name in dirs:
        make_package(f"{TEMPLATES_DIR}/{dir_name}", OUTPUT_DIR)
except FileNotFoundError:
    print(f"Error: Templates directory {TEMPLATES_DIR} not found", file=sys.stderr)
    sys.exit(1)
except IOError as e:
    print(f"Error: Failed to list templates directory: {e}", file=sys.stderr)
    sys.exit(1)

print(f"\nAll packages generated successfully in {OUTPUT_DIR}/")

