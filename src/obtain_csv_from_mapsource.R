library(tidyverse)
library(lubridate)
library(readMS)
type_of_traps <- "cepos"
cameras_path <- read_ms(MAPSOURCE_PATHS[[type_of_traps]])
next_sunday <- obtain_date_to_title(today())
output_file <- glue::glue(OUTPUT_MAPSOURCE_PATHS[[type_of_traps]])
obtain_just_waypoints(cameras_path) |>
  obtain_csv_from_waypoints_of_mapsource() |>
  write_csv(output_file)
