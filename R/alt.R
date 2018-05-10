# see zzz.R for "creation" of the alt object

#' @export
print.altair.vegalite.v2.api.TopLevelMixin <- function(x, ...){
  print(vegawidget(x, ...))
}

#' Knit-print method
#'
#' The only effective options are `vega.width` and `vega.height`;
#' these are passed to [vegawidget()] as `width` and `height`,
#' respectively.
#'
#' `out.width` and `out.height` are
#' coerced to numeric, so it is ineffective to specify a percentage.
#'
#' @param x Altair chart object
#' @param ... other arguments
#' @param options `list`, knitr options
#'
#' @export
#'
knit_print.altair.vegalite.v2.api.TopLevelMixin <- function(x, ..., options = NULL){

  # it is ineffective to set out.width or out.height as a percentage
  to_num <- function(x) {

    if (is.null(x)) {
      return(NULL)
    }

    suppressWarnings({
      x_num <- as.numeric(x)
    })

    if (is.na(x_num)) {
      return(NULL)
    }

    x_num
  }

  width <- to_num(options$vega.width)
  height <- to_num(options$vega.height)

  knitr::knit_print(vegawidget(x, width = width, height = height))
}

