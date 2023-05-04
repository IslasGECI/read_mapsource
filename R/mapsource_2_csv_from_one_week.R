copy_trap_status <- function(traps_without_status, traps_status) {
  aux <- join_traps_status(traps_without_status, traps_status)
  traps_with_status <- add_traps_status(aux)
  return(traps_with_status)
}

join_traps_status <- function(traps_without_status, traps_status) {
  traps_without_status |>
    select(-Nombre_del_responsable) |>
    left_join(traps_status, by = "ID")
}

add_traps_status <- function(aux) {
  aux[, 4:10] <- aux[, 14]
  aux |>
    select(1:3, 13, 4:12)
}
