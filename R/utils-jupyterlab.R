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
#' @importFrom repr repr_text
#' @export
#'
repr_text.altair.vegalite.v3.api.Chart <- function(obj) {
  py_mimebundle(obj)$`text/plain`
}

#' MIME method for chart rendering
#'
#' @param obj Altair chart object to be rendered
#'
#' @return list, reflecting JSON spec
#' @keywords internal
#' @importFrom repr repr_vegalite2
#' @export
#'
repr_vegalite3.altair.vegalite.v3.api.Chart <- function(obj) {
  py_mimebundle(obj)$`application/vnd.vegalite.v3+json`
}
