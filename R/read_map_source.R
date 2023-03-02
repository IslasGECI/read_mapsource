read_ms <- function(path) {
  return(readr::read_tsv(path, skip = 3, show_col_types = FALSE))
}

obtain_index_of_route_rows <- function(waypoints) {
  return(which(waypoints$Header == "Route"))
}

obtaine_number_of_points_of_each_routes <- function(waypoints) {
  index <- obtain_index_of_route_rows(waypoints)
  n_points <- waypoints[index, ] |>
    tidyr::separate(Position, c("n_points", NA)) %>%
    .$n_points |>
    as.numeric()
  return(n_points)
}
