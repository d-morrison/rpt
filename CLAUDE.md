# Claude instructions for rpt

## General principles

- **Do not remove features as workarounds.** If a link, button, or behavior is broken, fix the root cause. Only remove/disable a feature if explicitly instructed to do so.

## Repository structure

- `altdoc/` — Quarto website project (config: `altdoc/quarto_website.yml`)
- `man/` — Roxygen2-generated `.Rd` files (source of truth for function docs)
- `altdoc/man/` — `.qmd` files generated at build time by altdoc from `man/*.Rd`; **not committed to git**
- `vignettes/` — Quarto vignette `.qmd` files (committed to git)
- `.github/workflows/docs.yaml` — CI workflow for building and deploying docs

## Documentation build notes

- `altdoc::render_docs()` generates `.qmd` files into `altdoc/man/` at build time, then invokes Quarto to render the project.
- `altdoc/scripts/fix-man-source-urls.sh` is a Quarto pre-render script that injects `source-url` metadata into generated man page `.qmd` files, pointing "View source" at the committed `.Rd` file.
- On PR-preview builds, `.github/workflows/docs.yaml` rewrites `repo-url`, `repo-branch`, and the navbar GitHub icon href in `altdoc/quarto_website.yml` before the build.
