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
  it("First waypoint of each route", {
    expected <- c(232, 236, 240, 248)
    first_index_of_routes <- obtain_first_index_of_routes(cameras)
    expect_equal(first_index_of_routes[1:4], expected)
  })
})
