library(tidyverse)
library(httr)
library(rvest)

### Matrix data ###

matrix_id_list <- function() {
  read_html("https://www.statsnwt.ca/TSR/MatrixGroup.php") %>%
    html_nodes(".mat") %>%
    html_node("a") %>%
    html_text()
}

metadata_from_matrix <- function(id) {
  read_html(paste("https://www.statsnwt.ca/TSR/Matrix.php?matrixid=",id, sep = "")) %>%
    html_node("#series-info")
}

name_of_matrix <- function(response) {
  response %>%
    html_node("h4") %>%
    html_text()
}

series_in_matrix <- function(response) {
  response %>%
    html_nodes("#vseries a") %>%
    html_text()
}

### Series data ###

metadata_from_series <- function(series_id) {
  read_html(paste("https://www.statsnwt.ca/TSR/series.php?seriesid=",series_id, sep = "")) %>%
    html_node("#series-info")
}

name_of_series <- function(response) {
  response %>%
    html_node("#series-title") %>%
    html_text() %>%
    str_remove("^[:alpha:]+[:digit:]+ - ")
}

measurement_of_series <- function(response) {
  response %>%
    html_text() %>%
    str_extract("(?<=in:).+") %>%
    str_trim()
}

### Actually collect the data ###

matrix_data <- function(matrix_id) {
  mtx <- metadata_from_matrix(matrix_id)
  s <- series_in_matrix(mtx)
  n <- name_of_matrix(mtx)

  mtx_list <-
    list(
      matrix_id = rep_len(matrix_id, length(s)),
      matrix_name = rep_len(n, length(s)),
      series_id = s
    ) %>%
    transpose()

  map_dfr(
    mtx_list,
    function(x) {
      s <- metadata_from_series(x[["series_id"]])
      list(
        matrix_id = x[["matrix_id"]],
        matrix_name = x[["matrix_name"]],
        series_id = x[["series_id"]],
        series_name = name_of_series(s),
        measurement = measurement_of_series(s)
      )
    }
  ) %>%
    mutate(
      matrix_id = na_if(matrix_id, ""),
      matrix_name = na_if(matrix_name, "")
    )
}

series_metadata <-
  map_dfr(
  c(matrix_id_list(),""),
  matrix_data)

series_metadata <-
  series_metadata %>%
  arrange(matrix_id, series_id)

usethis::use_data(series_metadata)
