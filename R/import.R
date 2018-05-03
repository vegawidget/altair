#' Import Vega datasets
#'
#' Lets you access Vega datasets.
#'
#' Returns the `data` object in the Python package
#' [vega-datasets](https://github.com/altair-viz/vega_datasets).
#' In the documentation for this package, it is customary to
#' assign this to an object named `vega_data`.
#'
#' @return An S3 object of class `vega_datasets.core.DataLoader`
#' @seealso
#'   [Vega datasets documentation](https://github.com/altair-viz/vega_datasets)
#' @examples
#' \dontrun{
#'   vega_data <- import_vega_datasets()
#'
#'   # To list available datasets
#'   vega_data$data$list_datasets()
#'
#'   # When accessing a dataset, substitute any "-" in the name with a "_"
#'   head(vega_data$data$sf_temps())
#'
#'   # Metadata are available for each dataset:
#'   vega_data$data$sf_temps$description
#'   vega_data$data$sf_temps$url
#'
#'   # For local datasets, local path is available
#'   vega_data$data$sf_temps$filepath
#' }
#' @export
#'
import_vega_data <- function() {
  vega_data <- reticulate::import("vega_datasets")$data
}
