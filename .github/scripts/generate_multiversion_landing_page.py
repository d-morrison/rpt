"""Generate the root multiversion landing-page redirect for GitHub Pages.

This mirrors the r-pkgdown-multiversion pattern: keep docs in versioned
subdirectories and use the root page as a redirect entrypoint.
"""

import os
import pathlib


def main():
    owner = os.environ["GITHUB_REPOSITORY_OWNER"]
    repo = os.environ["GITHUB_EVENT_REPOSITORY_NAME"]
    target = os.environ["LANDING_TARGET"].strip("/")

    output_dir = pathlib.Path("site-root")
    output_dir.mkdir(parents=True, exist_ok=True)

    url = f"https://{owner}.github.io/{repo}/{target}/"
    html = (
        "<!DOCTYPE html>\n"
        '<meta charset="utf-8">\n'
        f"<title>{repo}</title>\n"
        f'<meta http-equiv="refresh" content="0; URL={url}">\n'
        f'<link rel="canonical" href="{url}">\n'
    )

    (output_dir / "index.html").write_text(html, encoding="utf-8")
    (output_dir / ".nojekyll").write_text("", encoding="utf-8")

    print(f"Generated root redirect to: {url}")


if __name__ == "__main__":
    main()
