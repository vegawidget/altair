#' Detect Altair installation
#'
#' Diagnostic function to confirm Altair is working
#'
#' In the future, this will have more diagnostics and useful feedback.
#'
#' @return `logical` indicating success
#' @examples
#' \dontrun{
#'   has_altair()
#' }
#' @export
#'
has_altair <- function() {

  empty_chart <- alt$Chart()

  assertthat::assert_that(
    assertthat::are_equal(
      class(empty_chart)[[1]],
      "altair.vegalite.v2.api.Chart"
    )
  )

  TRUE
}

#' Convert an R object to Python
#'
#' This function is re-exported from the reticulate package.
#' See [reticulate::r_to_py()] for more details.
#'
#' @name r_to_py
#' @keywords internal
#' @seealso [reticulate::r_to_py()]
#' @export
#' @importFrom reticulate r_to_py
#'
NULL

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



