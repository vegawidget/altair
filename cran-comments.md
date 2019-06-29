# altair 3.1.1 (resubmission)

## Resubmission

This is a resubmission. Following Uwe's email of 2019-06-29:

* I have added Python and Altair as `SystemRequirements` - my apologies for 
  missing this.

* The functions from the other package, 'vegawidget', are exported. 

  The 'vegawidget' package offers functions to render 'Vega' and 'Vega-Lite'
  specifications in the browser. The 'altair' package lets you  
  build Vega-Lite specifications by exposing the Python Altair library. 

  As such, 'altair' exports the 'vegawidget' rendering-functions.
  There may be developed other packages that build Vega and Vega-Lite 
  specifications, for which 'vegawidget' offers a common set of 
  rendering functions.

  I have reassessed the functions that are re-exported. I have deprecated three
  of these functions, in favor of directing the user to use vegawidget directly.

## Test environments

* local OS X install, R 3.5.3
* ubuntu 14.04 (on travis-ci), R (oldrel, release, and devel)
* Windows Server 2008 R2 SP1, R-devel, 32/64 bit
* Ubuntu Linux 16.04 LTS, R-release, GCC
* Fedora Linux, R-devel, clang, gfortran
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Author notes

* This package offers a pass-through to a Python library, Altair. Its 
  functionality is to install Altair, then to establish the connection between R
  and Python.

  As such, virtually all the examples and tests cannot be run on CRAN servers, 
  hence the \dontrun{} and the like on examples, and skipping of tests. 

  This functionality is tested on Travis, where the Python libraries are available.

* The initial version (3.1.1) is advanced because we are using the first two
  digits to mirror our supported version of Python Altair (3.1).
