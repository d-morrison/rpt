#' Validate Input Data
#'
#' Internal helper function to validate input data for statistical calculations.
#'
#' @param x A numeric vector
#'
#' @return TRUE if valid, throws error otherwise
#' @keywords internal
#' @noRd
validate_input <- function(x) {
  if (!is.numeric(x)) {
    stop("Input must be numeric", call. = FALSE)
  }
  if (length(x) == 0) {
    stop("Input must have at least one element", call. = FALSE)
  }
  if (all(is.na(x))) {
    stop("Input cannot be all NA values", call. = FALSE)
  }
  TRUE
}
