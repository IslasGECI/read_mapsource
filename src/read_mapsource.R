library(tidyverse)
library(readMS)

cameras <- read_ms("/workdir/tests/data/ig_cameras.txt")
waypoints <- obtain_just_waypoints(cameras)

wp_csv <- read_csv("/workdir/tests/data/IG_CAMARA_TRAMPA_EXTRA_26FEB2023.csv", show_col_types = FALSE)

not_in_exel <- !(waypoints$Name %in% wp_csv$ID_camara)

to_check_position <- waypoints |>
  separate(Position, c(NA, NA, "Este", "Norte")) |>
  mutate(Este = as.numeric(Este), Norte = as.numeric(Norte)) |>
  select(Name, Este, Norte)

positions <- wp_csv |>
  select(c(1,3,4)) |>
  left_join(to_check_position, by = c("ID_camara"="Name")) |>
  mutate(is_incorrect = !((Coordenada_Este == Este) & (Coordenada_Norte == Norte)))

positions |>
  filter(is_incorrect == TRUE) |>
  select(c(1, 2, 4, 3, 5)) |>
  write_csv("points_with_coordinates_that_do_not_coincide.csv")