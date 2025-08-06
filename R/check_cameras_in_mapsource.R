double_check <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  check_cameras_in_revision_campo(cameras_in_revision_campo, cameras_in_mapsource)
  check_cameras_in_mapsource(cameras_in_revision_campo, cameras_in_mapsource)
  message("💚 La revisión de cámaras es correcta 💚")
}

check_cameras_in_mapsource <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  missing_ids <- xxget_missing_ids_in_mapsource(cameras_in_revision_campo[["ID_camara"]], cameras_in_mapsource[["Name"]])
  if (length(missing_ids) > 0) {
    messages <- .write_missing_id_in_mapsource_message(cameras_in_revision_campo, cameras_in_mapsource)
    stop(messages)
  }
}

check_cameras_in_revision_campo <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  missing_ids <- get_missing_ids_in_revision_campo(cameras_in_revision_campo, cameras_in_mapsource)
  if (length(missing_ids) > 0) {
    messages <- .write_missing_id_in_revision_campo_message(cameras_in_revision_campo, cameras_in_mapsource)
    stop(messages)
  }
}

.write_missing_id_in_revision_campo_message <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  missing_ids <- get_missing_ids_in_revision_campo(cameras_in_revision_campo, cameras_in_mapsource)
  different_ids <- glue::glue_collapse(missing_ids, ", ", last = " y ")
  glue::glue("🚨 Los IDs {different_ids} en mapsource no están en el revision_campo 🚨")
}

.write_missing_id_in_mapsource_message <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  missing_ids <- get_missing_ids_in_mapsource(cameras_in_revision_campo, cameras_in_mapsource)
  different_ids <- glue::glue_collapse(missing_ids, ", ", last = " y ")
  glue::glue("🚨 Los IDs {different_ids} en IG_CAMARAS no están en el mapsource 🚨")
}

get_missing_ids_in_mapsource <- function(cameras_in_revision_campo, listed_cameras_in_mapsource) {
  xxget_missing_ids_in_mapsource(cameras_in_revision_campo[["ID_camara"]], listed_cameras_in_mapsource[["Name"]])
}
xxget_missing_ids_in_mapsource <- function(cameras_ids, mapsource_ids) {
  setdiff(cameras_ids, mapsource_ids)
}

get_missing_ids_in_revision_campo <- function(cameras_in_revision_campo, listed_cameras_in_mapsource) {
  setdiff(listed_cameras_in_mapsource[["Name"]], cameras_in_revision_campo[["ID_camara"]])
}
