#' Create a vegalite htmlwidget
#'
#' @param chart   chart object created using `altair$Chart()`
#' @param tooltip `vega_tooltip` object to specify tooltip.
#'   The default is an empty call to `vega_toolip()`,
#'   which will result in no tooltip displaying.
#' @inheritParams htmlwidgets::createWidget
#'
#' @examples
#'   plot_basic <-
#'     alt$Chart(
#'       r_to_py(mtcars)
#'     )$encode(
#'       x = "mpg:Q",
#'       y = "hp:Q",
#'       color = "cyl:N"
#'     )$mark_point()
#'
#' \dontrun{
#'   vegalite(plot_basic)
#' }
#' @export
#'
vegalite <- function(chart, tooltip = vega_tooltip(), width = NULL, height = NULL) {

  # create chart-spec, tool-options as JSON
  x <-
    list(
      spec = chart$to_json(),
      tooltip_options = unclass(tooltip)
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
