# reference: https://rstudio.github.io/reticulate/articles/package.html

#' Altair object
#'
#' Uses the reticulate framework to access the Altair API.
#'
#' The Altair Python library is exposed through the `alt` object.
#' You can create and add to chart using its methods and classes,
#' as outlined in the
#' [Altair Python documentation](https://altair-viz.github.io/index.html).
#'
#' In this package, use the `$` operator wherever you see the `.` operator
#' used in Python.
#'
#' @examples
#' \dontrun{
#'   vega_data <- import_vega_data()
#'
#'   plot_basic <-
#'     alt$Chart(
#'       r_to_py(vega_data$cars())
#'     )$encode(
#'       x = "Miles_per_Gallon:Q",
#'       y = "Horsepower:Q",
#'       color = "Origin:N"
#'     )$mark_point()
#' }
#'
#' @seealso [Altair Python documentation](https://altair-viz.github.io/index.html),
#' [altair: Field Guide to Python Issues](https://vegawidget.github.io/altair/articles/field-guide-python.html)
#' @export alt
#'
alt <- NULL

on_altair_load <- function() {
  check_altair(quiet = TRUE)

  # check to see that version is at least 1.7.1 to take care of
  # the "pop" problem
  #
  version_reticulate <- utils::packageVersion("reticulate")
  fixed_pop <- (version_reticulate >= package_version("1.7.1"))

  if (!fixed_pop) {
    message(
      "The installed version of reticulate is ",
      version_reticulate,
      "\n",
      "Using this version of reticulate, you will have a problem to ",
      "access the vega dataset \"gapminder\".\n",
      "To fix the problem, you can install the dev version of reticulate ",
      "using: devtools::install_github(\"rstudio/reticulate\")"
    )
  }

}

on_altair_error <- function(e) {
  message("Error importing Altair python package")
  message("Please try using install_altair() to install")
  message("")
  message("Output from reticulate::py_config()")
  reticulate::py_config()
}

# =============================================================================
# Note to maintainers:
#
# To change the supported Python version, set the option in .onLoad
# =============================================================================
.onLoad <- function(libname, pkgname) {

  # sets the supported version
  options(altair.python.version = "2.0.1")

  alt <<-
    reticulate::import(
      "altair",
      delay_load = list(
        on_load = on_altair_load,
        on_error = on_altair_error
      )
    )
}
