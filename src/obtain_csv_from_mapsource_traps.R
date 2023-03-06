library(tidyverse)
library(lubridate)
library(readMS)
today <- ymd("2023-03-04")
type_of_traps <- "cepos"
cameras_path <- read_ms(MAPSOURCE_PATHS[[type_of_traps]])
traps_with_routes <- tibble::tibble()
nombre_de_linea <- obtain_names_of_routes(cameras_path)
for (i in 1:length(nombre_de_linea)) {
  traps_with_routes <- cameras_path |>
    pluck_route(i) |>
    add_column(linea = nombre_de_linea[i]) |>
    rbind(traps_with_routes)
}
traps_with_routes <- traps_with_routes |>
  select(c("ID"=2,"Linea" = linea))
next_sunday <- obtain_date_to_title(today())
output_file <- glue::glue(OUTPUT_MAPSOURCE_PATHS[[type_of_traps]])
obtain_csv_from_traps_of_mapsource(cameras_path, today) |>
  select(-12) |>
  left_join(traps_with_routes) |>
  write_csv(output_file)
