context("test-http_methods")

test_that("nr_get_series throws error when passed non-character series_id", {
  expect_error(nr_get_series(sample(10000, 1)))
  expect_error(nr_get_series(TRUE))
  expect_error(nr_get_series(FALSE))
  expect_error(nr_get_series(NA))
})
