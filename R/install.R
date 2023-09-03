#' Install Altair Python package
#'
#' This function wraps installation functions from [reticulate][reticulate::reticulate] to install the Python packages
#' **altair** and **vega_datasets**.
#'
#' This package uses the [reticulate][reticulate::reticulate] package
#' to make an interface with the [Altair](https://altair-viz.github.io/index.html)
#' Python package. To promote consistency in usage of **reticulate** among
#' different R packages, it is
#' [recommended](https://rstudio.github.io/reticulate/articles/package.html#installing-python-dependencies)
#' to use a common Python environment, called `"r-reticulate"`.
#'
#' Depending on your setup, you can create this environment using
#' `reticulate::conda_create()` or [reticulate::virtualenv_create()],
#' as described in this
#' [reticulate article](https://rstudio.github.io/reticulate/articles/python_packages.html#conda-installation),
#' or in this package's [Installation article](https://vegawidget.github.io/altair/articles/installation.html#python-env).
#'
#' @param method `character`, indicates to use `"conda"` or `"virtualenv"`
#' @param envname `character`, name of environment into which to install
#' @param version `character`, version of Altair to install. For general use of this package,
#'   this is set automatically, so you should not need to specify this.
#' @param ... other arguments sent to `reticulate::py_install()`
#'
#' @return invisible `NULL`, called for side-effects
#'
#' @seealso
#' [altiar: Installation](https://vegawidget.github.io/altair/articles/installation.html),
#' [reticulate: Using reticulate in an R Package](https://rstudio.github.io/reticulate/articles/package.html),
#' [reticulate: Installing Python Packages](https://rstudio.github.io/reticulate/articles/python_packages.html)
#' @examples
#' \dontrun{
#'   # not run because it requires Python
#'   install_altair()
#' }
#' @export
#'
install_altair <- function(method = c("conda", "virtualenv"),
                           envname = "r-reticulate",
                           version = getOption("altair.python.version"),
                           ...) {

  # validate stage, method arguments
  method <- match.arg(method)

  pip <- TRUE # until other installation stuff is sorted out on reticulate

  # determine if this is a release candidate
  is_release_candidate <- grepl(version, "rc")

  if (identical(method, "conda") && is_release_candidate) {
    pip <- TRUE
    message("Package not available on conda-forge, setting pip to TRUE")
  }

  # conda and pip use different syntax for indicating versions
  if (identical(method, "conda") && !pip) {
    version_sep <- "="
  } else {
    version_sep <- "=="
  }

  altair_pkg_version <- paste("altair", version, sep = version_sep)

  # TODO: patch until we can use Altair 5
  pandas_pkg_version <- paste("pandas", "1.5.3", sep = version_sep)

  packages <- c(pandas_pkg_version, altair_pkg_version, "vega_datasets")

  reticulate::py_install(
    packages = packages,
    envname = envname,
    method = method,
    pip = pip,
    pip_ignore_installed = TRUE,
    ...
  )

  invisible(NULL)
}


#' Check the Altair installation
#'
#' Provides feedback on any differences between your installed
#' version of Altair and the version this package supports.
#'
#' If the supported Altair version is different from your installed
#' version, this function will act according to where the
#' difference in the version numbers:
#'
#' - major version leads to an **error**
#' - minor version leads to a **warning**
#' - patch version leads to a **message**
#'
#' If there is no difference:
#'
#' - `quiet = FALSE`, success message showing version-numbers
#' - `quiet = TRUE`, no message
#'
#' To install the supported version into a Python environment
#' called `"r-reticulate"`, use [install_altair()].
#'
#' @param quiet `logical`, if `TRUE`, suppresses message upon successful check
#'
#' @return invisible `NULL`, called for side-effects
#' @seealso [reticulate::py_config()], [install_altair()], [altair_version()]
#' @examples
#' \dontrun{
#'   # not run because it requires Python
#'   check_altair()
#' }
#' @export
#'
check_altair <- function(quiet = FALSE) {
  check_altair_version(quiet = quiet)
}

