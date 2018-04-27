#' Create a Vega tooltip-specification
#'
#' This function creates a Vega tooltip-specification according to the options
#' detailed in the [Vega tooltip documentation](https://github.com/vega/vega-tooltip/blob/master/docs/customizing_your_tooltip.md#options).
#'
#' This function is called `vega_tooltip()` because the tooltip specification
#' made for the Vega JavaScript library; it is independent from the Altair
#' Python package.
#'
#' A tooltip specification is separate from a chart specification; they are
#' combined when they are both rendered into an htmlwidget, using [vegalite()].
#' One conseqence of this is that you can have exactly one tooltip
#' specification per chart, even a compound chart.
#'
#' There are three versions of this function, each will result in a different
#' default behavior of the tooltip:
#'
#' \describe{
#'   \item{`vega_tooltip()`}{no tooltip is displayed,
#'     absent the use of [add_field()]}
#'   \item{`vega_tooltip_encoding()`}{tooltip displays all the variables
#'     in the chart's encoding}
#'   \item{`vega_tooltip_all()`}{tooltip displays all the variables
#'     in the chart's data}
#' }
#'
#' To customize the fields in a tooltip specification, begin with with a
#' specification with no fields, using `vega_tooltip()`. To add fields
#' (variables) to the specification, pipe this to the [add_field()] function
#' for as many fields as you wish to add. See the included example that
#' composes `tooltip_custom`.
#'
#' You can use the [examine()] function to interactively examine
#' a tooltip specification.
#'
#' @param showAllFields `logical`, indicates which fields to include in tooltip.
#'   - `TRUE`: include all fields in the data.
#'   - `FALSE`: include only those fields specified in `fields`.
#'      Use this with empty `fields` to suppress tooltip.
#'   - `NULL`: include only those fields encoded in the chart.
#' @param fields        `list`, tooltip specification to use if `showAllFields == FALSE`.
#'   Use [add_field()] to specify.
#' @param delay         `numeric` number of milliseconds tooltip display
#'     should be delayed.
#' @param onAppear      `JS_EVAL` object created using [JS()],
#'     a function with arguments: `event`, `item`.
#'     Callback when tooltip first appears
#'     (when mouse moves over a new item in visualization).
#' @param onMove        `JS_EVAL` object created using [JS()],
#'     a function with arguments: `event`, `item`.
#'     Callback when tooltip moves
#'     (e.g., when mouse moves within a bar).
#' @param onDisappear   `JS_EVAL` object created using [JS()],
#'     a function with arguments: `event`, `item`.
#'     Callback when tooltip disappears
#'     (when mouse moves out an item).
#' @param colorTheme    `character` color theme picker
#' @param sort          `character` or  `JS_EVAL` object created using
#'    [htmlwidgets::JS()],
#'    specify sorting fields on either
#'    `"title"`, or `"value"`, using sorting orders:
#'    - dates and strings are sorted ascending, numbers descending
#'    - dates appear first, then numbers, then strings
#'
#' @return S3 object with class `vega_tooltip`
#'
#' @seealso [Vega tooltip documentation](https://github.com/vega/vega-tooltip/blob/master/docs/customizing_your_tooltip.md#options),
#'   [add_field()], [vegalite()], [examine()]
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
#'   vegalite(plot_basic, tooltip = vega_tooltip_encoding())
#' }
#'
#' tooltip_custom <-
#'   vega_tooltip() %>%
#'   add_field(field = "mpg", title = "MPG") %>%
#'   add_field(field = "hp", title = "HP")
#'
#' \dontrun{
#'   vegalite(plot_basic, tooltip = tooltip_custom)
#' }
#'
#' @export
#'
vega_tooltip <- function(showAllFields = FALSE,
                         fields = NULL,
                         delay = 100,
                         onAppear = NULL,
                         onMove = NULL,
                         onDisappear = NULL,
                         colorTheme = c("light", "dark"),
                         sort = c("title", "value")) {

  # input validation
  # TODO: needs more
  colorTheme <- match.arg(colorTheme)
  sort <- match.arg(sort)

  list_tmp <-
    list(
      showAllFields = showAllFields,
      fields = fields,
      delay = delay,
      onAppear = onAppear,
      onMove = onMove,
      onDisappear = onDisappear,
      colorTheme = colorTheme,
      sort = sort
    )

  # remove the null elements
  list_tmp[vapply(list_tmp, is.null, logical(1))] <- NULL

  structure(
    list_tmp,
    class = "vega_tooltip"
  )
}

#' @rdname vega_tooltip
#' @param ... other arguments passed to [vega_tooltip()]
#' @export
#'
vega_tooltip_encoding <- function(showAllFields = NULL, ...) {
  vega_tooltip(
    showAllFields = showAllFields,
    ...
  )
}

