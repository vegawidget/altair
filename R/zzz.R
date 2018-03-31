#' Reticulate helpers
#'
#'
#' @name reticulate
#' @aliases               r_to_py
#' @importFrom reticulate r_to_py
#' @export                r_to_py
#'
#' @seealso [reticulate::r_to_py()]
#'
NULL


# reference: https://rstudio.github.io/reticulate/articles/package.html

#' Altair object
#'
#' Uses the reticulate framework to access the Altair API
#'
#' @export altair
#'
altair <- NULL

.onLoad <- function(libname, pkgname) {
  altair <<- reticulate::import("altair", delay_load = TRUE)
}
