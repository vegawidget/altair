# reference: https://rstudio.github.io/reticulate/articles/package.html
altair <- NULL

.onLoad <- function(libname, packagename) {
  altair <<- reticulate::import("altair", delay_load = TRUE)
}
