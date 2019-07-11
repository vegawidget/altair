# see zzz.R for "creation" of the alt object

#' Create Altair chart from vegaspec
#'
#' @inheritParams as_vegaspec
#'
#' @return altair object
#'
#' @examples
#'   if (interactive()) {
#'     as_chart(vegawidget::spec_mtcars)
#'   }
#' @export
#'
as_chart <- function(spec) {

  spec <- as_vegaspec(spec)
  spec <- vegawidget::vw_as_json(spec)

  chart <- alt$Chart()$from_json(spec)

  chart
}
