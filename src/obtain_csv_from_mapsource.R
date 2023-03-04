library(tidyverse)
library(lubridate)
library(readMS)

cameras_path <- read_ms("/workdir/tests/data/ig_cameras.txt")
next_sunday <- obtain_date_to_title(today())
output_file <- glue::glue("/workdir/data/IG_CAMARA_TRAMPA_EXTRA_{next_sunday}.csv")
obtain_just_waypoints(cameras_path) |>
  obtain_csv_from_waypoints_of_mapsource() |>
  write_csv(output_file)
