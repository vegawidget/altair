#' Install Altair Python package
#'
#' This function wraps [reticulate::py_install()] to provide a straightforward,
#' consistent method to install the Altair Python package.
#'
#' This package uses the [reticulate][reticulate::reticulate] package
#' to make an interface with the [Altair](https://altair-viz.github.io/index.html)
#' Python package. To promote consistency in usage of **reticulate** among
#' different R packages, it is
#' [recommended](https://rstudio.github.io/reticulate/articles/package.html#installing-python-dependencies)
#' to use a common Python environment, called `"r-reticulate"`.
#'
#' If you have a Conda installation, you can create this environment using
#' [reticulate::conda_install()], as described in this
#' [reticulate article](https://rstudio.github.io/reticulate/articles/python_packages.html#conda-installation),
#' or in this package's [Field-Guide to Python Issues](https://ijlyttle.github.io/altair/articles/field-guide-python.html#python-env).
#'
#' At present, version 2 of the Altair Python package is available as a
#' release candidtate on PyPi, so it can be installed using `pip`.
#' This function will use `pip` to install `altair==2.0.0rc2`
#' into your `"r-reticulate"` Python environment.
#'
#' @param pip TRUE to use pip (defaults to TRUE)
#' @inheritParams reticulate::py_install
#' @inheritParams reticulate::conda_install
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
install_altair <- function(method = "auto", conda = "auto", pip = TRUE, ...) {

  # TODO: check version of reticulate

  reticulate::py_install(
    "altair==2.0.0rc2",
    method = method,
    conda = conda,
    pip = pip,
    ...
  )

  invisible(NULL)
}
