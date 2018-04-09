#' Create a Vega-Lite htmlwidget
#'
#' This function renders an Altair chart as a Vega-Lite htmlwidget.
#'
#' This function is called `vegalite()` is because it returns an htmlwidget
#' that uses the Vega-Lite JavaScript library, rather than the
#' Altair Python package.
#'
#' To include a tooltip the rendering of your chart, use one of the
#' [vega_tooltip()] functions as the value for the `tooltip` argument.
#' Keep in mind that you can make exactly **one** tooltip specification
#' in a rendering; this specification will be applied to the entire chart,
#' even if it is compound chart.
#'
#' @param chart   chart object created using [`alt`]`$Chart()`
#' @param tooltip `vega_tooltip` object to specify tooltip.
#'   The default is an empty call to [vega_toolip()],
#'   which will result in no tooltip displaying.
#' @inheritParams htmlwidgets::createWidget
#' @seealso [vega_tooltip()]
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

#' Shiny output for Vega-Lite
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

#' Render a shiny output for Vega-Lite
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
