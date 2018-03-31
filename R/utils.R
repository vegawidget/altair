#' Detect Altair installation
#'
#' Diagnostic function to confirm Altair is working
#'
#' In the future, this will have more diagnostics and useful feedback.
#'
#' @return `logical` indicating success
#' @examples
#' \dontrun{
#'   has_altair()
#' }
#' @export
#'
has_altair <- function() {

  empty_chart <- altair$Chart()

  assertthat::assert_that(
    assertthat::are_equal(
      class(empty_chart)[[1]],
      "altair.vegalite.v2.api.Chart"
    )
  )

  TRUE
}
