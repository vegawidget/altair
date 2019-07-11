#' Coerce vegaspec to JSON
#'
#' Deprecated, please use \code{vegawidget::\link[vegawidget]{vw_as_json}}.
#'
#' @inherit vegawidget::vw_as_json params return
#' @export
#'
vw_as_json <- function(spec, pretty = TRUE) {
  .Deprecated("vegawidget::vw_as_json")
  vegawidget::vw_as_json(spec, pretty = pretty)
}

#' Shiny-output for vegawidget
#'
#' Deprecated, please use \code{vegawidget::\link[vegawidget]{vegawidgetOutput}}.
#'
#' @inherit vegawidget::vegawidgetOutput params return
#' @export
#'
vegawidgetOutput <- function(outputId, width = "auto", height = "auto") {
  .Deprecated("vegawidget::vegawidgetOutput")
  vegawidget::vegawidgetOutput(
    outputId = outputId,
    width = width,
    height = height
  )
}

#' Render shiny-output for vegawidget
#'
#' Deprecated, please use \code{vegawidget::\link[vegawidget]{renderVegawidget}}.
#'
#' @inherit vegawidget::renderVegawidget params return
#' @export
#'
renderVegawidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  .Deprecated("vegawidget::renderVegawidget")
  vegawidget::renderVegawidget(expr = expr, env = env, quoted = quoted)
}
