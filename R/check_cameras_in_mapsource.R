check_cameras_in_mapsource <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  if (are_id_sets_equal(cameras_in_revision_campo, cameras_in_mapsource)) {
    message("💚 Todas las cámaras están en el mapsource 💚")
    return()
  }
  messages <- .write_missing_id_in_mapsource_message(cameras_in_revision_campo, cameras_in_mapsource)
  stop(messages)
}

.write_missing_id_in_mapsource_message <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  missing_ids <- get_missing_ids_in_mapsource(cameras_in_revision_campo, cameras_in_mapsource)
  different_ids <- glue::glue_collapse(missing_ids, ", ", last = " y ")
  glue::glue("🚨 Los IDs {different_ids} en IG_CAMARAS no están en el mapsource 🚨")
}

get_missing_ids_in_mapsource <- function(cameras_in_revision_campo, listed_cameras_in_mapsource) {
  setdiff(cameras_in_revision_campo[["ID_camara"]], listed_cameras_in_mapsource[["Name"]])
}

get_missing_ids_in_revision_campo <- function(cameras_in_revision_campo, listed_cameras_in_mapsource) {
  setdiff(listed_cameras_in_mapsource[["Name"]], cameras_in_revision_campo[["ID_camara"]])
}

are_id_sets_equal <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  setequal(cameras_in_revision_campo[["ID_camara"]], cameras_in_mapsource[["Name"]])
}
