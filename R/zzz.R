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
#' in Python.
#'
#' @examples
#' \dontrun{
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

#' Vega datasets
#'
#' Uses the reticulate framework to access the `vega_datasets` Python
#' package.
#'
#' Some data are available locally, others require an internet connection.
#'
#' @param ... not used
#'
#' @examples
#' # To list available datasets
#' vega_data$list_datasets()
#'
#' # When accessing a dataset, substitute any "-" in the name with a "_"
#' head(vega_data$sf_temps())
#'
#' # Metadata are available for each dataset:
#' vega_data$sf_temps$description
#' vega_data$sf_temps$url
#'
#' # For local datasets, local path is available
#' vega_data$sf_temps$filepath
#'
#' @seealso [Vega datasets documentation](https://github.com/altair-viz/vega_datasets)
#' @export vega_data
#'
vega_data <- NULL

.onLoad <- function(libname, pkgname) {
  alt <<- reticulate::import("altair", delay_load = TRUE)
  # vega_data <<- reticulate::import("vega_datasets", delay_load = TRUE)$data
}
