
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/altair)](https://cran.r-project.org/package=altair)
[![Travis build
status](https://travis-ci.org/ijlyttle/altair.svg?branch=master)](https://travis-ci.org/ijlyttle/altair)

# altair

The goal of altair is to help you build
[Vega-Lite](https://vega.github.io/vega-lite) visualizations. Using the
[reticulate](https://rstudio.github.io/reticulate) package, it provides
an interface to the [Altair](https://altair-viz.github.io) Python
library. This approach is different from efforts to build a native R
interface to Vega-Lite, by Bob Rudis
([@hrbrmstr](https://github.com/hrbrmstr)) and coworkers: the
[vegalite](https://github.com/hrbrmstr/vegalite) package, which has
inspired this effort.

In this documentation, the capitalized word **Altair** shall refer to
the Python API; the lower-case word **altair** shall refer to this R
package.

## Installation

For this package, only a development version is available, from
[GitHub](https://github.com/):

``` r
# install.packages("devtools")
devtools::install_github("ijlyttle/altair")
```

It is necessary to have a working Altair installation on your computer.
As a first step, you may wish to follow the [Altair installation
instructions](https://altair-viz.github.io/getting_started/installation.html).
Once you have Altair install in your Python environment, you can
determine the path to your particular Python installation:

``` python
# Python

import altair # make sure this works
import sys

sys.executable
```

It might return something like `/path/to/bin/python3.6`; you can use
this value to set an environment variable to specify which Python
environment to use. You might consider putting a line like this into
your `.Renviron`
    file:

    RETICULATE_PYTHON="/your/path/to/python3.6" # your path will be different

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

Also, it mat remain to sort out how to get the `vegalite()` function to
“do the right thing” when knitting to a non-html format.

## Development plan

For the foreseeable future, this package is going to be very rough. At
the moment, you are able to muck around with Vega-Lite 2.0. This means:

1.  You can create charts by accessing the Python **Altair** API using
    **reticulate**.
2.  You can display charts using the `vegalite()` htmlwidget.

There’s really not much beyond that. Here’s what I have in mind for the
near future:

1.  Tightening up existing capabilites.
2.  A proper installation procedure for the Altair Python package, a
    function like `install_altair()`.
3.  Tooltips.

In the longer-term future it may be interesting to provide a proper R
interface to the Python API; there are already some [encouraging first
steps](https://github.com/ijlyttle/altair/issues/15) towards this. This
package has a
[manifesto](https://ijlyttle.github.io/altair/articles/manifesto.html)
to outline some high-level ideas.

## Articles

The documentation for this package includes some articles:

  - [First
    Example](https://ijlyttle.github.io/altair/articles/first-example.html):
    A walkthrough to get a first chart to work.

  - [Interactive
    Examples](https://ijlyttle.github.io/altair/articles/interactive.html):
    A set of examples that work towards linked-brushing of two
    scatterplots.

  - [Manifesto](https://ijlyttle.github.io/altair/articles/manifesto.html):
    A collection of ideas on where this package might go (and where I
    want to keep it from going).

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

A particular debt is owed to the
[vegalite](https://github.com/hrbrmstr/vegalite) project as it provided
a lot of the inspiration for this package.

## Code of conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
