# see zzz.R for "creation" of the alt object

#' @export
print.altair.vegalite.v2.api.TopLevelMixin <- function(x, ...){
  print(vegalite(x, ...))
}

#' Knit-print method
#'
#' The only effective options are `out.width` and `out.height`;
#' these are passed to [vegalite()] as `width` and `height`,
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

  width <- to_num(options$out.width)
  height <- to_num(options$out.height)

  knitr::knit_print(vegalite(x, width = width, height = height))
}

