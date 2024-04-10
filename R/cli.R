#' @export
check_cameras <- function(revision_campo_path, mapsource_path) {
  mapsource_cameras <- read_listed_cameras_from_mapsource(mapsource_path)
  revision_campo <- readr::read_csv(revision_campo_path, show_col_types = FALSE)
  installed_cameras <- extract_installed_cameras(mapsource_cameras)
  double_check(revision_campo, installed_cameras)
}
