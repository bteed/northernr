context("test-parse_date")

test_that("nrnr_parse_date returns type Date", {
  expect_true(
    lubridate::is.Date(
      nrnr_parse_date(
        sample(1900:2100, 1),
        sample(c("Quarter 1", "Quarter 2", "Quarter 3", "Quarter 4"),1))
    )
  )
  expect_true(
    lubridate::is.Date(
      nrnr_parse_date(
        sample(1900:2100, 1),
        sample(month.name, 1))
    )
  )
  expect_true(
    lubridate::is.Date(
      nrnr_parse_date(sample(1900:2100, 1), NA)
    )
  )
})

test_that("nrnr_parse_date returns expected Date from annum and subannum", {
  year <- sample(1900:2100, 1)

  expect_equal(
    nrnr_parse_date(year, "Quarter 1"), lubridate::ymd(paste(year, 1, 1))
  )
  expect_equal(
    nrnr_parse_date(year, "Quarter 2"), lubridate::ymd(paste(year, 4, 1))
  )
  expect_equal(
    nrnr_parse_date(year, "Quarter 3"), lubridate::ymd(paste(year, 7, 1))
  )
  expect_equal(
    nrnr_parse_date(year, "Quarter 4"), lubridate::ymd(paste(year, 10, 1))
  )

  expect_equal(
    nrnr_parse_date(year, "March"), lubridate::ymd(paste(year, 3, 1))
  )
  expect_equal(
    nrnr_parse_date(year, "August"), lubridate::ymd(paste(year, 8, 1))
  )
  expect_equal(
    nrnr_parse_date(year, "November"), lubridate::ymd(paste(year, 11, 1))
  )

  expect_equal(
    nrnr_parse_date(year, NA), lubridate::ymd(paste(year, 1, 1))
  )
})

test_that("nrnr_parse_date returns list of Dates from vectors of annum and subannum", {
  tst_length <- sample(2:1000, 1)
  y <- sample(1900:2100, tst_length, replace = T)
  q <- sample(c("Quarter 1", "Quarter 2", "Quarter 3", "Quarter 4"), tst_length, replace = T)
  m <- sample(month.name, tst_length, replace = T)
  none <- rep_len(NA, length.out = tst_length)

  expect_true(lubridate::is.Date(nrnr_parse_date(y,q)))
  expect_true(lubridate::is.Date(nrnr_parse_date(y,m)))
  expect_true(lubridate::is.Date(nrnr_parse_date(y,none)))
  expect_length(nrnr_parse_date(y,q), tst_length)
  expect_length(nrnr_parse_date(y,m), tst_length)
  expect_length(nrnr_parse_date(y,none), tst_length)
})

