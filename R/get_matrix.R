#' Get Matrix from StatsNWT Time Series Retrieval API
#'
#' @param series Valid TSR matrix id as string
#' @param start_year Optional start year. Defaults to NULL, which returns series
#'   from beginning
#'
#' @return
#' @export
#'
#' @examples
nrnr_get_matrix <- function(matrix_id, start_year = NULL) {
  if (!(matrix_id %in%  series_metadata[["matrix_id"]])) {
    stop(paste("Whoa there, big rig. I couldn't find", matrix_id))
  }

  matrix_metadata <-
    series_metadata[series_metadata$matrix_id == "TM060001"
                    & !is.na(series_metadata$matrix_id),]

  nrnr_get_series(matrix_metadata[["series_id"]], start_year)

}
