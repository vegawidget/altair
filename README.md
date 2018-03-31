
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/ijlyttle/altair.svg?branch=master)](https://travis-ci.org/ijlyttle/altair)
[![CRAN
status](https://www.r-pkg.org/badges/version/altair)](https://cran.r-project.org/package=altair)

# altair

The goal of altair is to provide an interface to the
[Altair](https://altair-viz.github.io) Python package, which builds
Vega-Lite visualizations. I am a big fan of the native R interface to
build Vega-Lite visualizations that Bob Rudis
([@hrbrmstr](https://github.com/hrbrmstr)) and coworkers are building
with the [vegalite](https://github.com/hrbrmstr/vegalite) package.

## Development plan

For the foreseeable future, this package is going to be very rough. At
the moment, you are able to muck around with Vega-Lite 2.0. This means:

1.  You can create charts by accessing the Python **Altair** API using
    **reticulate**.
2.  You can display charts using the `vegalite()` htmlwidget.

There’s really not much beyond that. Here’s what I have in mind for the
near future:

1.  Tooltips.
2.  A proper installation procedure for the Altair Python package, a
    function like `install_altair()`.

In the longer-term future it may be interesting to provide a proper R
interface to the Python API. I have no idea what that looks like,
although we might take some inspiration from the
[keras](https://keras.rstudio.com/) package.

## Installation

For this package, only a development version is available, from
[GitHub](https://github.com/):

``` r
# install.packages("devtools")
devtools::install_github("ijlyttle/altair")
```

It is necessary to have a working Altair installation on your computer.
As a first step, I would recommend that you follow the [Altair
installation
instructions](https://altair-viz.github.io/getting_started/installation.html).
When you get vegalite plots to render in your Python environment, I
would suggest you determine the path to your particular Python
installation.

In your `.Renviron` file, I would suggest that you use this Python path
as the value of `RETICULATE_PYTHON`, for example:

    RETICULATE_PYTHON="/your/path/to/python3.6"

This is where the reticulate package will look first for Python on your
computer.

Of course, once you have edited your `.Renviron` file, restart R for the
changes to take effect.

## Example

This package provides a simple pass-through to the Altiar API.

``` r
library("altair")

plot <- 
  alt$Chart(
    r_to_py(mtcars)
  )$mark_point(
  )$encode(
    x = "mpg:Q",
    y = "hp:Q",
    color = "cyl:N"
  )

vegalite(plot)
```

Some things to keep in mind:

  - Where you see a `.` in the Python examples, use a `$` instead.

  - Any data-frames you provide as arguments need to wrapped by
    `r_to_py()`.

  - In your data-frames, columns that contain dots, i.e. `Sepal.Width`
    will prevent Altair from compiling a chart spec.

I’d like to sort out how to get the `vegalite()` function to “do the
right thing” when knitting to a non-html format.

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
  - [vegalite](https://github.com/hrbrmstr/vegalite): Native R interface
    to Vega-Lite

## Code of conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
