#' Clean a date response from TSR/Series_Download.php
#'
#' @param annum Value representing a year
#' @param subannum Value representing the sub-annual period. If it's not a
#'   quarter or a month, nrnr_parse_date will default to January 1 of annum.
#'
#' @return Date object
#' @export
#'
#' @examples
nrnr_parse_date <-
  function(annum, subannum) {

    num_dates <-
      ifelse(
        subannum %in% c("Quarter 1", "Quarter 2", "Quarter 3", "Quarter 4"),
        lubridate::yq(paste(annum, subannum)),
        ifelse(
          subannum %in% month.name,
          lubridate::ymd(paste(annum, subannum, "1")),
          lubridate::ymd(paste(annum,"1","1"))
        )
      )

    lubridate::as_date(num_dates)

  }
