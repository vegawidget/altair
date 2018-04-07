#' Create a vegalite htmlwidget
#'
#' @param chart   chart object created using `altair$Chart()`
#' @param tooltip tooltip specification
#' @inheritParams htmlwidgets::createWidget
#'
#' @export
#'
vegalite <- function(chart, tooltip = NULL, width = NULL, height = NULL) {

  # create chart-spec, tool-options as JSON
  x <-
    list(
      spec = chart$to_json(),
      tooltip_options = jsonlite::toJSON(tooltip, auto_unbox = TRUE)
    )

  vegalite <-
    htmlwidgets::createWidget(
      "vegalite",
      x,
      width = width,
      height = height,
      package = "altair"
    )

  vegalite
}

#' Shiny output for vegalite
#'
#' @inheritParams htmlwidgets::shinyWidgetOutput
#'
#' @export
#'
vegaliteOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(
    outputId,
    "vegalite",
    width,
    height,
    package = "altair"
  )
}

#' Render a shiny output for vegalite
#'
#' @inheritParams htmlwidgets::shinyRenderWidget
#'
#' @export
#'
renderVegalite <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(
    expr,
    vegaliteOutput,
    env,
    quoted = TRUE
  )
}
