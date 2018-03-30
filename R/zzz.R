# reference: https://rstudio.github.io/reticulate/articles/package.html
altair <- NULL
json <- NULL

.onLoad <- function(libname, pkgname) {
  altair <<- reticulate::import("altair", delay_load = TRUE)
  json <<- reticulate::import("json", delay_load = TRUE)
}
