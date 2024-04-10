check_cameras_in_mapsource <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  if (are_all_in_mapsource(cameras_in_revision_campo, cameras_in_mapsource)) {
    message("💚 Todas las cámaras están en el mapsource 💚")
    return()
  }
  missing_ids <- get_missing_ids_in_mapsource(cameras_in_revision_campo, cameras_in_mapsource)
  messages <- "🚨 Los IDs CT-99-100-XX en IG_CAMARAS no están en el mapsource 🚨"
  stop(messages)
}

get_missing_ids_in_mapsource <- function(cameras_in_revision_campo, listed_cameras_in_mapsource) {
  setdiff(cameras_in_revision_campo[["ID_camara"]], listed_cameras_in_mapsource[["Name"]])
}

are_all_in_mapsource <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  all(cameras_in_revision_campo[["ID_camara"]] %in% cameras_in_mapsource[["Name"]])
}
