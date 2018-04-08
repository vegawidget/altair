context("vega-tooltip")

tooltip_default <- list(
  showAllFields = FALSE,
  delay = 100,
  colorTheme = "light",
  sort = "title"
)

# a mutate() for lists would be nice here
tooltip_all <- tooltip_default
tooltip_all$showAllFields = TRUE

tooltip_encoding <- tooltip_default
tooltip_encoding$showAllFields = NULL

test_that("instantiation works", {

  # vega_tooltip()
  tooltip_test <- vega_tooltip()
  expect_equivalent(tooltip_test, tooltip_default)
  expect_is(tooltip_test, "vega_tooltip")

  # vega_tooltip_encoding()
  expect_equivalent(vega_tooltip_encoding(), tooltip_encoding)

  # vega_tooltip_all()
  expect_equivalent(vega_tooltip_all(), tooltip_all)

})
