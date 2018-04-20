#' Altair plot concatenation
#'
#' Altair plots can be concatenated using the following operators:
#' `+`, `|`, and `&`
#' @md
#'
#' @param e1 An Altair plot object
#' @param e2 An Altair plot object
#'
#' @return Compound Altair plot object
#'
#' @rdname altair_concatenation
#' @name altair_concatenation
#' @examples
#'
#' # Layering Charts
#' base = alt$Chart(r_to_py(beaver1))$encode(
#'   x = alt$X('time'),
#'   y = alt$Y('temp', scale = alt$Scale(zero = FALSE))
#' )
#'
#' scatter_plot <- base$mark_point()
#' line_plot <- base$mark_line()
#'
#' vegalite(scatter_plot + line_plot)
NULL

#' @rdname altair_concatenation
#' @export
"|.altair.vegalite.v2.schema.core.VegaLiteSchema" <- function(e1, e2) {
 alt$hconcat(e1,e2)
}

#' @rdname altair_concatenation
#' @export
"+.altair.vegalite.v2.schema.core.VegaLiteSchema" <- function(e1, e2) {
  alt$layer(e1,e2)
}

#' @rdname altair_concatenation
#' @export
"&.altair.vegalite.v2.schema.core.VegaLiteSchema" <- function(e1, e2) {
  alt$vconcat(e1,e2)
}


