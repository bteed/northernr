library(tidyverse)
library(httr)
library(rvest)

extract_matrix_title <- function(x) {
  map_chr(as.character(x), str_extract, pattern = "(?<=>)[^<>]+")
}

extract_matrix_id <- function(x) {
  x %>%
    html_nodes("a") %>%
    html_text()
}

extract_group_name

content_resp <-
  read_html("https://www.statsnwt.ca/TSR/MatrixGroup.php") %>%
  html_nodes(".mat")

groups_resp <-
  read_html("https://www.statsnwt.ca/TSR/MatrixDirectory.html") %>%
  html_nodes("#directory")
