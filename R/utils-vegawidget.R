#### vegaspec functions ####

#' Coerce to vegaspec
#'
#' See \code{vegawidget::\link[vegawidget]{as_vegaspec}} for details.
#'
#' @inheritParams vegawidget::as_vegaspec
#' @return S3 object of class `vegaspec`
#' @export
#'
as_vegaspec.altair.vegalite.v2.api.TopLevelMixin <- function(spec, ...) {

  spec <- spec$to_json()

  vegawidget::as_vegaspec(spec, ...)
}

#' @name as_vegaspec
#' @rdname as_vegaspec.altair.vegalite.v2.api.TopLevelMixin
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
print.altair.vegalite.v2.api.TopLevelMixin <- function(x, ...) {

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
knit_print.altair.vegalite.v2.api.TopLevelMixin <- function(spec, ..., options = NULL) {

  spec <- as_vegaspec(spec)

  knitr::knit_print(spec, ..., options = options)
}

#' @name knit_print.vegaspec
#' @rdname knit_print.altair.vegalite.v2.api.TopLevelMixin
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

#### shiny functions ####

#' Shiny-output for vegawidget
#'
#' See \code{vegawidget::\link[vegawidget]{vegawidgetOutput}} for details.
#'
#' @name vegawidgetOutput
#' @rdname vegawidgetOutput
#' @importFrom vegawidget vegawidgetOutput
#' @export
#'
NULL

#' Render shiny-output for vegawidget
#'
#' See \code{vegawidget::\link[vegawidget]{renderVegawidget}} for details.
#'
#' @name renderVegawidget
#' @rdname renderVegawidget
#' @importFrom vegawidget renderVegawidget
#' @export
#'
NULL

#### debug/share functions ####

#' Examine vegaspec
#'
#' See \code{vegawidget::\link[vegawidget]{vw_examine}} for details.
#'
#' @name vw_examine
#' @rdname vw_examine
#' @importFrom vegawidget vw_examine
#' @export
#'
NULL

#' Create gist to use as block
#'
#' See \code{vegawidget::\link[vegawidget]{vw_create_block}} for details.
#'
#' @name vw_create_block
#' @rdname vw_create_block
#' @importFrom vegawidget vw_create_block vw_create_block_gistid
#' @export
#'
NULL

#' Specify block-configuration
#'
#' See \code{vegawidget::\link[vegawidget]{vw_block_config}} for details.
#'
#' @name vw_block_config
#' @rdname vw_block_config
#' @importFrom vegawidget vw_block_config
#' @export
#'
NULL

#' Retrieve vegaspec from block
#'
#' See \code{vegawidget::\link[vegawidget]{vw_retrieve_block}} for details.
#'
#' @name vw_retrieve_block
#' @rdname vw_retrieve_block
#' @importFrom vegawidget vw_retrieve_block
#' @export
#'
NULL

#### image functions ####

#' Create or write image
#'
#' See \code{vegawidget::\link[vegawidget]{image}} for details.
#'
#' @name image
#' @aliases vw_to_png vw_to_svg vw_write_png vw_write_svg
#' @importFrom vegawidget vw_to_png vw_to_svg vw_write_png vw_write_svg
#' @export                vw_to_png vw_to_svg vw_write_png vw_write_svg
#'
NULL

#' Coerce data-URI string to raw binary
#'
#' See \code{vegawidget::\link[vegawidget]{vw_png_bin}} for details.
#'
#' @name vw_png_bin
#' @rdname vw_png_bin
#' @importFrom vegawidget vw_png_bin
#' @export
#'
NULL

#### utility functions ####

#' Determine Vega JavaScript versions
#'
#' See \code{vegawidget::\link[vegawidget]{vega_version}} for details.
#'
#' @name vega_version
#' @rdname vega_version
#' @importFrom vegawidget vega_version
#' @export
#'
NULL

#' Determine vegaspec version
#'
#' See \code{vegawidget::\link[vegawidget]{vw_spec_version}} for details.
#'
#' @name vw_spec_version
#' @rdname vw_spec_version
#' @importFrom vegawidget vw_spec_version
#' @export
#'
NULL

#' Serialize data-frame time-columns
#'
#' See \code{vegawidget::\link[vegawidget]{vw_serialize_data}} for details.
#'
#' @name vw_serialize_data
#' @rdname vw_serialize_data
#' @importFrom vegawidget vw_serialize_data
#' @export
#'
NULL