#' @rdname vega_tooltip
#' @export
#'
vega_tooltip_all <- function(showAllFields = TRUE, ...) {
  vega_tooltip(
    showAllFields = showAllFields,
    ...
  )
}

#' Add a field to a Vega tooltip-specification
#'
#' This function is used to add custom fields to a tooltip specification
#' created using [vega_tooltip()], according to the options
#' detailed in the [Vega tooltip documentation](https://github.com/vega/vega-tooltip/blob/master/docs/customizing_your_tooltip.md#options).
#'
#' This function both takes and returns a tooltip specification;
#' it can be used in a "pipeline" that creates a
#' tooltip specification, then adds fields to it.
#'
#' When making a tooltip specification with custom fields,
#' use the [vega_tooltip()] function to create the tooltip.
#' This function, when called with its default
#' `showAllFields = FALSE`, suppresses the default fields, allowing you
#' to propose custom fields.
#'
#' @param tooltip `vega_tooltip` object, created using [vega_tooltip()]
#' @param ...     other arguments (not supported)
#' @inheritParams tooltip_field
#'
#' @return `vega_tooltip` object
#' @seealso [Vega tooltip documentation](https://github.com/vega/vega-tooltip/blob/master/docs/customizing_your_tooltip.md#options),
#'   [vega_tooltip()]
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
#'   tooltip_custom <-
#'     vega_tooltip() %>%
#'     add_field(field = "mpg", title = "MPG") %>%
#'     add_field(field = "hp", title = "HP")
#'
#' \dontrun{
#'   vegalite(plot_basic, tooltip = tooltip_custom)
#' }
#'
#' @export
#'
add_field <- function(tooltip, field = NULL, title = field,
                      formatType = NULL, format = NULL,
                      valueAccessor = NULL, render = NULL,
                      aggregate = NULL, ...) {
  UseMethod("add_field")
}

#' @export
#'
add_field.default <- function(tooltip, field = NULL, title = field,
                              formatType = NULL, format = NULL,
                              valueAccessor = NULL, render = NULL,
                              aggregate = NULL, ...) {
  "Unknown class"
}

#' @export
#'
add_field.vega_tooltip <- function(tooltip, field = NULL, title = field,
                                   formatType = NULL, format = NULL,
                                   valueAccessor = NULL, render = NULL,
                                   aggregate = NULL, ...) {

  # TODO: check to see that `tooltip$showAllFields == FALSE`, warn otherwise

  field_new <- tooltip_field(
    field = field,
    title = title,
    formatType = formatType,
    format = format,
    valueAccessor = valueAccessor,
    render = render,
    aggregate = aggregate
  )

  if (is.null(tooltip$fields)) {
    tooltip$fields <- list(field_new)
  } else {
    tooltip$fields <- c(tooltip$fields, list(field_new))
  }

  tooltip
}

#' Create a field specification for a Vega tooltip
#'
#' @param field         `character`, the unique name of the field.
#'   With Vega-Lite, this is the field you provided to each encoding channel.
#' @param title         `character` or `JS_EVAL` object created using
#'   [JS()], a custom title for the field,
#'   or an accessor function that generates it from the scenegraph datum.
#' @param formatType    `character`, tells what kind of field this is
#'   (for formatting the field value in the tooltip)
#'   Supported values: `"number"`, `"time"`, and `"string"`.
#' @param format        `character` or `JS_EVAL` object created using
#'   [JS()]
#'   - **string**:  a string specifier for formatting the field value
#'      in the tooltip. If `formatType` is `"number"`, you can provide a
#'      [number format string-specifier](https://github.com/d3/d3-format#locale_format).
#'      If `formatType` is `"time"`, you can provide a
#'      [time format string-specifier](https://github.com/d3/d3-time-format#locale_format).
#'      If `formatType` is `"string"`, there is no need to provide a format.
#'    - **function**: function that returns a string, in which case `formatType` is ignored.
#' @param valueAccessor `JS_EVAL` object created using [JS()]
#' @param render        `JS_EVAL` object created using [JS()]
#' @param aggregate     `character`
#'
#' @keywords internal
#' @export
tooltip_field <- function(field = NULL, title = field,
                          formatType = NULL, format = NULL,
                          valueAccessor = NULL, render = NULL,
                          aggregate = NULL) {

  # TODO: validate inputs

  # create a temporary list
  result <- list(
    field = field,
    title = title,
    formatType = formatType,
    format = format,
    valueAccessor = valueAccessor,
    render = render,
    aggregate = aggregate
  )

  # remove the null elements
  result[vapply(result, is.null, logical(1))] <- NULL

  result
}
