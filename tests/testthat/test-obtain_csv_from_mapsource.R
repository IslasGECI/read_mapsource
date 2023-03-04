library(tidyverse)

describe("Obtain the csv of cameras from mapsource", {
  it("From waypoints example", {
    waypoints <- read_csv("/workdir/tests/data/example_waypoints_from_mapsource.csv", show_col_types = FALSE)
    obtained <- obtain_csv_from_waypoints_of_mapsource(waypoints)
  })
})