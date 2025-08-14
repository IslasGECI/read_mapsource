double_check <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  check_cameras_in_revision_campo(cameras_in_revision_campo, cameras_in_mapsource)
  check_cameras_in_mapsource(cameras_in_revision_campo, cameras_in_mapsource)
  message("💚 La revisión de cámaras es correcta 💚")
}

check_cameras_in_mapsource <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  missing_ids <- get_missing_ids(cameras_in_revision_campo[["ID_camara"]], cameras_in_mapsource[["Name"]])
  if (length(missing_ids) > 0) {
    messages <- .write_missing_id_in_mapsource_message(missing_ids)
    stop(messages)
  }
}

check_cameras_in_revision_campo <- function(cameras_in_revision_campo, cameras_in_mapsource) {
  missing_ids <- get_missing_ids(cameras_in_mapsource[["Name"]], cameras_in_revision_campo[["ID_camara"]])
  if (length(missing_ids) > 0) {
    messages <- .write_missing_id_in_revision_campo_message(missing_ids)
    stop(messages)
  }
}

.write_missing_id_in_revision_campo_message <- function(missing_ids) {
  different_ids <- glue::glue_collapse(missing_ids, ", ", last = " y ")
  glue::glue("🚨 Los IDs {different_ids} en mapsource no están en el revision_campo 🚨")
}

.write_missing_id_in_mapsource_message <- function(missing_ids) {
  different_ids <- glue::glue_collapse(missing_ids, ", ", last = " y ")
  glue::glue("🚨 Los IDs {different_ids} en CAMARAS no están en el MAPSOURCE 🚨")
}

get_missing_ids <- function(cameras_ids, mapsource_ids) {
  setdiff(cameras_ids, mapsource_ids)
}
