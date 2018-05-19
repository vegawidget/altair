#' Import Vega datasets
#'
#' Lets you access Vega datasets.
#'
#' Returns the `data` object in the Python package
#' [vega-datasets](https://github.com/altair-viz/vega_datasets).
#' In the documentation for this package, the convention is to
#' assign this object to the name `vega_data`.
#'
#' @return An S3 object of class `vega_datasets.core.DataLoader`
#' @seealso
#'   [Vega datasets documentation](https://github.com/altair-viz/vega_datasets)
#' @examples
#' \dontrun{
#'   vega_data <- import_vega_data()
#'
#'   # To list available datasets
#'   vega_data$list_datasets()
#'
#'   # When accessing a dataset, substitute any "-" in the name with a "_"
#'   head(vega_data$sf_temps())
#'
#'   # Metadata are available for each dataset:
#'   vega_data$anscombe$references
#'   vega_data$anscombe$description
#'   vega_data$anscombe$url
#'
#'   # For local datasets, local path is available
#'   vega_data$sf_temps$filepath
#' }
#' @export
#'
import_vega_data <- function() {
  vega_data <- reticulate::import("vega_datasets")$data
}
