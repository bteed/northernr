#' Get Data Series from StatsNWT Time Series Retrieval API
#'
#' @param series Valid TSR series id as string (or string vector if multiple)
#' @param start_year Optional start year. Defaults to full series
#'
#' @return
#' @export
#'
#' @examples
nr_get_series <- function(series_id, start_year = NULL) {
  r <- httr::GET(paste("https://www.statsnwt.ca/TSR/Series_Download.php?seriesid=", paste(series_id, collapse=","), "&startyear=", start_year, sep = ""))
  c <- readr::read_csv(r$content)
  c
}


