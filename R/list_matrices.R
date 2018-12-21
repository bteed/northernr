#' List Available StatsNWT Matrices
#'
#' @return A dataframe of the indices and names of known matrices
#' @export
#'
#' @examples
nrnr_list_matrices <- function() {
  unique(series_metadata[!is.na(series_metadata$matrix_id),1:2])
}
