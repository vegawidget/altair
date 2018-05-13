
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/altair)](https://cran.r-project.org/package=altair)
[![Travis build
status](https://travis-ci.org/ijlyttle/altair.svg?branch=master)](https://travis-ci.org/ijlyttle/altair)

# altair

The goal of altair is to help you build
[**Vega-Lite**](https://vega.github.io/vega-lite) visualizations. Using
the [**reticulate**](https://rstudio.github.io/reticulate) package, it
provides an interface to the [**Altair**](https://altair-viz.github.io)
Python package. This approach is distinct from efforts to build a native
R interface to Vega-Lite, by [Bob Rudis](https://github.com/hrbrmstr)
and coworkers: the [**vegalite**](https://github.com/hrbrmstr/vegalite)
package, which has inspired this effort.

In this documentation, the capitalized word **Altair** shall refer to
the Python package; the lower-case word **altair** shall refer to this R
package.

## Installation

A development version is available from [GitHub](https://github.com/):

``` r
# install.packages("devtools")
devtools::install_github("ijlyttle/altair") 
```

Because you are using a Python package, you may have some additional
installation steps. These steps are described in greater detail in an
[Installation](https://ijlyttle.github.io/altair/articles/installation.html)
article.

1.  Python must be installed on your system. To make things easier to
    work with reticulate, I recommend using a
    [Conda](https://conda.io/docs) installation;
    [Miniconda](https://conda.io/docs/user-guide/install/download.html#anaconda-or-miniconda)
    works well and installs more-quickly than Anaconda.
    
    If you work in a corporate or institutional environment, you may
    have to specify the location of your SSL certificate, or deal with a
    proxy. The installation article has a
    [section](https://ijlyttle.github.io/altair/articles/installation.html#proxies)
    on this.

2.  Create a Conda environment called `"r-reticulate"`. The reticulate
    folks
    [recommend](https://rstudio.github.io/reticulate/articles/python_packages.html)
    standardizing on a common name for all packages that use reticulate.
    For more information, there is a
    [section](https://ijlyttle.github.io/altair/articles/installation.html#python-env)
    in the installation article.

3.  Install Altair into your `"r-reticulate"` environment using
    `altair::install_altair()`.

You may wish to add a line like this to the `.First()` function in your
`.Rprofile`:

``` r
reticulate::use_condaenv("r-reticulate")
```

This provides a [hint to
reticulate](https://rstudio.github.io/reticulate/articles/versions.html#order-of-discovery)
on which Python environment to use.

## Example

``` r
library("altair")

vega_data <- import_vega_data()

chart <- 
  alt$Chart(r_to_py(vega_data$cars()))$
  encode(
    x = "Horsepower:Q",
    y = "Miles_per_Gallon:Q",
    color = "Origin:N"
  )$
  mark_point()

chart
```

![](man/figures/first-example.png)

Some things to keep in mind:

  - Where you see a `.` in the Python examples, use a `$` instead.

  - Any data frames you provide as `data` arguments need to wrapped by
    `r_to_py()`.

  - In your data, columns that contain dots can be wrapped in square
    brackets in Altair specifications, e.g. `[Sepal.Width]`, to keep
    Altair from throwing an error.

These and other “gotchas” are compiled, along with workarounds, in an
article: [Field Guide to Python
Issues](https://ijlyttle.github.io/altair/articles/field-guide-python.html).

## Articles

The documentation for this package includes some
    articles:

  - [Installation](https://ijlyttle.github.io/altair/articles/installation.html):
    some more-detailed
    instructions

  - [Manifesto](https://ijlyttle.github.io/altair/articles/manifesto.html):
    an outline of some high-level development ideas, which may change
    from time to time

Gallery:

  - Watch this space for an adaptation to R of the [Altair Example
    Gallery](https://altair-viz.github.io/gallery).

Examples:

  - [First
    Example](https://ijlyttle.github.io/altair/articles/first-example.html):
    a walkthrough to get a first chart to work

  - [Vega
    Datasets](https://ijlyttle.github.io/altair/articles/vega-datasets.html):
    work with [Vega
    datasets](https://github.com/altair-viz/vega_datasets) using
    `import_vega_data()`

  - [View
    Composition](https://ijlyttle.github.io/altair/articles/view-composition.html):
    how to facet, add layers to, repeat, and concatenate charts

  - [Interactive
    Examples](https://ijlyttle.github.io/altair/articles/interactive.html):
    a set of examples that work towards linked-brushing of two
    scatterplots

Field Guides:

  - [Field Guide to Python
    Issues](https://ijlyttle.github.io/altair/articles/field-guide-python.html):
    A place for “gotchas” and their workarounds.

  - [Field Guide to Rendering
    Charts](https://ijlyttle.github.io/altair/articles/field-guide-rendering.html):
    How to use the `vegawidget()` function to render charts as HTML.

## Acknowledgements

This package rests on these foundations:

  - [Altair](https://altair-viz.github.io): Python interface to
    Vega-Lite

  - [reticulate](https://rstudio.github.io/reticulate): R framework to
    work with Python

  - [Vega-Lite](https://vega.github.io/vega-lite): a grammar of
    interactive graphics

  - [htmlwidgets](https://www.htmlwidgets.org/): R framework to work
    with JavaScript visualizations

As well, a particular debt is owed to the folks behind the
[vegalite](https://github.com/hrbrmstr/vegalite) package, as it provided
a lot of the inspiration for these efforts.

This project is a collaborative effort. In addition to the principal
author:

  - [Alicia Schep](https://github.com/AliciaSchep) has contributed the
    concatenation functions, as well as sorted out many of the Python,
    JavaScript, and package-API issues.

  - [Haley Jeppson](https://github.com/haleyjeppson) has adapted the
    [Altair Example Gallery](https://altair-viz.github.io/gallery) to R,
    which will be integrated into the [project
    website](https://ijlyttle.github.io/altair) in the coming days.

  - [Heike Hofmann](https://github.com/heike) has been an invaluable
    advisor, providing incisive feedback, and insight into the
    fundamentals of interactive graphics.

## Contributing

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms. This project also has a [Contributing
Guide](CONTRIBUTING.md).
