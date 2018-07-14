# see zzz.R for "creation" of the alt object

#' Create an Altair object from a vegaspec
#'
#' @param spec vegaspec
#'
#' @return altair object
#' @export
#'
to_altair <- function(spec) {

  spec <- as_vegaspec(spec)
  spec <- as_json(spec)

  chart <- alt$Chart()$from_json(spec)

  chart
}
