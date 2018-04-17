context("vega-tooltip")

tooltip_default <- list(
  showAllFields = FALSE,
  delay = 100,
  colorTheme = "light",
  sort = "title"
)



test_that("instantiation works", {

  # a mutate() for lists would be nice here
  tooltip_all <- tooltip_default
  tooltip_all$showAllFields = TRUE

  tooltip_encoding <- tooltip_default
  tooltip_encoding$showAllFields = NULL

  # vega_tooltip()
  tooltip_test <- vega_tooltip()
  expect_equivalent(tooltip_test, tooltip_default)
  expect_is(tooltip_test, "vega_tooltip")

  # vega_tooltip_encoding()
  expect_equivalent(vega_tooltip_encoding(), tooltip_encoding)

  # vega_tooltip_all()
  expect_equivalent(vega_tooltip_all(), tooltip_all)

})

test_that("adding fields works", {

  tooltip_fields_1 <- tooltip_default
  tooltip_fields_1$fields <-
    list(
      list(field = "mpg", title = "MPG")
    )

  tooltip_fields_2 <- tooltip_default
  tooltip_fields_2$fields <-
    list(
      list(field = "mpg", title = "MPG"),
      list(field = "hp", title = "HP")
    )

  tooltip_fields_3 <- tooltip_default
  tooltip_fields_3$fields <-
    list(
      list(field = "mpg", title = "MPG"),
      list(field = "hp", title = "HP"),
      list(field = "cyl", title = "CYL")
    )


  tooltip_fields_test_1 <-
    vega_tooltip() %>%
    add_field(field = "mpg", title = "MPG")

  tooltip_fields_test_2 <-
    vega_tooltip() %>%
    add_field(field = "mpg", title = "MPG") %>%
    add_field(field = "hp", title = "HP")

  tooltip_fields_test_3 <-
    vega_tooltip() %>%
    add_field(field = "mpg", title = "MPG") %>%
    add_field(field = "hp", title = "HP") %>%
    add_field(field = "cyl", title = "CYL")

  expect_equivalent(tooltip_fields_test_1, tooltip_fields_1)
  expect_equivalent(tooltip_fields_test_2, tooltip_fields_2)
  expect_equivalent(tooltip_fields_test_3, tooltip_fields_3)
})
