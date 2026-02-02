#' Clean Data
#'
#' Internal helper function to clean data by removing NA values and preparing
#' for analysis.
#'
#' @param x A numeric vector
#'
#' @return A cleaned numeric vector with NA values removed
#' @keywords internal
#' @noRd
clean_data <- function(x) {
  validate_input(x)
  x_clean <- x[!is.na(x)]
  if (length(x_clean) == 0) {
    stop("No valid data remaining after removing NA values", call. = FALSE)
  }
  x_clean
}
