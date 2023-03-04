#' @import dplyr

#' @export
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

month.nombres <- c("ENE", "FEB", "MAR", "ABR", "MAY", "JUN", "JUL", "AGO", "SEP", "OCT", "NOV", "DIC")

#' @export
obtain_date_to_title <- function(today) {
  sunday <- next_sunday(today)
  date_to_title <- glue::glue("{day_to_title(sunday)}{month.nombres[month(sunday)]}{year(sunday)}")
}

next_sunday <- function(today) {
  delta_day <- 8 - wday(today)
  sunday <- today + delta_day
  return(sunday)
}

day_to_title <- function(sunday) {
  n_day <- day(sunday)
  if (n_day < 10) {
    return(glue::glue("0{n_day}"))
  }
  return(n_day)
}

#' @export
MAPSOURCE_PATHS <- list(
  "camaras" = "/workdir/tests/data/ig_cameras.txt",
  "cepos" = "/workdir/tests/data/ig_traps.txt"
)

#' @export
OUTPUT_MAPSOURCE_PATHS <- list(
  "camaras" = "/workdir/data/IG_CAMARA_TRAMPA_EXTRA_{next_sunday}.csv",
  "cepos" = "/workdir/data/IG_POSICION_TRAMPA_{next_sunday}.csv"
)

#' @export
obtain_csv_from_traps_of_mapsource <- function(waypoints, wrote_day) {
  ig_traps <- waypoints |>
    filter_active_traps() |>
    add_traps_coordinates() |>
    select_right_columns_traps() |>
    add_other_columns_traps()
}

filter_active_traps <- function(waypoints) {
  waypoints |>
    filter(Symbol != "Scenic Area") |>
    filter(Symbol != "Flag, Red")
}

add_traps_coordinates <- function(waypoints) {
  modified <- waypoints |>
    separate(Position, c(NA, NA, "Coor-X", "Coor-Y")) |>
    mutate(`Coor-X` = as.numeric(`Coor-X`)) |>
    mutate(`Coor-Y` = as.numeric(`Coor-Y`))
}

select_right_columns_traps <- function(waypoints) {
  modified <- waypoints |>
    select(c(ID = 2, 5, 6))
}

add_other_columns_traps <- function(waypoints) {
  waypoints |>
    add_column(
      Nombre_del_responsable = NA,
      "27/Jun/2022" = NA,
      "28/Jun/2022" = NA,
      "29/Jun/2022" = NA,
      "30/Jun/2022" = NA,
      "01/Jun/2022" = NA,
      "02/Jun/2022" = NA,
      "03/Jun/2022" = NA,
      Linea = NA,
      Notas = NA
    )
}
