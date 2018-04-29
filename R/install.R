#' Install Altair Python package
#'
#' @param pip TRUE to use pip (defaults to TRUE)
#' @inheritParams reticulate::py_install
#' @inheritParams reticulate::conda_install
#'
#' @return invisible `NULL`, called for side-effects
#'
#' @examples
#' \dontrun{
#'   install_altair()
#' }
#' @export
#'
install_altair <- function(method = "auto", conda = "auto", pip = TRUE, ...) {
  reticulate::py_install(
    "altair==2.0.0rc2",
    method = method,
    conda = conda,
    pip = pip,
    ...
  )

  invisible(NULL)
}
