#' Create a Vega-Lite htmlwidget
#'
#' Use this function to render a chart as an htmlwidget.
#'
#' This function is called `vegalite()` is because it returns an htmlwidget
#' that uses the Vega-Lite JavaScript library, rather than the
#' Altair Python package.
#'
#' To include a tooltip in your chart-rendering, use one of the
#' [vega_tooltip()] functions with the `tooltip` argument.
#' Keep in mind that you can include exactly **one** tooltip specification
#' and exactly **one** chart specification
#' in a rendering; the tooltip will be applied to the entire chart,
#' even if it is a compound chart.
#'
#' To specify embedding-options, use the [vega_embed()] function with the
#' `embed` argument. Its most-important options are:
#'
#' - `renderer`, to specify `"canvas"` (default) or `"svg"`
#' - `actions`,  to specify action-links
#'    for `export`, `source`, and `editor`
#'
#' If `actions` is `TRUE` (default) or `FALSE`, all the links
#' are shown (or not). Use a named list to be more specific, see
#' [vega_embed()] and [only_actions()].
#'
#' If `embed` is `NULL`, `vegalite()` sets `embed` to the value of
#' `getOption("altair.embed_options")`. If that is null, the
#' [vega-embed](https://github.com/vega/vega-embed#api-reference)
#' defaults are used.
#'
#' The arguments `width` and `height` are used to override the width and height
#' determined using the `chart` specification. However, there are some
#' important provisions:
#'
#' - Specifying `width` and `height` in `vegalite()` is
#' [effective only for single-view charts and layered charts](
#' https://vega.github.io/vega-lite/docs/size.html#limitations).
#' It will not work for contatenated, faceted, or repeated charts.
#'
#' - In the chart specification, the default interpretation of width and height
#' is to describe the dimensions of the
#' **plotting rectangle**, not including the space used by the axes, labels,
#' etc. When `width` and `height` are specified using `vegalite()`,
#' the meanings change to describe the dimensions of the **entire** rendered chart,
#' including axes, labels, etc.
#'
#' - Keep in mind that the action-links are not a part of the rendered chart,
#' so you may have to account for them yourself. You might expect
#' the height of the action-links to be 25-30 pixels.
#'
#' @param chart   an Altair plot object
#' @param tooltip `vega_tooltip` object to specify tooltip options -
#'   the default is an empty call to [vega_tooltip()],
#'   which will result in no tooltip being displayed
#' @param embed   `vega_embed` object to specify embedding options -
#'   the default is an empty call to [vega_embed()],
#'   which will result in a canvas-rendering and all actions-links being
#'   included
#' @param width   `integer`, if specified, the total rendered width (in pixels)
#'   of the chart - valid only for single-view charts and layered charts;
#'   the default is to use the chart specification
#' @param height  `integer`, if specified, the total rendered height (in pixels)
#'   of the chart - valid only for single-view charts and layered charts;
#'   the default is to use the chart specification
#' @seealso [alt], [vega_tooltip()], [vega_embed()]
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
#'   # default: no tooltips, rendered using canvas,
#'   #   all action-links, chart-specification determines size
#'   vegalite(plot_basic)
#'
#'   # tooltip showing encoding variables
#'   vegalite(plot_basic, tooltip = vega_tooltip_encoding())
#'
#'   # render using SVG
#'   vegalite(plot_basic, embed = vega_embed(renderer = "svg"))
#'
#'   # do not include action-links
#'   vegalite(plot_basic, embed = vega_embed(actions = FALSE))
#'
#'   # specify dimensions of rendered-chart
#'   vegalite(plot_basic, width = 300, height = 200)
#' }
#' @export
#'
vegalite <- function(chart,
                     tooltip = vega_tooltip(),
                     embed = NULL,
                     width = NULL, height = NULL) {

  # if `emmbed` is NULL, check for option
  if (is.null(embed)) {
    embed <- getOption("altair.embed_options")
  }

  # keep in mind that only functions will return a copy
  chart_copy <- chart$copy()

  # if width or height is specified, autosize the chart
  if (!is.null(c(width, height))) {

    # if this is not a Chart or a LayeredChart, warn that autosize will not work
    if (!is_simple_chart(chart_copy)) {
      warning(
        "Specifying the rendered width or height of a ",
        "contatenated or faceted chart has no effect."
      )
    }

    # do we need to create config?
    if (is_undefined(chart_copy$config)) {
      chart_copy$config <- alt$Config()
    }

    # do we need to create an autosize?
    if (is_undefined(chart_copy$config$autosize)) {
      chart_copy$config$autosize <- alt$AutoSizeParams()
    }

    # set autosize parameters
    chart_copy$config$autosize$contains <- "padding"
    chart_copy$config$autosize$type <- "fit"

    # do we need to create a view?
    if (is_undefined(chart_copy$config$view)) {
      chart_copy$config$view <- alt$ViewConfig()
    }

    # set width and height parameters
    if (!is.null(width)) {
      chart_copy$config$view$width <- width
    }

    if (!is.null(height)) {
      chart_copy$config$view$height <- height
    }

  }

  # create chart-spec, tool-options as JSON
  x <-
    list(
      chart_spec = chart_copy$to_json(),
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
