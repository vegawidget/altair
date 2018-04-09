#' Examine a specification
#'
#' Use this function to interactvely examine a specification, using
#' [listviewer::jsonedit()]. Although this has been adpated to examing a Vega-Lite
#' tooltip specification, it could also be adapted to examine an Altair
#' chart specification.
#'
#' @inheritParams listviewer::jsonedit
#'
#' @return called for side-effects
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
  .examine(
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

  listdata <- jsonlite::toJSON(unclass(listdata), auto_unbox = TRUE)

  NextMethod()
}


# internal function
.examine <- function(listdata = NULL, mode = "tree",
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
