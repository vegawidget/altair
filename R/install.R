#' Install Altair Python package
#'
#' This function wraps [reticulate::py_install()] to provide a straightforward,
#' consistent method to install the Python packages
#' **altair** and **vega_datasets**.
#'
#' This package uses the [reticulate][reticulate::reticulate] package
#' to make an interface with the [Altair](https://altair-viz.github.io/index.html)
#' Python package. To promote consistency in usage of **reticulate** among
#' different R packages, it is
#' [recommended](https://rstudio.github.io/reticulate/articles/package.html#installing-python-dependencies)
#' to use a common Python environment, called `"r-reticulate"`.
#'
#' Depending on your setup, you can create this environment using
#' [reticulate::conda_create()] or [reticulate::virtualenv_install()],
#' as described in this
#' [reticulate article](https://rstudio.github.io/reticulate/articles/python_packages.html#conda-installation),
#' or in this package's [Field-Guide to Python Issues](https://ijlyttle.github.io/altair/articles/field-guide-python.html#python-env).
#'
#' @param method `character`, indicates to use `"conda"` or `"virtualenv"`
#' @param envname `character`, name of environment into which to install
#' @param pip, `logical`, used for conda installation to indicate to use pip
#'   (will be set to TRUE for release-candidates)
#' @param version `character`, version of Altair to install. For general use of this package,
#'   this is set automatically, so you should not need to specify this.
#' @param ... other arguments sent to [reticulate::conda_install()] or
#'    [reticulate::virtualenv_install()]
#'
#' @return invisible `NULL`, called for side-effects
#'
#' @seealso [Using reticulate in an R Package](https://rstudio.github.io/reticulate/articles/package.html),
#' [reticulate: Installing Python Packages](https://rstudio.github.io/reticulate/articles/python_packages.html),
#' [altiar: Field-Guide to Python Issues](https://ijlyttle.github.io/altair/articles/field-guide-python.html#python-env)
#' @examples
#' \dontrun{
#'   install_altair()
#' }
#' @export
#'
install_altair <- function(method = c("conda", "virtualenv"),
                           envname = "r-reticulate",
                           pip = FALSE,
                           version = getOption("altair.python.version"),
                           ...) {

  # validate stage, method arguments
  method <- match.arg(method)

  # determine if this is a release candidate
  is_release_candidate <- grepl(version, "rc")

  if (identical(method, "conda") && is_release_candidate) {
    pip <- TRUE
    message("Package not available on conda-forge, setting pip to TRUE")
  }

  # conda and pip use different syntax for indicating versions
  if (identical(method, "conda") && !pip) {
    version_sep <- "="
  } else {
    version_sep <- "=="
  }

  altair_pkg_version <- paste("altair", version, sep = version_sep)

  packages <- c(altair_pkg_version, "vega_datasets")

  # call installer
  if (identical(method, "conda")) {
    reticulate::conda_install(
      packages = packages,
      envname = envname,
      pip = pip,
      ...
    )
  }

  if (identical(method, "virtual")) {
    reticulate::virtualenv_install(
      packages = packages,
      envname = envname,
      ...
    )
  }

  invisible(NULL)
}


