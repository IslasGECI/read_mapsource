obtain_csv_from_waypoints_of_mapsource <- function(waypoints) {
  ig_cameras <- waypoints |>
    add_zone_column() |>
    add_east_coordinate()
  return(ig_cameras)
}

add_zone_column <- function(waypoints) {
  modified <- waypoints |> separate(Name, c(NA, "Zona", NA, NA), remove = FALSE)
}

add_east_coordinate <- function(waypoints) {
  modified <- waypoints |> 
    separate(Position, c(NA, NA, "Coordenada_Este", NA)) |>
    mutate(Coordenada_Este = as.numeric(Coordenada_Este))
}
