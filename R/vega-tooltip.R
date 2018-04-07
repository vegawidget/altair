#' Create a Vega tooltip spec
#'
#' Leaving out the specification of JavaScript functions for now, because I don't
#' know how to handle them (yet).
#'
#' @param showAllFields `logical`, indicates which fields to include in tooltip.
#'   - `TRUE`: include all fields in the data.
#'   - `FALSE`: include only those fields specified in `fields`.
#'      Use this with empty `fields` to suppress tooltip.
#'   - `NULL`: include only those fields encoded in the chart.
#' @param fields        `data.frame`, used if `showAllFields == FALSE`.
#'   One row for each field to include in tooltip, with variables:
#'   - `field` (`character`) The unique name of the field. With Vega-Lite,
#'      this is the field you provided to each encoding channel.
#'   - `title` (`character`) A custom title for the field.
#'   - `formatType` (`character`) Tells what kind of field this is
#'      (for formatting the field value in the tooltip)
#'      Supported values: `"number"`, `"time"`, and `"string"`.
#'   - `format` (`character`) A string specifier for formatting the field value
#'      in the tooltip. If `formatType` is `"number"`, you can provide a
#'      [number format string-specifier](https://github.com/d3/d3-format#locale_format).
#'      If `formatType` is `"time"`, you can provide a
#'      [time format string-specifier](https://github.com/d3/d3-time-format#locale_format).
#'      If `formatType` is `"string"`, there is no need to provide a format.
#'   - `aggregate` (`character`) If your Vega-Lite visualization has multiple
#'     aggregations of the same field, you can specify the aggregation
#'     to identify the particular aggregated field.
#'     Supported values: [Vega-Lite aggregate operations](https://vega.github.io/vega-lite/docs/aggregate.html#supported-aggregation-operations)
#' @param delay         `numeric` number of milliseconds tooltip display
#'     should be delayed.
#' @param colorTheme    `character` color theme picker
#' @param sort          `character` specify sorting fields on either
#'    `"title"`, or `"value"`, using sorting orders:
#'    - dates and strings are sorted ascending, numbers descending
#'    - dates appear first, then numbers, then strings
#'
#' @return S3 object with class `vega_tooltip`
#'
#' @seealso [Vega tooltip documentation](https://github.com/vega/vega-tooltip/blob/master/docs/customizing_your_tooltip.md#options)
#'
vega_tooltip <- function(showAllFields = FALSE,
                         fields = data.frame(),
                         delay = 100,
                         colorTheme = c("light", "dark"),
                         sort = c("title", "value")) {

  # input validation

  structure(
    list(
      showAllFields = showAllFields,
      fields = fields,
      delay = delay,
      colorTheme = colorTheme,
      sort = sort
    ),
    class = "vega_tooltip"
  )
}


add_field <- function(x) {
  UseMethod("add_field")
}

add_field.default <- function(x) {
  "Unknown class"
}

add_field.vega_tooltip <- function(tooltip, field = NULL, title = NULL,
                                   formatType = NULL, format = NULL,
                                   aggregate = NULL) {

}
