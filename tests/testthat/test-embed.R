context("vega-embed")

test_that("validation works", {

  # renderer
  expect_error(vega_embed(renderer = "foo"))

  # actions
  expect_error(vega_embed(actions = list(TRUE, TRUE)), "must be scalar")
  expect_error(vega_embed(actions = list(source = TRUE, FALSE)), "must be scalar")
  expect_error(vega_embed(actions = list(foo = TRUE)), "illegal name")

})

test_that("constructor works", {

  test_embed <- vega_embed(renderer = "svg", actions = list(source = FALSE))

  expect_s3_class(test_embed, "vega_embed")

  expect_identical(test_embed$renderer, "svg")
  expect_identical(test_embed$actions, list(source = FALSE))

})
