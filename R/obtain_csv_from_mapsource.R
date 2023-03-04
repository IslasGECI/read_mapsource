obtain_csv_from_waypoints_of_mapsource <- function(waypoints) {
  ig_cameras <- waypoints |>
    filter_active_cameras() |>
    add_zone_column() |>
    add_coordinates() |>
    select_right_columns() |>
    add_other_columns()
  return(ig_cameras)
}

filter_active_cameras <- function(waypoints) {
  waypoints |>
    filter(Symbol != "Flag, Red")
}

add_zone_column <- function(waypoints) {
  modified <- waypoints |> separate(Name, c(NA, "Zona", NA, NA), remove = FALSE)
}

add_coordinates <- function(waypoints) {
  modified <- waypoints |>
    separate(Position, c(NA, NA, "Coordenada_Este", "Coordenada_Norte")) |>
    mutate(Coordenada_Este = as.numeric(Coordenada_Este)) |>
    mutate(Coordenada_Norte = as.numeric(Coordenada_Norte))
}

select_right_columns <- function(waypoints) {
  modified <- waypoints |>
    select(c(ID_camara = 2, 3, 6, 7))
}

add_other_columns <- function(waypoints) {
  waypoints |>
    add_column(
      Fecha_revision = NA,
      Responsable = NA,
      Revision = NA,
      Estado_camara = NA,
      Estado_memoria = NA,
      Porcentaje_bateria = NA,
      Observaciones = NA
    )
}
