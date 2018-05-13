# Contributing

## Package scope

The purpose of this package is to provide you the means:

- to install the **Altair** Python package.
- to build Vega-Lite chart-specifications using Altair. 
- to render chart-specifications into HTML.
- to communicate your charts.

There are a lot of "moving parts" in keeping current with a Python package and a set of JavaScript libraries (Vega-Lite, vega-embed, ...). Accordingly, I want -- at least initially -- to keep the scope of this package as focused as possible.

That being said, I think it is a great and wonderful thing to make a more R-like interface to Vega-Lite. I think that we should do that in a different package, perhaps called **altools**.

## Style

Looking at the present state of this package repository, you may think that this style guide is more aspirational than operational. You would not be incorrect in this assessment.

This package aspires to use the [Tidyverse Style Guide](http://style.tidyverse.org), with some minor modifications.

- [Documenting parameters](http://style.tidyverse.org/code-documentation.html#documenting-parameters):

   For @param and @return, the text should be an uncapitalized sentence clause, starting with the expected class (or possible classes) of the argument or return value.

   ```r
   #' @param width `integer`, sets the view width in pixels 
   #'
   #' @return `logical` indicating success
   ```

In documentation, let's reserve the use of "capital-A" **Altair** to refer to the Python package, and the use of "small-a" to refer to this package.

Although we are mimicking calls to Python code, even copying-and-pasting Python examples, we should make the syntax of the calls as R-like as possible. Consider this Python example from Altair:

```python
import altair as alt
from vega_datasets import data
cars = data.cars()

chart = alt.Chart(cars).mark_point().encode(
    x='Horsepower',
    y='Miles_per_Gallon',
    color='Origin',
    shape='Origin'
)
```

And how we would write this in R:

```r
library("altair")

vega_data <- import_vega_data()
cars <- vega_data$cars()

chart <-
  alt$Chart(r_to_py(cars))$
  mark_point()$
  encode(
    x = "Horsepower",
    y = "Miles_per_Gallon",
    color = "Origin",
    shape = "Origin"
  )
```

Here, I am experimenting with something. Clearly, the `$` operator is not a pipe, `%>%`. However, it can be used across line-breaks such that we could format the code in the same style as a pipe. I realize this is not completely satisfying, but it at least resembles a **ggplot2** style. 

In the documentation, let's call things (and even name things) charts, as this seems to be the term-of-art that Altair and Vega-Lite use. 

## Development strategy

### Versioning

The first digit indicates the maturity of this package's API. For the time being, it will be `0`.

The second digit will be incremented upon each CRAN release and assigned a GitHub release tag.

The third digit will be incremented with each change of the `master` branch. Each change of the master branch will be assigned a git tag, so we will try not to do this lightly.

The fourth digit is reserved to the `develop` branch and any `<feature-branch>`.

### Pull requests

Pull request are very welcome. Our goal is to implement a system along the lines of [gitflow](https://datasift.github.io/gitflow/IntroducingGitFlow.html). Accordingly, the branch into which you should make a pull-request will depend on the situation:

Situation                  | Reference branch     | Add item to NEWS.md   | Appreciated
-------------------------- | -------------------- | --------------------- | -----------
bug-fix                    | `master`             | Yes                   | 😃
improving documentation    | `develop`            | No                    | 😀
adding vignette            | `develop`            | Yes                   | 😀
helping with a new feature | `<feature-branch>`   | No                    | 😃
proposing a new feature    | `develop`            | Yes                   | 😃

Please roxygenize as a part of your pull-request, however, please do not commit your changes to pkgdown. I will do that following a merging the PR. (Let's see how that works) 

### Git branch strategy

One of the motivations is to make our lives as developers, and as users, easier by restricting what types of Altair versions will be supported on which types of git branches.

We should first define "type of Altair version" and "supported".

There are three types of Altair versions:

- __released__ refers to a released version available on [Conda-Forge](https://anaconda.org/conda-forge/altair) 
- __candidate__ refers to a release-candidate available on [PyPi](https://pypi.org/project/altair)
- __github__ refers to a development version available at [GitHub](https://github.com/altair-viz/altair)

We define "supported" as making the version available through the `install_altair()` function and hardcoding this Altair version as `getOption("altair.python.version.supported")`. 

- `master`: only __released__ versions shall be supported on the `master` branch. Note that this is presently aspirational, but once a __released__ version is supported on the master branch, this rule shall apply.

- `develop`: __released__ or __candidate__ versions may be supported on the `develop` branch. However, to merge into `master`, it must support a __released__ version.

- `<feature-branch>`: any type of version may be supported on a `<feature-branch>`. However, to merge into `develop`, it must support a __released__ or __candidate__ version.

We will build some infrastructure around how to change the type of version that your branch supports.
