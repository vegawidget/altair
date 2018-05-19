#' Create a Vega/Vega-Lite htmlwidget
#'
#' Renders a chart as an htmlwidget.
#'
#' This function is called `vegawidget()` is because it returns an htmlwidget
#' that uses Vega-Lite and Vega JavaScript libraries, rather than the
#' Altair Python package.
#'
#' To specify embedding-options, use the [vega_embed()] function with the
#' `embed` argument. Its most-important options are:
#'
#' - `renderer`, to specify `"canvas"` (default) or `"svg"`
#' - `actions`,  to specify action-links
#'    for `export`, `source`, `compiled`, and `editor`
#'
#' If `actions` is `TRUE` (or `FALSE`), all the links
#' are shown (or not). Use a named list to be more specific, see
#' [vega_embed()] and [only_actions()].
#'
#' If `embed` is `NULL`, `vegawidget()` sets `embed` to the value of
#' `getOption("altair.embed_options")`. Then, if this option is `NULL`, the
#' [vega-embed](https://github.com/vega/vega-embed#api-reference)
#' defaults are used.
#'
#' The arguments `width` and `height` are used to override the width and height
#' determined using the `chart` specification. However, there are some
#' important provisions:
#'
#' - Specifying `width` and `height` in `vegawidget()` is
#' [effective only for single-view charts and layered charts](
#' https://vega.github.io/vega-lite/docs/size.html#limitations).
#' It will not work for contatenated, faceted, or repeated charts.
#'
#' - In the chart specification, the default interpretation of width and height
#' is to describe the dimensions of the
#' **plotting rectangle**, not including the space used by the axes, labels,
#' etc. When `width` and `height` are specified using `vegawidget()`,
#' the meanings change to describe the dimensions of the **entire** rendered chart,
#' including axes, labels, etc.
#'
#' - Keep in mind that the action-links are not a part of the rendered chart,
#' so you may have to account for them yourself. You might expect
#' the height of the action-links to be 15-20 pixels.
#'
#' @param chart   an Altair chart object
#' @param embed   `vega_embed` object to specify embedding options -
#'   the default is an empty call to [vega_embed()],
#'   which will result in a canvas-rendering and action-links included for
#'   exporting, viewing the Vega-Lite source, and opening the Vega editor.
#' @param width   `integer`, if specified, the total rendered width (in pixels)
#'   of the chart - valid only for single-view charts and layered charts;
#'   the default is to use the width in the chart specification
#' @param height  `integer`, if specified, the total rendered height (in pixels)
#'   of the chart - valid only for single-view charts and layered charts;
#'   the default is to use the height in the chart specification
#' @param ... other arguments
#' @seealso [alt], [vega_embed()],
#'   [altair: Field Guide to Rendering Charts](https://vegawidget.github.io/altair/field-guide-rendering.html)
#' @examples
#' vega_data <- import_vega_data()
#'
#' chart <-
#'   alt$Chart(r_to_py(vega_data$cars()))$
#'   mark_point()$
#'   encode(
#'     x = "Horsepower:Q",
#'     y = "Miles_per_Gallon:Q",
#'     color = "Origin:N"
#'   )
#'
#' \dontrun{
#'   # default: rendered using canvas,
#'   #  default action-links, chart-specification determines size
#'   vegawidget(chart)
#'
#'   # render using SVG
#'   vegawidget(chart, embed = vega_embed(renderer = "svg"))
#'
#'   # do not include action-links
#'   vegawidget(chart, embed = vega_embed(actions = FALSE))
#'
#'   # specify dimensions of rendered-chart
#'   vegawidget(chart, width = 300, height = 200)
#' }
#' @export
#'
vegawidget <- function(chart, embed = NULL, width = NULL, height = NULL, ...) {

  # if `embed` is NULL, check for option
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
      embed_options = unclass(embed)
    )

  vegawidget <-
    htmlwidgets::createWidget(
      "vegawidget",
      x,
      width = width,
      height = height,
      package = "altair"
    )

  vegawidget
}

#' Rendering function - deprecated
#'
#' This function has been renamed to `vegawidget()`
#'
#' @inheritParams  vegawidget
#'
#' @keywords internal
#' @export
#'
vegalite <- function(chart, embed = NULL, width = NULL, height = NULL, ...) {

  .Deprecated("vegawidget")

  vegawidget(
    chart = chart,
    embed = embed,
    width = NULL,
    height = NULL,
    ...
  )
}

#' Shiny output for Vega-Lite
#'
#' @inheritParams htmlwidgets::shinyWidgetOutput
#'
#' @export
#'
vegawidgetOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(
    outputId,
    "vegawidget",
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
renderVegawidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(
    expr,
    vegawidgetOutput,
    env,
    quoted = TRUE
  )
}
