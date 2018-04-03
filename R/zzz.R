# reference: https://rstudio.github.io/reticulate/articles/package.html

#' Altair object
#'
#' Uses the reticulate framework to access the Altair API
#'
#' @export alt
#'
alt <- NULL

.onLoad <- function(libname, pkgname) {
  alt <<- reticulate::import("altair", delay_load = TRUE)
}
