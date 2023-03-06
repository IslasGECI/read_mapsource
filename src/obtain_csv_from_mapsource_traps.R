library(tidyverse)
library(lubridate)
library(readMS)
today <- ymd("2023-03-04")
type_of_traps <- "cepos"
cameras_path <- read_ms(MAPSOURCE_PATHS[[type_of_traps]])
traps_with_routes <- obtain_traps_with_routes(cameras_path)
next_sunday <- obtain_date_to_title(today)
output_file <- glue::glue(OUTPUT_MAPSOURCE_PATHS[[type_of_traps]])
obtain_csv_from_traps_of_mapsource(cameras_path, today) |>
  select(-12) |>
  left_join(traps_with_routes, by = "ID") |>
  write_csv(output_file)
