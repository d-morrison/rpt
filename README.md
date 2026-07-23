
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{rpt}` (<u>R</u> <u>p</u>ackage <u>t</u>emplate)

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/d-morrison/rpt/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/d-morrison/rpt/actions)
[![Codecov test
coverage](https://codecov.io/gh/d-morrison/rpt/branch/main/graph/badge.svg)](https://app.codecov.io/gh/d-morrison/rpt)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://cran.r-project.org/web/licenses/MIT)

<!-- badges: end -->

The goal of `{rpt}` is to provide a template for creating R packages
following [UCD-SERG](https://github.com/UCD-SERG) standards. It includes
example functions, documentation patterns, Quarto-based documentation
infrastructure, and GitHub Actions workflows to help you get started
quickly.

## Installation

You can install the development version of `{rpt}` from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("UCD-SERG/rpt")
```

## Example

The package ships with two exported functions as starting points.

`example_function()` computes the median of a numeric vector, removing
`NA` values automatically:

``` r
library(rpt)
example_function(c(1, 2, 3, 4, 5))
#> [1] 3
example_function(c(1, NA, 3, 4, 5))
#> [1] 3.5
```

`calculate_summary()` returns the mean, median, and standard deviation
as a named list:

``` r
calculate_summary(c(1, 2, 3, 4, 5))
#> $mean
#> [1] 3
#> 
#> $median
#> [1] 3
#> 
#> $sd
#> [1] 1.58
```

## Template Features

### Multi-Format Quarto Vignettes and Articles

Vignettes and articles in this template are written in Quarto (`.qmd`)
and can be rendered to multiple output formats from a single source
file:

- **HTML** — default format for the documentation website
- **RevealJS slides** — presentation version of every vignette/article
- **DOCX** — Word document version for sharing outside the web

### Slide Break Shortcode

A `slidebreak` shortcode is included and works across all slide deck
formats: RevealJS, PowerPoint (`.pptx`), and Beamer (LaTeX). Use it to
insert a new slide in any format:

``` markdown
{{</* slidebreak */>}}
```

### Mathematical Notation in roxygen2

Function documentation can include inline and display equations using
standard `roxygen2` macros that render correctly in both HTML and PDF
help pages:

- `\eqn{x_{0.5}}` for inline math
- `\deqn{m = x_{(n+1)/2}}` for display equations

See `?example_function` for a worked example.

### Quarto Extensions

The following Quarto extensions are preinstalled to enhance
documentation:

| Extension | Purpose |
|----|----|
| [`d-morrison/div-anchors`](https://github.com/d-morrison/div-anchors) | Permalink anchors for theorem/proof divs |
| [`d-morrison/equation-anchors`](https://github.com/d-morrison/equation-anchors) | Permalink anchors for numbered equations |
| [`sun123zxy/callouty-theorem`](https://github.com/sun123zxy/callouty-theorem) | Render theorems, definitions, and proofs as callout blocks |

### LaTeX Macro Submodule

A `macros` git submodule (located at `vignettes/macros/`) provides
shared LaTeX macro definitions. Include it in any vignette or article
with:

``` markdown
{{</* include macros/macros.qmd */>}}
```

Quarto/pandoc expands the macros at compile time, so MathJax on the
website receives only standard LaTeX.

### Package Structure Visualization

The [Package Function
Structure](https://ucd-serg.github.io/rpt/articles/package-structure.html)
article demonstrates how to use
[`foodwebr`](https://lewinfox.com/foodwebr/) to generate dependency
graphs for your package functions.

## Development

### Building the Documentation Site

This package uses [altdoc](https://altdoc.etiennebacher.com/) with
[Quarto](https://quarto.org/) to build its documentation site. To build
and preview the documentation locally:

``` r
# Load the package
pkgload::load_all()

# Render the documentation
altdoc::render_docs()

# Preview the site
altdoc::preview_docs()
```

The documentation is automatically built and deployed to GitHub Pages
via GitHub Actions when changes are pushed to the main branch.

## Other R Package Template Options

If you’re looking for alternative R package templates, you may also want
to consider:

- [r.pkg.template](https://github.com/insightsengineering/r.pkg.template/) -
  A comprehensive R package template from Insights Engineering

## Code of Conduct

Please note that the `{rpt}` project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
