context("test-http_get")

test_that("nrnr_http_get throws unknown data error when passed nonsense string", {
  expect_error(nrnr_http_get(sample(10000, 1)))
  expect_error(nrnr_(paste(sample(LETTERS, 10), collapse = "")))
})

test_that("nrnr_http_get returns string when passed valid series_id", {
  expect_type(nrnr_http_get(sample(series_metadata[["series_id"]], 1)), "character")
})

test_that("nrnr_http_get throws error when passed multiple valid series_id", {
  expect_error(
    nrnr_http_get(
      sample(
        series_metadata[["series_id"]],
        sample(2:25, 1)
      )
    )
  )
})
