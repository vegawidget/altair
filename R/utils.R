#' Mark character strings as literal JavaScript code
#'
#' This function is re-exported from the htmlwidgets package.
#' See [htmlwidgets::JS()] for more details.
#'
#' @name JS
#' @keywords internal
#' @seealso [htmlwidgets::JS()]
#' @export
#'
JS <- function(...) {

  x <- htmlwidgets::JS(...)
  class(x) <- c(class(x), "character")

  x
}

list_remove_null <- function(x) {

  # determine which elements are NULL
  is_null <- vapply(x, is.null, logical(1))

  # remove them by settiing them to NULL (!?!)
  x[is_null] <- NULL

  x
}

is_simple_chart <- function(x) {

  class_simple_chart <-
    c("altair.vegalite.v2.api.Chart", "altair.vegalite.v2.api.LayerChart")

  inherits(x, class_simple_chart)
}

is_undefined <- function(x) {
  inherits(x, "altair.utils.schemapi.UndefinedType")
}



