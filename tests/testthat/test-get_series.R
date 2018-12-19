context("test-get_series")

test_that("nrnr_get_series throws error when passed unknown series_id", {
  expect_error(nrnr_get_series(sample(2:1000, 1)))
  expect_error(nrnr_get_series(sample(c(TRUE, FALSE, NA), 1)))
  expect_error(nrnr_get_series(paste(sample(LETTERS, 10), collapse = "")))
})

test_that("nrnr_get_series returns well-formed dataframe from valid series_id", {
  test_series_id <- sample(series_metadata[["series_id"]], 1)
  test_series <- nrnr_get_series(test_series_id)
  expect_length(test_series, 7)
  expect_named(
    test_series,
    c("matrix_id",
      "matrix_name",
      "series_id",
      "series_name",
      "measurement",
      "period",
      "value"))
  expect_s3_class(test_series[["period"]], "Date")
  expect_is(test_series[["value"]], "numeric")
})
