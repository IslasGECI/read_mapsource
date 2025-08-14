#' @export
check_cameras <- function(revision_campo_path, mapsource_path) {
  mapsource_cameras <- read_listed_cameras_from_mapsource(mapsource_path)
  revision_campo <- readr::read_csv(revision_campo_path, show_col_types = FALSE)
  installed_cameras <- extract_installed_cameras(mapsource_cameras)
  double_check(revision_campo, installed_cameras)
}
#' @export
check_traps <- function(position_path, mapsource_path) {
  mapsource_traps <- read_listed_cameras_from_mapsource(mapsource_path) |> mutate(ID = Name)
  position_traps <- readxl::read_xlsx(position_path)
  double_check_traps(mapsource_traps, position_traps)
}
