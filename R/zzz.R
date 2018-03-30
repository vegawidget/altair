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
