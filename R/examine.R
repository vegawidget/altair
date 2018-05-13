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
examine <- function(listdata = NULL, mode = "tree",
                    modes = c("code", "form", "text", "tree", "view"),
                    ..., width = NULL, height = NULL,
                    elementId = NULL) {
  UseMethod("examine")
}

#' @export
#'
examine.default <- function(listdata = NULL, mode = "tree",
                            modes = c("code", "form", "text", "tree", "view"),
                            ..., width = NULL, height = NULL,
                            elementId = NULL) {

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
examine.altair.vegalite.v2.api.TopLevelMixin <-
  function(listdata = NULL, mode = "tree",
           modes = c("code", "form", "text", "tree", "view"),
           ..., width = NULL, height = NULL,
           elementId = NULL) {

  jsontemp <- listdata$to_json(validate = FALSE)

  listdata <- jsonlite::fromJSON(jsontemp)

  NextMethod()
}

