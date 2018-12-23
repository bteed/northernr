library(tidyverse)
library(ggmap)

register_google(key="xxx")

series_names <-
  series_metadata %>%
  filter(!is.na(matrix_id)) %>%
  select(series_name) %>%
  distinct() %>%
  pull()

PT_lonlat <-
  series_names[1:14] %>%
  map_dfr(function(x) {
    geo_x <- geocode(x)
    list(
      geo_name = x,
      lon = geo_x$lon,
      lat = geo_x$lat
    )
  })

NWT_community_lonlat <-
  series_names[56:88] %>%
  map_dfr(function(x) {
    geo_x <- geocode(paste(x,"NWT"))
    list(
      geo_name = x,
      lon = geo_x$lon,
      lat = geo_x$lat
    )
  })

usethis::use_data(PT_lonlat, NWT_community_lonlat, overwrite = T)
