# see zzz.R for "creation" of the alt object

#' Create an Altair object from a vegaspec
#'
#' @param spec vegaspec
#'
#' @return altair object
#' @examples
#'   as_chart(vegawidget::spec_mtcars)
#' @export
#'
as_chart <- function(spec) {

  spec <- as_vegaspec(spec)
  spec <- as_json(spec)

  chart <- alt$Chart()$from_json(spec)

  chart
}