#' Installed versions of Altair, Vega, etc.
#'
#' Returns a named list of version tags for Altair, Vega, Vega-Lite,
#' and Vega-Embed
#'
#' @return named `list` of version tags
#' @examples
#' if (interactive()) {
#'   altair_version()
#' }
#'
#' @export
#'
altair_version <- function() {
  c(
    list(altair = alt$`__version__`),
    vegawidget::vega_version()
  )
}

#' Check two version-strings
#'
#' Given two version-strings, issue an error, warning, message, or do nothing.
#'
#' @noRd
#'
#' @param version_installed `character` vector, installed version -
#'   can be obtained using `alt$__version__`
#' @param version_supported `character` vector, supported version -
#'   can be obtained using `getOption("altair.pyhton.version")`
#' @param quiet `logical`, if `TRUE`, suppresses message upon successful check
#'
#' @return invisible `NULL`, called for side-effects
#' @keywords internal
#' @examples
#'   version_supported <- "2.0.1"
#'   \donttest{
#'     # issues error
#'     check_altair_version("1.2", version_supported)
#'
#'     # issues warning
#'     check_altair_version("2.1", version_supported)
#'   }
#'
#'   # issues message
#'   check_altair_version("2.0.0", version_supported)
#'   check_altair_version("2.0.0rc1", version_supported)
#'
#'   # does nothing
#'   check_altair_version("2.0.1", version_supported)
#'
check_altair_version <-
  function(version_installed = altair_version()$altair,
           version_supported = getOption("altair.python.version"),
           quiet = FALSE) {

  if (is.null(version_supported)) {
    stop("`version_supported` is NULL, is `altair` package loaded?")
  }

  installed <- get_version_components(version_installed)
  supported <- get_version_components(version_supported)

  version_string <-
    paste(
      "Supported Altair version:",
      version_supported,
      "- Installed Altair version:",
      version_installed
    )

  config_output <-
    paste(
      c(
        "Output from reticulate::py_config():",
        utils::capture.output(reticulate::py_config())
      ),
      collapse = "\n"
    )

  is_identical <- function(component) {
    identical(installed[[component]], supported[[component]])
  }

  # check major version
  if (!is_identical("major")) {

    stop(
      paste(
        "Disagreement in Altair major versions",
        version_string,
        config_output,
        sep = "\n\n"
      ),
      call. = FALSE
    )
  }

  # check minor version
  if (!is_identical("minor")) {
    warning(
      paste(
        "Disagreement in Altair minor versions",
        version_string,
        config_output,
        sep = "\n\n"
      ),
      call. = FALSE
    )

    return(invisible(NULL))
  }

  # check patch, rc versions
  if (!is_identical("patch") || !is_identical("rc")) {
    packageStartupMessage(
      paste(
        "Disagreement in Altair patch versions",
        version_string,
        config_output,
        sep = "\n\n"
      )
    )
    return(invisible(NULL))
  }

  # success!
  if (!quiet) {
    message(paste("Success:", version_string))
  }

  invisible(NULL)
}

#' Get version components
#'
#' @noRd
#'
#' @param version `character`
#'
#' @return `list` with elements: `major`, `minor`, `patch`, `rc`
#' @examples
#' get_version("2.0.0rc1")
#'
#'
get_version_components <- function(version) {

  regex_version <- "^(\\d+)\\.(\\d+)\\.(\\d+)(rc\\d+)?$"

  # validate version
  is_version_number <- grepl(regex_version, version)
  assertthat::assert_that(
    is_version_number,
    msg = paste(version, "not a recognized Altair version number")
  )

  major <- as.integer(sub(regex_version, "\\1", version))
  minor <- as.integer(sub(regex_version, "\\2", version))
  patch <- as.integer(sub(regex_version, "\\3", version))

  get_rc <- function(rc_string) {
    if (identical(rc_string, "")) {
      return(NULL)
    }

    rc <- as.integer(sub("rc(\\d+)", "\\1", rc_string))

    rc
  }

  rc_string <- sub(regex_version, "\\4", version)
  rc <- get_rc(rc_string)

  list(major = major, minor = minor, patch = patch, rc = rc)
}

