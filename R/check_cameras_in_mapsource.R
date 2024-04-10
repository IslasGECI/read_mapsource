check_cameras_in_mapsource <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  if (are_all_in_mapsource(cameras_in_revision_campo, cameras_in_mapsource)) {
    message("💚 Todas las cámaras están en el mapsource 💚")
    return()
  }
  stop("🚨 Error en los IDs 🚨")
}

are_all_in_mapsource <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  all(cameras_in_revision_campo[["ID_camara"]] %in% cameras_in_mapsource[["Name"]])
}
