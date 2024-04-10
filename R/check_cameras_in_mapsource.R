check_cameras_in_mapsource <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  stop("🚨 Error en los IDs 🚨")
}

are_all_in_mapsource <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  all(cameras_in_revision_campo[["ID_camara"]] %in% cameras_in_mapsource[["Name"]])
}
