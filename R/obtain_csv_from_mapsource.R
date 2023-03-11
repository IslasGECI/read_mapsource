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

month.NOMBRES <- c("ENE", "FEB", "MAR", "ABR", "MAY", "JUN", "JUL", "AGO", "SEP", "OCT", "NOV", "DIC")

#' @export
obtain_date_to_title <- function(today, weeks = 2) {
  sunday <- next_sunday(today, weeks)
  date_to_title <- glue::glue("{day_to_title(sunday)}{month.NOMBRES[month(sunday)]}{year(sunday)}")
}

next_sunday <- function(today, weeks = 2) {
  delta_day <- 1 + 7 * weeks - wday(today)
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
  "cepos" = "/workdir/data/IG_POSICION_TRAMPAS_{next_sunday}.csv"
)

#' @export
obtain_csv_from_traps_of_mapsource <- function(waypoints, wrote_day) {
  ig_traps <- waypoints |>
    filter_active_traps() |>
    add_traps_coordinates() |>
    select_right_columns_traps() |>
    add_other_columns_traps(wrote_day)
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

add_other_columns_traps <- function(waypoints, wrote_day) {
  add_other_columns_traps_by_weeks(waypoints, wrote_day, weeks = 2)
}

add_other_columns_traps_one_week <- function(waypoints, wrote_day) {
  add_other_columns_traps_by_weeks(waypoints, wrote_day, weeks = 1)
}

add_other_columns_traps_by_weeks <- function(waypoints, wrote_day, weeks) {
  all_week <- obtain_date_columns(wrote_day, weeks)
  day_1 <- change_date_to_column_name(all_week[1])
  waypoints |>
    add_column(
      Nombre_del_responsable = NA,
      !!change_date_to_column_name(all_week[1]) := NA,
      !!change_date_to_column_name(all_week[2]) := NA,
      !!change_date_to_column_name(all_week[3]) := NA,
      !!change_date_to_column_name(all_week[4]) := NA,
      !!change_date_to_column_name(all_week[5]) := NA,
      !!change_date_to_column_name(all_week[6]) := NA,
      !!change_date_to_column_name(all_week[7]) := NA,
      Linea = NA,
      Notas = NA
    )
}

obtain_date_columns <- function(today, weeks = 2) {
  sunday <- next_sunday(today, weeks)
  all_week <- sunday - c(6, 5, 4, 3, 2, 1, 0)
}

month.Nombres <- c("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic")

change_date_to_column_name <- function(a_day) {
  glue::glue("{day_to_title(a_day)}/{month.Nombres[month(a_day)]}/{year(a_day)}")
}
