# Internal helper for loading LaTeX macros into vignettes/articles
#
# Reads a LaTeX macros file, strips HTML comments, converts
# \providecommand to \def for MathJax v3 compatibility, and emits a
# hidden display-math block for MathJax to define the macros.
# Intended for use in knitr chunks with results='asis'.
#
# MathJax v3 does not support \providecommand. Each
# \providecommand{\name}[n]{body} is converted to the equivalent TeX
# primitive \def\name#1...#n{body}, which MathJax v3 handles correctly.
#
# @param path Character. Path to the macros .qmd file, relative to the
#   directory of the document being rendered.
# @noRd
load_latex_macros <- function(path) {
  if (!file.exists(path)) {
    warning(
      "Macros file not found: ", normalizePath(path, mustWork = FALSE), "\n",
      "Ensure the macros submodule is initialized: git submodule update --init",
      call. = FALSE
    )
    return(invisible(NULL))
  }
  lines <- readLines(path, warn = FALSE)
  lines <- lines[!grepl("^\\s*<!--", lines) & nzchar(trimws(lines))]

  # MathJax v3 does not support \providecommand; convert to \def
  lines <- vapply(lines, function(line) {
    m <- regmatches(
      line,
      regexec(
        "^\\\\providecommand\\{\\\\([^}]+)\\}(?:\\[(\\d+)\\])?\\{(.*)\\}\\s*$",
        line,
        perl = TRUE
      )
    )[[1]]
    if (length(m) == 4L && nzchar(m[1L])) {
      nargs    <- if (nzchar(m[3L])) as.integer(m[3L]) else 0L
      args_str <- if (nargs > 0L) paste0("#", seq_len(nargs), collapse = "") else ""
      return(paste0("\\def\\", m[2L], args_str, "{", m[4L], "}"))
    }
    line
  }, character(1L), USE.NAMES = FALSE)

  cat('::: {style="display:none"}\n$$\n')
  cat(paste(lines, collapse = "\n"), "\n")
  cat("$$\n:::\n")
}
