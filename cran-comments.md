# altair 4.0.1 

## R CMD check results

Please note new email address for maintainer:

> checking CRAN incoming feasibility ... NOTE
  Maintainer: ‘Ian Lyttle <ian.lyttle@se.com>’
  
  New maintainer:
    Ian Lyttle <ian.lyttle@se.com>
  Old maintainer(s):
    Ian Lyttle <ian.lyttle@schneider-electric.com>

0 errors ✓ | 0 warnings ✓ | 1 note x

## Test environments

* local OS X install, R 4.0.3
* GitHub Actions: windows-latest (release)
* GitHub Actions: macOS-latest (release)
* GitHub Actions: ubuntu-20.04 (release)
* GitHub Actions: ubuntu-20.04 (devel)
* Ubuntu Linux 16.04 LTS, R-release, GCC
* Fedora Linux, R-devel, clang, gfortran
* win-builder (devel)

## Author notes

* This package offers a pass-through to a Python library, Altair. Its 
  functionality is to install Altair, then to establish the connection between R
  and Python.

  As such, virtually all the examples and tests cannot be run on CRAN servers, 
  hence the `\dontrun{}` and the like on examples, and skipping of tests. 

  This functionality is tested on Travis, where the Python libraries are available.

* The version (4.0.1) is advanced because we are using the first two
  digits to mirror our supported version of Python Altair (4.0).
