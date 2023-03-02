describe("Read a mapsource file", {
  it("Read as tsv", {
    read_ms("/workdir/tests/data/ig_traps.txt")
  })
})

describe("Obtaine rows with Route", {
  it("Number of lines", {
    cameras <- read_ms("/workdir/tests/data/ig_cameras.txt")
    rows_of_route <- obtain_index_of_route_rows(cameras)
    expected <- 40
    obtained <- length(rows_of_route)
    expect_equal(obtained, expected)
  })
})

describe("Obtaine number of points for each route", {
  it("First four elements", {
    cameras <- read_ms("/workdir/tests/data/ig_cameras.txt")
    number_of_points <- obtaine_number_of_points_of_each_routes(cameras)
    expected <- c(2, 2, 6, 3)
    expect_equal(number_of_points[1:4], expected)
  })
})

describe("Obtaine dataframe with all waypoints", {
  it("Waypoints of cameras", {
    expected_last_id <- "CT-07-011-LM"
    waypoints <- obtaine_just_waypoints(cameras)
    obtained_last_id <- waypoints |>
      slide(n()) %>%
      .$Name
    expect_equal(obtained_last_id, expected_last_id)
  })
})
