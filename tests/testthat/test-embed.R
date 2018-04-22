context("vega-embed")

test_that("validation works", {

  # renderer
  expect_error(vega_embed(renderer = "foo"))

  # actions
  expect_error(vega_embed(actions = list(TRUE, TRUE)), "must have length 1")
  expect_error(vega_embed(actions = list(source = TRUE, FALSE)), "must have length 1")
  expect_error(vega_embed(actions = list(foo = TRUE)), "illegal name")

})

test_that("helper works", {

  all_false <- list(export = FALSE, source = FALSE, editor = FALSE)
  source_true <- list(export = FALSE, source = TRUE, editor = FALSE)

  expect_identical(only_actions(), all_false)
  expect_identical(only_actions(source = TRUE), source_true)
})

test_that("constructor works", {

  test_embed_default <- vega_embed()
  test_embed <- vega_embed(renderer = "svg", actions = list(source = FALSE))

  expect_s3_class(vega_embed(), "vega_embed")
  expect_s3_class(test_embed, "vega_embed")

  expect_identical(test_embed_default$renderer, "canvas")
  expect_identical(test_embed_default$actions, TRUE)

  expect_identical(test_embed$renderer, "svg")
  expect_identical(test_embed$actions, list(source = FALSE))

})
