#' @importFrom stringr str_sub

#' @export
obtain_date_of_name_file <- function(file_ig_pt) {
  name_date <- file_ig_pt |> stringr::str_sub(21, 29)
  return(.change_name_date_2_char_date(name_date))
}

.change_name_date_2_char_date <- function(name_date) {
  day <- name_date |> stringr::str_sub(1, 2)
  mes <- name_date |> stringr::str_sub(3, 5)
  month <- MES_2_NUMBER_MONTH[[mes]]
  year <- name_date |> stringr::str_sub(6, 9)
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
  tryCatch(
    {
      active_and_inactive_traps <- rows_update(inactive_traps, clean_activated_traps)
      return(active_and_inactive_traps)
    },
    error = function(e) {
      stop("Los IDs no coinciden en IG_POSICION y en el mapsource")
    }
  )
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
