#!/usr/bin/env python

"""Bump the package version everywhere to the latest version in the CHANGELOG.

The single source of truth for the version is the topmost `## x.y.z` heading in
CHANGELOG.md. This script reads that version and writes it into:

- the root `typst.toml` (which `generate_releases.py` merges into every package)
- all `@preview/haw-hamburg...:<version>` imports in `.md` and `.typ` files

The CHANGELOG itself is never modified.
"""

import os
import re

CHANGELOG = "CHANGELOG.md"
OUTPUT_DIR = "generated"
SKIP_DIRS = {".git", OUTPUT_DIR, "__pycache__"}

# Matches e.g. `@preview/haw-hamburg:0.9.0` and `@preview/haw-hamburg-report:0.9.0`.
IMPORT_RE = re.compile(r"(@preview/haw-hamburg[\w-]*:)\d+\.\d+\.\d+[^\s\":]*")
# Matches the `version = "..."` line in a typst.toml.
TOML_VERSION_RE = re.compile(r'(?m)^(version\s*=\s*")[^"]*(")')
# Matches a changelog version heading such as `## 0.9.0`.
CHANGELOG_VERSION_RE = re.compile(r"^##\s+v?(\d+\.\d+\.\d+[^\s]*)\s*$")


def latest_changelog_version(path=CHANGELOG):
    """Return the version of the topmost entry in the CHANGELOG."""
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            match = CHANGELOG_VERSION_RE.match(line)
            if match:
                return match.group(1)
    raise RuntimeError(f"No `## <version>` heading found in {path}")


def replace_in_file(path, pattern, replacement):
    """Apply a regex substitution to a file, returning the number of changes."""
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    new_content, count = pattern.subn(replacement, content)
    if count:
        with open(path, "w", encoding="utf-8") as f:
            f.write(new_content)

    return count


def bump(version):
    """Write `version` into every place that references the package version."""
    for root, dirs, files in os.walk("."):
        # Don't descend into generated output or version control internals
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS]

        for name in files:
            path = os.path.join(root, name)

            if name == CHANGELOG:
                continue  # never touch the changelog itself
            elif name == "typst.toml":
                count = replace_in_file(path, TOML_VERSION_RE, rf"\g<1>{version}\g<2>")
            elif name.endswith((".md", ".typ")):
                count = replace_in_file(path, IMPORT_RE, rf"\g<1>{version}")
            else:
                continue

            if count:
                print(f"  updated {count}x  {path}")


version = latest_changelog_version()
print(f"Bumping version to {version} (from {CHANGELOG})")
bump(version)
print("Done. Run `python generate_releases.py` to regenerate the packages.")
