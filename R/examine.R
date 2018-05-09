#' Examine a specification
#'
#' Use this function to interactvely examine a specification, using
#' [listviewer::jsonedit()]. It can be used to examine a chart-specification
#' (built using [`alt`]$Chart(), or compound charts), or an embedding specification created using
#' [vega_embed()].
#'
#' @inheritParams listviewer::jsonedit
#'
#' @return called for side-effects
#' @examples
#' \dontrun{
#'   vega_data <- import_vega_data()
#'
#'   chart <-
#'     alt$Chart(r_to_py(vega_data$cars$url))$
#'     encode(
#'       x = "Horsepower:Q",
#'       y = "Miles_per_Gallon:Q",
#'       color = "Origin:N"
#'     )$
#'    mark_point()
#'
#'   examine(chart)
#' }
#'
#'
#' @export
#'
examine <- function() {
  UseMethod("examine")
}

# all of these functions have the same formals as listviewer::jsonedit,
#   this seems like a way to save some effort and lessen the chance of
#   an error
#
formals(examine) <- formals(listviewer::jsonedit)

#' @export
#'
examine.default <- function() {

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

formals(examine.default) <- formals(listviewer::jsonedit)

#' @export
#'
examine.altair.vegalite.v2.api.TopLevelMixin <-
  function() {

  jsontemp <- listdata$to_json(validate = FALSE)

  listdata <- jsonlite::fromJSON(jsontemp)

  NextMethod()
}

formals(examine.altair.vegalite.v2.api.TopLevelMixin) <- formals(listviewer::jsonedit)

