#' @inheritParams vegawidget::as_vegaspec
#' @rdname as_vegaspec
#' @export
#'
as_vegaspec.altair.vegalite.v3.api.TopLevelMixin <- function(spec, ...) {

  # TODO: if needed, insert code to convert your object to
  # something that can be coerced to a vegaspec.
  #
  # e.g.:
  spec <- spec$to_json()

  vegawidget::as_vegaspec(spec, ...)
}

#' @export
#'
print.altair.vegalite.v3.api.TopLevelMixin <- function(x, ...) {

  x <- as_vegaspec(x)

  print(x, ...)
}

#' @export
#'
format.altair.vegalite.v3.api.TopLevelMixin <- function(x, ...) {

  x <- as_vegaspec(x)

  format(x, ...)
}

#' @inheritParams vegawidget::knit_print.vegaspec
#' @rdname knit_print.vegaspec
#' @export
#'
knit_print.altair.vegalite.v3.api.TopLevelMixin <- function(spec, ..., options = NULL) {

  spec <- as_vegaspec(spec)

  knitr::knit_print(spec, ..., options = options)
}
