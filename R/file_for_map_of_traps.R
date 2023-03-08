#' @importFrom stringr str_sub

#' @export
obtain_date_of_name_file <- function(file_ig_pt) {
  day <- file_ig_pt |> stringr::str_sub(21, 22)
  mes <- file_ig_pt |> stringr::str_sub(23, 25)
  month <- MES_2_NUMBER_MONTH[[mes]]
  year <- file_ig_pt |> stringr::str_sub(26, 29)
  return(glue::glue("{day}-{month}-{year}"))
}

MES_2_NUMBER_MONTH <- list(
  "ENE" = "01",
  "FEB" = "02",
  "MAR" = "03",
  "ABR" = "04",
  "MAY" = "05",
  "JUN" = "06",
  "JUL" = "07",
  "AGO" = "08",
  "SEP" = "09",
  "OCT" = "10",
  "NOV" = "11",
  "DIC" = "12"
)

transform_from_ig_position_2_maps_of_traps <- function(posicion_trampa, revised_date) {
  posicion_trampa |>
    filter_na_from_Nombre_del_responsable() |>
    select_first_columns() |>
    add_is_active_column() |>
    add_revised_date(revised_date)
}

#' @export
obtain_inactive_traps_from_clean_position_traps <- function(posicion_trampa) {
  posicion_trampa |>
    select_first_columns() |>
    add_is_active_column(FALSE) |>
    add_revised_date()
}

update_activated_traps <- function(inactive_traps, activated_traps) {
  clean_activated_traps <- activated_traps |>
    select(c("ID", "is_active", "date"))
  active_and_inactive_traps <- inactive_traps |>
    rows_update(clean_activated_traps)
  return(active_and_inactive_traps)
}

filter_na_from_Nombre_del_responsable <- function(posicion_trampa) {
  posicion_trampa |>
    filter(!is.na(Nombre_del_responsable))
}

select_first_columns <- function(posicion_trampa) {
  posicion_trampa |>
    select(c(1:3, "line" = Linea))
}

add_is_active_column <- function(posicion_trampa, value = TRUE) {
  posicion_trampa |>
    add_column("is_active" = value)
}

add_revised_date <- function(posicion_trampa, revised_date = "") {
  posicion_trampa |>
    add_column("date" = revised_date)
}
