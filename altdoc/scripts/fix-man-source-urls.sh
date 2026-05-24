#!/usr/bin/env bash
# Quarto pre-render script: inject correct source-url into altdoc-generated
# man page .qmd files before Quarto renders them.
#
# Man pages are generated at build time from man/*.Rd; the generated .qmd
# files are never committed to git, so Quarto's default "View source" URL
# (based on the .qmd path) would 404.  We redirect "View source" to the
# committed .Rd file instead.
#
# This script runs from the Quarto project root (altdoc/), after altdoc has
# generated the .qmd files and before Quarto renders them.
set -euo pipefail

# Read repo settings from the project YAML.  On PR-preview builds these are
# already rewritten by .github/workflows/docs.yaml before altdoc is invoked.
REPO_URL=$(yq '.website."repo-url"' quarto_website.yml)
REPO_BRANCH=$(yq '.website."repo-branch" // "main"' quarto_website.yml)

export MAN_REPO_URL="$REPO_URL"
export MAN_REPO_BRANCH="$REPO_BRANCH"

python3 - <<'PYEOF'
import pathlib, os

repo_url = os.environ["MAN_REPO_URL"]
repo_branch = os.environ["MAN_REPO_BRANCH"]

for qmd in pathlib.Path("man").glob("*.qmd"):
    stem = qmd.stem
    source_url = f"{repo_url}/blob/{repo_branch}/man/{stem}.Rd"
    content = qmd.read_text()
    # Only inject if not already present and file starts with YAML front matter
    if "source-url:" not in content and content.startswith("---\n"):
        # Insert source-url as the first key after the opening ---
        content = "---\nsource-url: " + source_url + "\n" + content[4:]
        qmd.write_text(content)
PYEOF
