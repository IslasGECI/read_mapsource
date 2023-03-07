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

transform_from_ig_position_2_maps_of_traps <- function(posicion_trampa) {
  posicion_trampa
}
