#' @importFrom magrittr %>%

#' @export
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

#' @export
obtain_just_waypoints <- function(full_information) {
  index <- obtain_index_of_route_rows(full_information)
  last_index_of_waypoints <- index[1] - 2
  return(full_information[1:last_index_of_waypoints, ])
}

#' @export
obtain_names_of_routes <- function(full_information) {
  index <- obtain_index_of_route_rows(full_information)
  names_of_routes <- full_information[index, ] %>%
    .$Name
  return(names_of_routes)
}

obtain_first_index_of_routes <- function(full_information) {
  index <- obtain_index_of_route_rows(full_information)
  return(index + 2)
}

pluck_route <- function(full_information, n_route) {
  first_index_of_routes <- obtain_first_index_of_routes(full_information)
  first_index <- first_index_of_routes[n_route]
  number_of_points_of_each_routes <- obtaine_number_of_points_of_each_routes(full_information)
  last_index <- first_index + number_of_points_of_each_routes[n_route] - 1
  route <- full_information[first_index_of_routes[n_route]:last_index, 1:4]
  names(route) <- c("Header", "Waypoint Name", "Distance", "Leg Length")
  return(route)
}

obtain_points_of_routes_by_number_of_route <- function(full_information, n_route) {
  route_names <- obtain_names_of_routes(full_information)
  points_with_route_names <- pluck_route(full_information, n_route) |>
    add_column(linea = route_names[n_route])
  return(points_with_route_names)
}

select_ID_and_linea <- function(points_with_route_names) {
  points_with_route_names |>
    select(c("ID" = `Waypoint Name`, "Linea" = linea))
}

#' @export
obtain_traps_with_routes <- function(full_information) {
  traps_with_routes <- tibble::tibble()
  nombre_de_linea <- obtain_names_of_routes(full_information)
  for (i in 1:length(nombre_de_linea)) {
    traps_with_routes <- full_information |>
      obtain_points_of_routes_by_number_of_route(i) |>
      rbind(traps_with_routes)
  }
  traps_with_routes <- traps_with_routes |>
    select_ID_and_linea()
}

obtain_ig_posicion_mapsource_path <- function(root_path = "/workdir/data") {
  all_paths <- list.files(root_path)
  files <- comprehenr::to_vec(for (file in all_paths) if (str_detect(file, "IG_TRAMPAS")) file)
  paths <- comprehenr::to_vec(for (file in files) paste(root_path, file, sep = "/"))
  return(paths)
}

obtain_ig_posicion_csv_path <- function(ig_posicion_mapsource_path) {
  str_replace_all(ig_posicion_mapsource_path, c("_TRAMPAS" = "_POSICION_TRAMPAS", ".txt" = ".csv"))
}
