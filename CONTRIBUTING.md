# Contributing

## Scope of this package

Deals with the Altair Python package, and embedding and rendering the resulting Vega-Lite chart specification. I think it is a great and wonderful thing to make a more R-like interface to Vega-Lite; however, I think that we should do that in a different package, perhaps called **altools**.

## Style

This package aspires to use the [Tidyverse Style Guide](http://style.tidyverse.org), with some minor modifications.

- [Documenting parameters](http://style.tidyverse.org/code-documentation.html#documenting-parameters):

   For @param and @return, the text should be an uncapitalized sentence clause, starting with the expected class (or possible classes) of the argument or return value.

   ```r
   #' @param width `integer`, sets the view width in pixels 
   #'
   #' @return `logical` indicating success
   ```

Although we are mimicking calls to Python code, even copying-and-pasting Python examples, we should make the calls themselves as R-like as possible. Consider this example from Altair:

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

In the documentation, lets call things (and even name things) charts, as this seems to be the term-of-art that Altair and Vega-Lite use.

## Development strategy

### Versioning

The first digit indicates the maturity of this package's API. For the time being, it will be `0`. When we feel it is time, we will increment the first digit to agree with the first digit of the Altair release, currently `2`.

The second digit will be incremented upon each CRAN release. This will also be given a GitHub release tag.

The third digit will be incremented with each change of the `master` branch. Each change of the master branch will be assigned a git tag, so we will not do this lightly.

### Pull requests

Pull request are very welcome. Our goal is to implement a system along the lines of [gitflow](https://datasift.github.io/gitflow/IntroducingGitFlow.html). Accordingly, the branch into which you should make a pull-request will depend on the situation:

Situation                  | Branch to merge into | Add item to NEWS.md   | Appreciated
-------------------------- | -------------------- | --------------------- | -----------
bug-fix                    | `master`             | Yes                   | 😃
improving documentation    | `develop`            | No                    | 😃
adding vignette            | `develop`            | Yes                   | 😃
helping with a new feature | `<feature-branch>`   | No                    | 😃
proposing a new feature    | `develop`            | Yes                   | 😃

Strategies for roxygen and pkgdown?

### Git branch strategy

One of the motivations is to make our lives as developers, and as users, easier by restricting what types of Altair versions will be supported on which types of git branches.

We should first define "type of Altair version" and "supported"

There are three types of Altair versions:

- `rele_sed`: Th_ s to a released version available on [Conda-Forge](https://anaconda.org/conda-forge/altair) 
- `cand_candidate_ refers to a release-candiate available on [PyPi](https://pypi.org/project/altair)
- _b`: Th_rs to a development version available at [GitHub](https://github.com/altair-viz/altair)

We define "supported" as making the version available through the `install_altair()` function and hardcoding this Altair version as `getOption("altair.python.version.supported")`. 

- `master`: only `rele*sed` ver*ions shall be supported on the `master` branch. Note that this is presently aspirational, but once a `rele*sed` ver*ion is supported on the master branch, this rule shall apply.

- `develop`: `rele*sed` or *cand*date` ver*ions may be supported on the `develop` branch. However, in orrge into `master`, `develop` must support a `rele*sed` ver*ion.

- `<feature-branch>`: any type of version may be supported on a `<feature-branch>`. However, in orrge into `develop`, `<feature-branch>` must support a `rele*released* or *candidate*ion.

We will build some infrastructure around how to change the type of version that your branch supports.
