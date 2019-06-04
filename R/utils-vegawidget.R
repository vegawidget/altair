#### vegaspec functions ####

#' Coerce to vegaspec
#'
#' See \code{vegawidget::\link[vegawidget]{as_vegaspec}} for details.
#'
#' @inheritParams vegawidget::as_vegaspec
#' @return S3 object of class `vegaspec`
#' @export
#'
as_vegaspec.altair.vegalite.v3.api.Chart <- function(spec, ...) {

  # TODO: if needed, insert code to convert your object to
  # something that can be coerced to a vegaspec.
  #
  # e.g.:
  spec <- spec$to_json()

  vegawidget::as_vegaspec(spec, ...)
}

#' @name as_vegaspec
#' @rdname as_vegaspec.altair.vegalite.v3.api.Chart
#'
#' @importFrom vegawidget as_vegaspec
#' @export
#'
NULL

#' Coerce vegaspec to JSON
#'
#' See \code{vegawidget::\link[vegawidget]{vw_as_json}} for details.
#'
#' @name vw_as_json
#' @rdname vw_as_json
#' @importFrom vegawidget vw_as_json
#' @export
#'
NULL

#### print functions ####

#' @export
#'
print.altair.vegalite.v3.api.Chart <- function(x, ...) {

  x <- as_vegaspec(x)

  print(x, ...)
}

#' Knit-print method
#'
#' See \code{vegawidget::\link[vegawidget]{knit_print.vegaspec}} for details,
#' particularly on additional packages that may have to be installed.
#'
#' @inheritParams vegawidget::knit_print.vegaspec
#'
#' @export
#'
knit_print.altair.vegalite.v3.api.Chart <- function(spec, ..., options = NULL) {

  spec <- as_vegaspec(spec)

  knitr::knit_print(spec, ..., options = options)
}

#' @name knit_print.vegaspec
#' @rdname knit_print.altair.vegalite.v3.api.Chart
#'
#' @importFrom vegawidget knit_print.vegaspec
#' @export
#'
NULL

#### vegawidget functions ####

#' Create a Vega/Vega-Lite htmlwidget
#'
#' See \code{vegawidget::\link[vegawidget]{vegawidget}} for details.
#'
#' @name vegawidget
#' @rdname vegawidget
#' @importFrom vegawidget vegawidget
#' @export
#'
NULL

#' Vega embed options
#'
#' See \code{vegawidget::\link[vegawidget]{vega_embed}} for details.
#'
#' @name vega_embed
#' @rdname vega_embed
#' @importFrom vegawidget vega_embed
#' @export
#'
NULL

#### image functions ####

#' Create or write image
#'
#' See \code{vegawidget::\link[vegawidget]{image}} for details.
#'
#' @name image
#' @importFrom vegawidget
#'           vw_to_svg vw_to_bitmap vw_write_png vw_write_svg
#' @aliases  vw_to_svg vw_to_bitmap vw_write_png vw_write_svg
#' @export   vw_to_svg vw_to_bitmap vw_write_png vw_write_svg
#'
NULL
