## R CMD check results

0 errors | 0 warnings  | 0 notes

## revdepcheck results

We checked 1 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages

## Author notes

This release is to comport with the `_PACKAGE` sentinel in {roxygen2}.

This package offers a pass-through to a Python library, Altair. Its 
functionality is to install Altair, then to establish the connection between R
and Python.

As such, virtually all the examples and tests cannot be run on CRAN servers, 
hence the `\dontrun{}` and the like on examples, and skipping of tests. 

This functionality is tested on GitHub Actions, where the Python libraries are available.

