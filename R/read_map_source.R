read_ms <- function(path) {
  return(readr::read_tsv(path, skip = 3, show_col_types = FALSE))
}

obtain_index_of_route_rows <- function(waypoints) {
  return(which(waypoints$Header == "Route"))
}
