#' Render in JupyterLab
#'
#' @param obj object to be mimed
#' @param chart chart object
#'
#' @return called for side-effects
#' @keywords internal
#' @export
#'
py_mimebundle <- function(obj) {
  obj$`_repr_mimebundle_`(include = NULL, exclude = NULL)[[1L]]
}

#' @rdname py_mimebundle
#' @export
#'
repr_text.altair.vegalite.v2.api.Chart <- function(chart) {
  py_mimebundle(chart)$`text/plain`
}

#' @rdname py_mimebundle
#' @export
#'
repr_vegalite2.altair.vegalite.v2.api.Chart <- function(chart) {
  py_mimebundle(chart)$`application/vnd.vegalite.v2+json`
}
