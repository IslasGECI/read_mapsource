#' @importFrom stringr str_sub

obtain_date_of_name_file <- function(file_ig_pt) {
  day <- file_ig_pt |> stringr::str_sub(20, 21)
  mes <- file_ig_pt |> stringr::str_sub(22, 24)
  month <- MES_2_NUMBER_MONTH[[mes]]
  year <- file_ig_pt |> stringr::str_sub(25, 28)
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

filter_na_from_Nombre_del_responsable <- function(posicion_trampa) {
  posicion_trampa |>
    filter(!is.na(Nombre_del_responsable))
}

select_first_columns <- function(posicion_trampa) {
  posicion_trampa |>
    select(c(1:3))
}

add_is_active_column <- function(posicion_trampa) {
  posicion_trampa |>
    add_column("is_active" = TRUE)
}

add_revised_date <- function(posicion_trampa, revised_date) {
  posicion_trampa |>
    add_column("date" = revised_date)
}