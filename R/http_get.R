#' HTTP GET request to TSR
#'
#' @param series Valid TSR series id as string (or string vector if multiple)
#' @param start_year Optional start year. Defaults to NULL, which returns series
#'   from beginning
#'
#' @return
#' @export
#'
#' @examples
nrnr_http_get <-
  function(series_id, start_year = NULL) {
    if (length(series_id) > 1) {
      stop("nrnr_http_get only takes one series_id at a time.")
    }
    url <-
      paste0(
        "https://www.statsnwt.ca/TSR/Series_Download.php?seriesid=",
        series_id,
        "&startyear=",
        start_year
      )

    response <- try(httr::GET(url), silent = T)

    if (class(response) == "try-error" || httr::status_code(response) != 200) {
      stop(paste("Oh goodness, there was a problem connecting to", url))
    }

    else if (httr::http_type(response) != "application/vnd.ms-excel") {
      stop(paste("Hmm... we connected to",
                 url,
                 "but didn't get what we expected."))
    }

    httr::content(response, as = "text", encoding = "UTF-8")
  }
