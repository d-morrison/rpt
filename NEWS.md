# rpt (development version)

- Every CI workflow job now sets a `timeout-minutes` cap of at most 50, so a
  runaway or hung job can no longer tie up a runner indefinitely. The convention
  is documented in `.github/copilot-instructions.md` (#75).
- On PR-preview builds, the navbar GitHub icon now links to the PR conversation
  page, and "Edit this page" / "View source" resolve to the correct fork and
  branch. Man-page "View source" links now point at the committed `.Rd` source
  file rather than the build-time-generated `.qmd` file (#136).
- Docs deployment now uses versioned directories for stable/dev docs (`/latest-tag/`,
  `/dev/`, and release tags like `/v1.2.3/`), and publishes a root landing-page
  redirect in the same style as `r-pkgdown-multiversion`.
- The "Report an issue" documentation link now always points at the
  repository's main issues page, including on PR previews (where it previously
  followed the rewritten `repo-url`).

- Added a committed Claude Code configuration (`.claude/`) and a `CLAUDE.md`
  guidance file, so packages created from this template inherit slash commands,
  safe execution permissions, and a PR-review skill out of the box.
- Added a Dependabot configuration (`.github/dependabot.yml`) that keeps the
  `macros` git submodule and the pinned GitHub Actions in `.github/workflows/`
  up to date automatically: Dependabot opens a PR whenever the submodule
  advances or a newer action release is available, so packages created from
  this template inherit hands-off submodule and action bumps.
- Updated README to cover new template features:
  - Working examples for `example_function()` and `calculate_summary()`
  - Multi-format Quarto vignettes/articles (HTML, RevealJS slides, DOCX)
  - `slidebreak` shortcode for RevealJS, PowerPoint, and Beamer slide decks
  - Mathematical notation in roxygen2 (`\eqn{}`, `\deqn{}`)
  - Preinstalled Quarto extensions (`div-anchors`, `equation-anchors`, `callouty-theorem`)
  - LaTeX macro submodule at `vignettes/macros/`
  - Package structure visualization article using `foodwebr`

- Updated the docs workflow for altdoc multiversion deployment inspired by
  `etiennebacher/jarl`: pushes to `main` now deploy documentation to `/dev/`,
  while releases deploy stable documentation to `/`.

- Enhanced the docs site version dropdown to show version numbers: the current
  release is labeled with its tag (e.g., `v1.0.0 (stable)`), the development
  version is labeled with its `DESCRIPTION` version (e.g., `0.0.0.9017 (dev)`),
  and a "Previous versions" section lists all older release tags with links to
  their archived docs. Releases are now also deployed to a versioned subdirectory
  (e.g., `/v1.0.0/`) so prior docs remain accessible after new releases.

- Fixed LaTeX macros appearing as visible raw text on the documentation website (#111) by moving the `macros` git submodule to `vignettes/macros/`, which includes it in the package tarball and makes it available in both vignettes (R CMD check) and articles (altdoc) via a simple `{{< include macros/macros.qmd >}}` shortcode; Quarto/pandoc expands the macro definitions at compile time

* Extended `slidebreak` shortcode to support all slide deck formats (RevealJS, PowerPoint, Beamer) by checking for `revealjs`, `pptx`, and `beamer` formats explicitly (#103)
* Added demonstration of mathematical notation in roxygen2 comments using cross-format compatible syntax (`\eqn{}`, `\deqn{}`)
* Installed Quarto extensions for enhanced documentation: `d-morrison/div-anchors` (permalink anchors for theorem/proof divs), `d-morrison/equation-anchors` (permalink anchors for equations), and `sun123zxy/callouty-theorem` (render theorems as callout blocks). Added callouty-theorem YAML settings based on `d-morrison/rme`.
* Added package structure visualization article using foodwebr to demonstrate function dependencies and call graphs
* Created layered helper function architecture for realistic foodwebr demonstrations
* Added `calculate_summary()` function for computing summary statistics

* Switched from pkgdown to altdoc for documentation generation. Now using Quarto Website for documentation with native math equation support via MathJax.
* Removed pkgdown-specific configurations and workflows.
* Retained RevealJS multi-format support for Quarto vignettes and articles.
* Fixed index page rendering by switching from `index.md` to `index.qmd` to properly process Quarto include directive (#58)
* Switched from `pkgdown` to `altdoc` (#45)
* Updated lintr configuration to match serodynamics reference with enhanced linter rules
* PR preview comments now use `recreate: true` to ensure they always appear at the bottom of the PR conversation, preventing them from being hidden in collapsed sections (#31)

* Added RevealJS presentation format for Quarto vignettes and articles in pkgdown documentation. HTML pages now display an "Other Formats" section with links to slide versions (#29)

# rpt 0.0.0.9000

* Initial development version
