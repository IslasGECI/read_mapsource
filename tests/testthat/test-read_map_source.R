library(tidyverse)
describe("Read a mapsource file", {
  it("Read as tsv", {
    read_ms("/workdir/tests/data/ig_traps.txt")
  })
})

describe("Obtaine rows with Route", {
  cameras <- read_ms("/workdir/tests/data/ig_cameras.txt")
  it("Number of lines", {
    rows_of_route <- obtain_index_of_route_rows(cameras)
    expected <- 40
    obtained <- length(rows_of_route)
    expect_equal(obtained, expected)
  })
  it("First four elements", {
    number_of_points <- obtaine_number_of_points_of_each_routes(cameras)
    expected <- c(2, 2, 6, 3)
    expect_equal(number_of_points[1:4], expected)
  })
  it("Names of routes", {
    expected_names <- c("Arroyo 1", "Arroyo 2", "Camino Playa Norte", "Costa Oeste")
    obtained_names <- obtain_names_of_routes(cameras)
    expect_equal(obtained_names[1:4], expected_names)
  })
})

describe("Obtaine dataframe with all waypoints", {
  cameras <- read_ms("/workdir/tests/data/ig_cameras.txt")
  waypoints <- obtain_just_waypoints(cameras)
  it("the last waypoints of cameras", {
    expected_last_id <- "CT-07-011-LM"
    obtained_last_id <- waypoints |>
      dplyr::slice(n()) %>%
      .$Name
    expect_equal(obtained_last_id, expected_last_id)
  })
  it("The first waypoint of camera", {
    first_id <- "CA-01-001-CA"
    obtained_first_id <- waypoints |>
      dplyr::slice(1) %>%
      .$Name
    expect_equal(obtained_first_id, first_id)
  })
})

describe("Obtain all routes", {
  cameras <- read_ms("/workdir/tests/data/ig_cameras.txt")
  it("First waypoint of each route", {
    expected <- c(232, 236, 240, 248)
    first_index_of_routes <- obtain_first_index_of_routes(cameras)
    expect_equal(first_index_of_routes[1:4], expected)
  })
  it("Obtain route 'Camino Playa Norte'", {
    playa_norte <- tibble::tibble(
      Header = rep("Route Waypoint", 6),
      "Waypoint Name" = c("CT-07-004-KS", "CT-07-007-KS", "CT-07-006-KS", "CT-07-005-KS", "CT-07-010-LM", "CT-07-011-LM"),
      Distance = c("0 m", "1.4 km", "1.9 km", "3.4 km", "4.0 km", "4.5 km"),
      "Leg Length" = c(NA, "1.4 km", "538 m", "1.5 km", "548 m", "534 m")
    )
    obtained_route <- pluck_route(cameras, 3)
    expect_equal(obtained_route, playa_norte)
  })
  it("Obtain route 'Linea 1 oeste'", {
    oeste <- tibble::tibble(
      Header = rep("Route Waypoint", 6),
      "Waypoint Name" = c("CT-04-020-NN", "CT-04-021-NN", "CT-04-022-NN", "CT-04-019-AA", "CT-04-018-AA", "CT-04-017-AA"),
      Distance = c("0 m", "272 m", "561 m", "901 m", "1.2 km", "1.5 km"),
      "Leg Length" = c(NA, "272 m", "289 m", "340 m", "316 m", "246 m")
    )
    n_route <- 6
    obtained_names <- obtain_names_of_routes(cameras)
    expect_equal(obtained_names[n_route], "Linea 1 oeste")
    obtained_route <- pluck_route(cameras, n_route)
    expect_equal(obtained_route, oeste)
  })
})

describe("Add route name to waypoints", {
  cameras <- read_ms("/workdir/tests/data/ig_cameras.txt")
  it("add columna 'line = Linea 1 oeste'", {
    oeste <- tibble::tibble(
      Header = rep("Route Waypoint", 6),
      "Waypoint Name" = c("CT-04-020-NN", "CT-04-021-NN", "CT-04-022-NN", "CT-04-019-AA", "CT-04-018-AA", "CT-04-017-AA"),
      Distance = c("0 m", "272 m", "561 m", "901 m", "1.2 km", "1.5 km"),
      "Leg Length" = c(NA, "272 m", "289 m", "340 m", "316 m", "246 m"),
      linea = "Linea 1 oeste"
    )
    n_route <- 6
    obtained <- obtain_points_of_routes_by_number_of_route(cameras, n_route)
    expect_equal(obtained, oeste)
  })
  it("select two columns with the right names", {
    expected <- tibble::tibble(
      "ID" = c("CT-04-020-NN", "CT-04-021-NN", "CT-04-022-NN", "CT-04-019-AA", "CT-04-018-AA", "CT-04-017-AA"),
      Linea = "Linea 1 oeste"
    )
    points_with_route_names <- tibble::tibble(
      Header = rep("Route Waypoint", 6),
      "Waypoint Name" = c("CT-04-020-NN", "CT-04-021-NN", "CT-04-022-NN", "CT-04-019-AA", "CT-04-018-AA", "CT-04-017-AA"),
      Distance = c("0 m", "272 m", "561 m", "901 m", "1.2 km", "1.5 km"),
      "Leg Length" = c(NA, "272 m", "289 m", "340 m", "316 m", "246 m"),
      linea = "Linea 1 oeste"
    )
    obtained <- select_ID_and_linea(points_with_route_names)
    expect_equal(obtained, expected)
  })
})

describe("`obtain_traps_with_routes()`", {
  cameras <- read_ms("/workdir/tests/data/ig_cameras.txt")
  expected <- read_csv("/workdir/tests/data/outup_obtain_traps_with_routes.csv", show_col_types = FALSE)
  obtained <- obtain_traps_with_routes(cameras)
})
