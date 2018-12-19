#' Get Data Series from StatsNWT Time Series Retrieval API
#'
#' @param series Valid TSR series id as string (or string vector if multiple)
#' @param start_year Optional start year. Defaults to NULL, which returns series
#'   from beginning
#'
#' @return
#' @export
#'
#' @examples
nrnr_get_series <- function(series_id, start_year = NULL) {
  valid_series <-
    ifelse(
      !(series_id %in%  series_metadata[["series_id"]]),
      series_id,
      "ok"
    )

  if(any(valid_series != "ok" )) {
    stop(
      paste(
        "Whoa there, big rig. I couldn't find",
        paste(valid_series[valid_series != "ok"], collapse = T)
      )
    )
  }

  series <-
    purrr::map_dfr(
    series_id,
    ~ nrnr_read_series(
        nrnr_http_get(.x, start_year),
        .x
      )
  )

  # response <- nrnr_http_get(series_id, start_year)
  # series <- nrnr_read_series(response, series_id)

  series_with_metadata <- merge(x = series_metadata, y = series)
  tibble::as_tibble(series_with_metadata[,c(2,3,1,4,5,6,7)])

}
