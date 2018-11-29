#' JupyterLab-rendering helper function
#'
#' @param obj Altair chart object to be rendered
#'
#' @return mimebundle object
#' @noRd
#'
py_mimebundle <- function(obj) {
  obj$`_repr_mimebundle_`(include = NULL, exclude = NULL)[[1L]]
}

#' MIME method for text
#'
#' @param obj Altair chart object to be rendered
#'
#' @return character
#' @keywords internal
#' @export
#'
repr_text.altair.vegalite.v2.api.Chart <- function(obj) {
  py_mimebundle(chart)$`text/plain`
}

#' MIME method for chart rendering
#'
#' @param obj Altair chart object to be rendered
#'
#' @return list, reflecting JSON spec
#' @keywords internal
#' @export
#'
repr_vegalite2.altair.vegalite.v2.api.Chart <- function(obj) {
  py_mimebundle(chart)$`application/vnd.vegalite.v2+json`
}
