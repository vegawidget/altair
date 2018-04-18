#' Examine a specification
#'
#' Use this function to interactvely examine a specification, using
#' [listviewer::jsonedit()]. It can be used to examine a chart-specification
#' (built using [`alt`]$Chart()) or a tooltip-specification
#' (built using [vega_tooltip()]).
#'
#' @inheritParams listviewer::jsonedit
#'
#' @return called for side-effects
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
#'   examine(plot_basic)
#' }
#'
#'   tooltip_custom <-
#'     vega_tooltip() %>%
#'     add_field(field = "mpg", title = "MPG") %>%
#'     add_field(field = "hp", title = "HP")
#'
#' \dontrun{
#'   examine(tooltip_custom)
#' }
#'
#' @export
#'
examine <- function(listdata = NULL, mode = "tree",
                    modes = c("code", "form", "text", "tree", "view"), ...,
                    width = NULL, height = NULL, elementId = NULL) {
  UseMethod("examine")
}

#' @export
#'
examine.default <- function(listdata = NULL, mode = "tree",
                            modes = c("code", "form", "text", "tree", "view"), ...,
                            width = NULL, height = NULL, elementId = NULL) {

  if (!requireNamespace("listviewer", quietly = TRUE)) {
    stop("Package \"listviewer\" needed for this function to work. Please install it.",
         call. = FALSE)
  }

  listviewer::jsonedit(
    listdata = listdata,
    mode = mode,
    modes = modes,
    ...,
    width = width,
    height = height,
    elementId = elementId
  )
}

#' @export
#'
examine.vega_tooltip <- function(listdata = NULL, mode = "tree",
                                 modes = c("code", "form", "text", "tree", "view"), ...,
                                 width = NULL, height = NULL, elementId = NULL) {

  # need to do this so JS functions show up
  listdata <- jsonlite::toJSON(unclass(listdata), auto_unbox = TRUE)

  NextMethod()
}

#' @export
#'
examine.altair.vegalite.v2.api.Chart <- function(listdata = NULL, mode = "tree",
                                                 modes = c("code", "form", "text", "tree", "view"), ...,
                                                 width = NULL, height = NULL, elementId = NULL) {

  jsontemp <- listdata$to_json(validate = FALSE)

  listdata <- jsonlite::fromJSON(jsontemp)

  NextMethod()
}

#' @export
#'
examine.python.builtin.object <- function(listdata = NULL, mode = "tree",
                                                 modes = c("code", "form", "text", "tree", "view"), ...,
                                                 width = NULL, height = NULL, elementId = NULL) {

  # used for compound charts - it would be great if they had a Python class that
  # we could detect

  # TODO - this seems really smelly to me
  if (!("list" %in% class(listdata))){
    jsontemp <- listdata$to_json(validate = FALSE)

    listdata <- jsonlite::fromJSON(jsontemp)
  }

  NextMethod()
}

