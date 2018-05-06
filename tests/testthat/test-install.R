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


