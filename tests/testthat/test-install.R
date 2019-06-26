context("test-install.R")

test_that("get_version_components works", {

  expect_identical(
    get_version_components("2.0.1"),
    list(major = 2L, minor = 0L, patch = 1L, rc = NULL)
  )

  expect_identical(
    get_version_components("2.0.0rc2"),
    list(major = 2L, minor = 0L, patch = 0L, rc = 2L)
  )

  expect_error(
    get_version_components("2.1.a"),
    regexp = "not a recognized Altair version number"
  )

})

test_that("check_altair_version works", {

  # requires Python
  skip_on_cran()

  expect_error(check_altair_version("1.2.0", "2.0.1"), "major")

  expect_warning(check_altair_version("2.1.0", "2.0.1"), "minor")

  expect_message(check_altair_version("2.0.0", "2.0.1"), "patch")

  expect_message(check_altair_version("2.0.0rc1", "2.0.0"), "patch")

})


