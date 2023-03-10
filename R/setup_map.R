#' @importFrom comprehenr to_vec

#' @export
remove_duplicated_id <- function(activated_or_inactivated_traps) {
  is_duplicated_id <- activated_or_inactivated_traps$ID |>
    duplicated()
  return(activated_or_inactivated_traps[!is_duplicated_id, ])
}

obtain_activated_traps_from_ig_posicion_path <- function(ig_posicion_path) {
  date_of_name_file <- obtain_date_from_full_path(ig_posicion_path)
  activated_traps <- read_csv(
    ig_posicion_path,
    show_col_types = FALSE,
    col_types = "ciicccccccccc"
  ) |>
    transform_from_ig_position_2_maps_of_traps(date_of_name_file)
  return(activated_traps)
}

obtain_date_from_full_path <- function(full_path) {
  file_name <- str_split(full_path, "/")[[1]] |>
    last()
  return(obtain_date_of_name_file(file_name))
}

files_ig_posicion_trampas <- function(root_path = "/workdir/data") {
  files_ig_posicion <- list.files(root_path, pattern = ".csv$")
  return(comprehenr::to_vec(for (file in files_ig_posicion) if (str_sub(file, 1, 7) == "IG_POSI") file))
}

obtain_char_date_from_mapsource_file <- function(file_path) {
  len_file <- str_length(file_path)
  name_date <- file_path |> str_sub(len_file - 12, len_file - 4)
  .change_name_date_2_char_date(name_date)
}
