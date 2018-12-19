#' Transform well-formed string to dataframe
#'
#' @param response String returned by nrnr_http_get
#' @param series_id A valid TSR series_id
#'
#' @return A 3-column dataframe (series_id, period, value)
#' @export
#'
#' @examples
nrnr_read_series <- function(response, series_id) {
  series <-
    read.csv(
      text = response,
      skip = 4,
      header = F,
      encoding = "UTF-8",
      stringsAsFactors = F,
      strip.white = T
    )

  tibble::tibble(
    series_id = rep_len(series_id, length(series[3])),
    period = nrnr_parse_date(series[[1]], series[[2]]),
    value = series[[3]]
  )
}
