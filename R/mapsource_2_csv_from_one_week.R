copy_trap_status <- function(traps_without_status, traps_status) {
  aux <- join_traps_status(traps_without_status, traps_status)
  aux[,4:10] <- aux[,14]
  traps_with_status <- aux |>
    select(1:3,13,4:12)
  return(traps_with_status)
}

join_traps_status <- function(traps_without_status, traps_status) {
  traps_without_status |>
    select(-Nombre_del_responsable) |>
    left_join(traps_status, by="ID")
}