#' Coerce to a Vega/Vega-Lite specification
#'
#' Talk about how `vegaspec` is a thin wrapper to `list`. Implemented as JSON.
#'
#' @param spec        object to be coerced to Vega/Vega-Lite specification
#' @param ...         other args (attempt to future-proof)
#'
#' @return S3 object of class `vegaspec`
#' @seealso [vegawidget::as_vegaspec()]
#' @export
#'
as_vegaspec.altair.vegalite.v2.api.TopLevelMixin <- function(spec, ...) {

  spec <- spec$to_json()

  vegawidget::as_vegaspec(spec, ...)
}

#' @export
#'
print.altair.vegalite.v2.api.TopLevelMixin <- function(x, ...) {

  x <- vegawidget::as_vegaspec(x)

  print(x, ...)
}

#' Knit-print method
#'
#'
#' @param x Altair chart object
#' @param ... other arguments
#' @param options `list`, knitr options
#'
#' @export
#'
knit_print.altair.vegalite.v2.api.TopLevelMixin <- function(x, ..., options = NULL){

  x <- vegawidget::as_vegaspec(x)

  knitr::knit_print(x, ..., options = options)
}


#' Vegawidget knit-print
#'
#' See \code{vegawidget::\link[vegawidget]{knit_print.vegaspec}} for details.
#'
#' @name knit_print.vegaspec
#' @rdname knit_print.vegaspec
#' @export
#' @importFrom vegawidget knit_print.vegaspec
NULL

#' Vega-Embed actions
#'
#' See \code{vegawidget::\link[vegawidget]{as_vegaspec}} for details.
#'
#' @name as_vegaspec
#' @rdname as_vegaspec
#' @export
#' @importFrom vegawidget as_vegaspec
NULL

#' render a vegawidget
#'
#' See \code{vegawidget::\link[vegawidget]{vegawidget}} for details.
#'
#' @name vegawidget
#' @rdname vegawidget
#' @export
#' @importFrom vegawidget vegawidget
NULL

#' vegaspec as json
#'
#' See \code{vegawidget::\link[vegawidget]{as_json}} for details.
#'
#' @name as_json
#' @rdname as_json
#' @export
#' @importFrom vegawidget as_json
NULL

#' examine a specification
#'
#' See \code{vegawidget::\link[vegawidget]{examine}} for details.
#'
#' @name examine
#' @rdname examine
#' @export
#' @importFrom vegawidget examine
NULL

#' Vega-Embed options
#'
#' See \code{vegawidget::\link[vegawidget]{vega_embed}} for details.
#'
#' @name vega_embed
#' @rdname vega_embed
#' @export
#' @importFrom vegawidget vega_embed
NULL

#' Vega-Embed actions
#'
#' See \code{vegawidget::\link[vegawidget]{only_actions}} for details.
#'
#' @name only_actions
#' @rdname only_actions
#' @export
#' @importFrom vegawidget only_actions
NULL
