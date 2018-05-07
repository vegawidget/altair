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
#' @seealso [Altair Python documentation](https://altair-viz.github.io/index.html)
#' @export alt
#'
alt <- NULL


# =============================================================================
# Note to maintainers:
#
# To change the supported Python version, set the option in .onLoad
# =============================================================================

.onLoad <- function(libname, pkgname) {
  # sets the supported version
  options(altair.python.version = "2.0.1")
  alt <<- reticulate::import("altair", delay_load = TRUE)
}
