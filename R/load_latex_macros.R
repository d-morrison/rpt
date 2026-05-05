# Internal helper for loading LaTeX macros into vignettes/articles
#
# Reads a LaTeX macros file, strips HTML comments (which break pandoc's
# display-math parser), and emits a $$...$$ block for MathJax to process.
# Intended for use in knitr chunks with results='asis'.
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
  lines <- readLines(path)
  lines <- gsub("<!--.*?-->", "", lines, perl = TRUE)
  lines <- lines[nzchar(trimws(lines))]
  cat("$$\n", paste(lines, collapse = "\n"), "\n$$\n", sep = "")
}
