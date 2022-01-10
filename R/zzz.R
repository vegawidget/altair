# reference: https://rstudio.github.io/reticulate/articles/package.html

#' Altair object
#'
#' Uses the reticulate framework to access the Altair API.
#'
#' The Altair Python package is exposed through the `alt` object.
#' You can create and add to chart using its methods and classes,
#' as outlined in the
#' [Altair Python documentation](https://altair-viz.github.io/index.html).
#'
#' In this package, use the `$` operator wherever you see the `.` operator
#' used in Python.
#'
#' @examples
#' if (interactive()) {
#'   vega_data <- import_vega_data()
#'
#'   plot_basic <-
#'     alt$Chart(vega_data$cars())$
#'     encode(
#'       x = "Miles_per_Gallon:Q",
#'       y = "Horsepower:Q",
#'       color = "Origin:N"
#'     )$
#'     mark_point()
#'
#'    plot_basic
#' }
#'
#' @seealso [Altair Python documentation](https://altair-viz.github.io/index.html),
#' [altair: Field Guide to Python Issues](https://vegawidget.github.io/altair/articles/field-guide-python.html)
#' @export alt
#'
alt <- NULL

on_altair_load <- function() {
  check_altair(quiet = TRUE)

  # leave this here in case we ever need to check the version of reticulate
  #
  # version_reticulate <- utils::packageVersion("reticulate")

}

on_altair_error <- function(e) {
  cat(
    "Error importing Altair python package:",
    "",
    conditionMessage(e),
    "",
    "Output from reticulate::py_config():",
    sep = "\n"
  )
  print(reticulate::py_config())
  # cat(
  #   "",
  #   "Output from reticulate::py_list_packages():",
  #   sep = "\n"
  # )
  # print(reticulate::py_list_packages())

  NULL
}

# =============================================================================
# Note to maintainers:
#
# To change the supported Python version, set the option in .onLoad
# =============================================================================
.onLoad <- function(libname, pkgname) {

  # sets the supported version
  options(altair.python.version = "4.2.0")

  alt <<-
    reticulate::import(
      "altair",
      delay_load = list(
        on_load = on_altair_load,
        on_error = on_altair_error
      )
    )

  vegawidget::s3_register(
    "knitr::knit_print",
    "altair.vegalite.v4.api.TopLevelMixin"
  )
}
