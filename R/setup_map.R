#' @export
remove_duplicated_id <- function(activated_or_inactivated_traps) {
  is_duplicated_id <- activated_or_inactivated_traps$ID |>
    duplicated()
  return(activated_or_inactivated_traps[!is_duplicated_id, ])
}

obtain_activated_traps_from_ig_posicion_path <- function(ig_posicion_path) {
  date_of_name_file <- "10-03-2023"
  activated_traps <- read_csv(
    ig_posicion_path,
    show_col_types = FALSE,
    col_types = "ciicccccccccc"
  ) |>
    transform_from_ig_position_2_maps_of_traps(date_of_name_file)
  return(activated_traps)
}