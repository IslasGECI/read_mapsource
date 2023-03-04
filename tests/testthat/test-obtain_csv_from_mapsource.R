library(tidyverse)

describe("Obtain the csv of cameras from mapsource", {
  waypoints <- read_csv("/workdir/tests/data/example_waypoints_from_mapsource.csv", show_col_types = FALSE)
  obtained <- obtain_csv_from_waypoints_of_mapsource(waypoints)
  it("From waypoints example", {
    expect_equal(obtained$Zona, rep("01", 10))
  })
  it("Has the right positions", {
    expect_true(obtained$Coordenada_Este[1] == 375311)
    expect_true(obtained$Coordenada_Norte[1] == 3196733)
  })
})
