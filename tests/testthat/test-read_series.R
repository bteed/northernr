context("test-read_series")

test_that("nrnr_read_series returns dataframe with cols series_id, period,
          value", {
  test_series_id <- sample(series_metadata[["series_id"]], 1)
  test_response <- nrnr_http_get(test_series_id)

  expect_length(nrnr_read_series(test_response, test_series_id), 3)
  expect_named(
    nrnr_read_series(test_response, test_series_id),
    c("series_id", "period", "value")
  )
  expect_type(
    nrnr_read_series(test_response, test_series_id)[["series_id"]], "character"
    )
  expect_s3_class(
    nrnr_read_series(test_response, test_series_id)[["period"]], "Date"
  )
  expect_is(
    nrnr_read_series(test_response, test_series_id)[["value"]], "numeric"
  )
})
