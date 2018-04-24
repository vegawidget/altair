#' Create a Vega-Lite htmlwidget
#'
#' This function renders an Altair chart as a Vega-Lite htmlwidget.
#'
#' Use this function to render a chart as an htmlwidget.
#' To include a tooltip the rendering of your chart, use one of the
#' [vega_tooltip()] functions as the value for the `tooltip` argument.
#'
#' Keep in mind that you can include exactly **one** tooltip specification
#' and exactly **one** chart specification
#' in a rendering; the tooltip will be applied to the entire chart,
#' even if it is compound chart.
#'
#' To specify embedding-options, use the [vega_embed()] function with the
#' `embed` argument. Within [vega_embed()], to specify rendering the chart
#' as `"canvas"` (default) or `"svg"`, use the `renderer` argument.
#' Similarly, use the `actions` argument to specify to include the action
#' links for `export`, `source`, and `editor`. If `actions` is a scalar
#' `TRUE` (the default), all the links are shown; if a scalar `FALSE`, none
#' are shown. Use a named list of locicals otherwise.
#'
#' This function is called `vegalite()` is because it returns an htmlwidget
#' that uses the Vega-Lite JavaScript library, rather than the
#' Altair Python package.
#'
#' @param chart   an Altair plot object
#' @param tooltip `vega_tooltip` object to specify tooltip.
#'   The default is an empty call to [vega_tooltip()],
#'   which will result in no tooltip displaying.
#' @param embed   `list` with emmbed options.
#'   The default is an empty call to [vega_embed()].
#' @inheritParams htmlwidgets::createWidget
#' @seealso [alt], [vega_tooltip()], [vega_embed()], [only_actions()]
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
vegalite <- function(chart,
                     tooltip = vega_tooltip(),
                     embed = vega_embed(),
                     width = NULL, height = NULL) {


  # if width or height is specified, autosize the chart
  if (!is.null(c(width, height))) {

    # if this is not a Chart or a LayeredChart, warn that autosize will not work
    if (!is_simple_chart(chart)) {
      warning(
        "Specifying the rendered width or height of a ",
        "contatenated or faceted chart has no effect."
      )
    }

    # do we need to create config?
    if (is_undefined(chart$config)) {
      chart$config <- alt$Config()
    }

    # do we need to create an autosize?
    if (is_undefined(chart$config$autosize)) {
      chart$config$autosize <- alt$AutoSizeParams()
    }

    # set autosize parameters
    chart$config$autosize$contains <- "padding"
    chart$config$autosize$type <- "fit"

    # do we need to create a view?
    if (is_undefined(chart$config$view)) {
      chart$config$view <- alt$ViewConfig()
    }

    # set width and height parameters
    if (!is.null(width)) {
      chart$config$view$width <- width
    }

    if (!is.null(height)) {
      chart$config$view$height <- height
    }

  }

  # create chart-spec, tool-options as JSON
  x <-
    list(
      chart_spec = chart$to_json(),
      tooltip_options = unclass(tooltip),
      embed_options = unclass(embed)
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
