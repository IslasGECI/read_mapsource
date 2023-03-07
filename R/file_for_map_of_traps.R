#' @importFrom stringr str_sub

obtain_date_of_name_file <- function(file_ig_pt) {
  day <- file_ig_pt |> stringr::str_sub(20,21)
  month <- file_ig_pt |> stringr::str_sub(22,24)
  year <- file_ig_pt |> stringr::str_sub(25,28)
  return(glue::glue("{day}-{month}-{year}"))
}