
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/ijlyttle/altair.svg?branch=master)](https://travis-ci.org/ijlyttle/altair)
[![CRAN
status](https://www.r-pkg.org/badges/version/altair)](https://cran.r-project.org/package=altair)

# altair

The goal of altair is to provide an interface to the Altair python
package, which builds Vega-Lite visualizations. This is a short term
solution - I am a big fan of the native R interface to build Vega-Lite
visualizations that Bob Rudis and coworkers are building with their
[vegalite](https://vega.github.io/vega-lite) package.

## Development plan

For the foreseeable future, this package is going to be very rough. The
immediate goal is to be able to muck around with Vega-Lite 2.0. This
means:

1.  Building the bridge to Python and Altair.
2.  Wrapping up outputs as htmlwidgets.

## Installation

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ijlyttle/altair")
```

## Acknowledgements

This package does not contribute much new; it rests on these
foundations:

  - [Altair](https://altair-viz.github.io): Python interface to
    Vega-Lite
  - [Reticulate](https://rstudio.github.io/reticulate): R framework to
    work with Python
  - [Vega-Lite](https://vega.github.io/vega-lite): A grammar of
    interactive graphics
  - [D3](https://d3js.org): Data-driven documents
  - [vegalite](https://vega.github.io/vega-lite): Native R interface to
    Vega-Lite
