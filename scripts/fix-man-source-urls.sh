#!/usr/bin/env bash
# Quarto post-render script: fix "View source" links in man page HTML output.
#
# Man pages are generated at build time from man/*.Rd; the generated .qmd
# files are never committed to git, so Quarto's default "View source" URL
# (based on the .qmd path) would 404.  This script rewrites those URLs in
# the rendered HTML to point to the committed .Rd file instead.
#
# This script runs from the Quarto project root (altdoc/), after Quarto has
# rendered all pages into ../docs/.
set -euo pipefail

DOCS_MAN="../docs/man"

if [ ! -d "$DOCS_MAN" ]; then
    echo "fix-man-source-urls: no output at $DOCS_MAN, skipping"
    exit 0
fi

python3 - <<'PYEOF'
import pathlib, re

docs_man = pathlib.Path("../docs/man")
patched = 0
for html in sorted(docs_man.glob("*.html")):
    stem = html.stem
    content = html.read_text(encoding="utf-8")
    # Replace the href that Quarto generates for the "View source" button.
    # Quarto writes:  href="<repo-url>/blob/<branch>/man/<stem>.qmd"
    # We want:        href="<repo-url>/blob/<branch>/man/<stem>.Rd"
    new_content = re.sub(
        rf'(href="[^"]+/man/{re.escape(stem)})\.qmd(")',
        rf'\1.Rd\2',
        content,
    )
    if new_content != content:
        html.write_text(new_content, encoding="utf-8")
        patched += 1
        print(f"  fixed: {html.name}", flush=True)

print(f"fix-man-source-urls: patched {patched} file(s)")
PYEOF
