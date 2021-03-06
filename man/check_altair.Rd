% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/install.R
\name{check_altair}
\alias{check_altair}
\title{Check the Altair installation}
\usage{
check_altair(quiet = FALSE)
}
\arguments{
\item{quiet}{\code{logical}, if \code{TRUE}, suppresses message upon successful check}
}
\value{
invisible \code{NULL}, called for side-effects
}
\description{
Provides feedback on any differences between your installed
version of Altair and the version this package supports.
}
\details{
If the supported Altair version is different from your installed
version, this function will act according to where the
difference in the version numbers:
\itemize{
\item major version leads to an \strong{error}
\item minor version leads to a \strong{warning}
\item patch version leads to a \strong{message}
}

If there is no difference:
\itemize{
\item \code{quiet = FALSE}, success message showing version-numbers
\item \code{quiet = TRUE}, no message
}

To install the supported version into a Python environment
called \code{"r-reticulate"}, use \code{\link[=install_altair]{install_altair()}}.
}
\examples{
\dontrun{
  # not run because it requires Python
  check_altair()
}
}
\seealso{
\code{\link[reticulate:py_config]{reticulate::py_config()}}, \code{\link[=install_altair]{install_altair()}}, \code{\link[=altair_version]{altair_version()}}
}
