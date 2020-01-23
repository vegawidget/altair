# altair 4.0.1 

## Test environments

* local OS X install, R 3.6.2
* ubuntu 16.04 (on travis-ci), R (oldrel, release, and devel)
* Windows Server 2008 R2 SP1, R-devel, 32/64 bit
* Ubuntu Linux 16.04 LTS, R-release, GCC
* Fedora Linux, R-devel, clang, gfortran
* win-builder (release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Author notes

* This package offers a pass-through to a Python library, Altair. Its 
  functionality is to install Altair, then to establish the connection between R
  and Python.

  As such, virtually all the examples and tests cannot be run on CRAN servers, 
  hence the `\dontrun{}` and the like on examples, and skipping of tests. 

  This functionality is tested on Travis, where the Python libraries are available.

* The version (4.0.1) is advanced because we are using the first two
  digits to mirror our supported version of Python Altair (4.0).
