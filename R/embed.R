#' Vega embed options
#'
#' @param actions `logical` or `list` of logicals
#'   Vega-Embed default is all TRUE.
#'
#' @return `list`
#' @export
#'
vega_embed <- function(actions = TRUE) {

  embed_options <-
    list(
      actions = actions
    )

  embed_options
}
