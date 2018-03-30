#' Create a vegalite htmlwidget
#'
#' @param chart chart object created using `altair$Chart()`
#' @inheritParams htmlwidgets::createWidget
#'
#' @export
#'
vegalite <- function(chart, width = NULL, height = NULL) {

  # create chart-spec as JSON
  spec <- jsonlite::toJSON(chart$to_dict(), auto_unbox = TRUE, pretty = TRUE)

  tmpfile <- tempfile(fileext = ".json")

  chart$savechart(tmpfile)

  text <- readr::read_file(tmpfile)

  htmlwidgets::createWidget(
    "vegalite",
    text,
    width = width,
    height = height,
    package = "altair"
  )
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
