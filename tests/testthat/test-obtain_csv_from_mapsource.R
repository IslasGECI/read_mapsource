library(tidyverse)
library(lubridate)

describe("Obtain the csv of cameras from mapsource", {
  waypoints <- read_csv("/workdir/tests/data/example_waypoints_from_mapsource.csv", show_col_types = FALSE)
  obtained <- obtain_csv_from_waypoints_of_mapsource(waypoints)
  it("From waypoints example", {
    expect_equal(obtained$Zona, rep("01", 6))
  })
  it("Has the right positions", {
    expect_true(obtained$Coordenada_Este[1] == 375311)
    expect_true(obtained$Coordenada_Norte[1] == 3196733)
    expect_true(obtained$Coordenada_Este[6] == 375236)
    expect_true(obtained$Coordenada_Norte[6] == 3200753)
  })
  it("Has the right columns", {
    ig_cameras <- read_csv("/workdir/tests/data/IG_CAMARA_TRAMPA_EXTRA_26FEB2023.csv", show_col_types = FALSE)
    expected_name <- names(ig_cameras)
    obtained_name <- names(obtained)
    expect_equal(obtained_name, expected_name)
  })
})

describe("Next sunday", {
  it("From '2023-03-04' the final presentation", {
    today <- ymd("2023-03-04")
    expected <- "12MAR2023"
    expect_equal(obtain_date_to_title(today), expected)
  })
  it("From '2023-03-04' the type date", {
    today <- ymd("2023-03-04")
    expected <- ymd("2023-03-12")
    expect_equal(next_sunday(today), expected)
  })
  it("day to title", {
    expected <- "05"
    sunday <- ymd("2023-03-05")
    obtained <- day_to_title(sunday)
    expect_equal(obtained, expected)
  })
})

describe("paths io", {
  it("inputs", {
    expected <- "/workdir/tests/data/ig_cameras.txt"
    obtained <- MAPSOURCE_PATHS[["camaras"]]
    expect_equal(obtained, expected)
    expected <- "/workdir/tests/data/ig_traps.txt"
    obtained <- MAPSOURCE_PATHS[["cepos"]]
    expect_equal(obtained, expected)
  })
  it("outputs", {
    expected <- "/workdir/data/IG_CAMARA_TRAMPA_EXTRA_{next_sunday}.csv"
    obtained <- OUTPUT_MAPSOURCE_PATHS[["camaras"]]
    expect_equal(obtained, expected)
    expected <- "/workdir/data/IG_POSICION_TRAMPA_{next_sunday}.csv"
    obtained <- OUTPUT_MAPSOURCE_PATHS[["cepos"]]
    expect_equal(obtained, expected)
  })
})

describe("Get csv of POSICION TRAMPA", {
  waypoints <- read_csv("/workdir/tests/data/example_traps_from_mapsource.csv", show_col_types = FALSE)
  today <- ymd("2023-03-04")
  obtained <- obtain_csv_from_traps_of_mapsource(waypoints, today)
  it("has the right coordinates", {
    expect_true(obtained$`Coor-X`[1] == 376963)
    expect_true(obtained$`Coor-Y`[1] == 3208022)
    expect_true(obtained$`Coor-X`[10] == 375153)
    expect_true(obtained$`Coor-Y`[10] == 3196529)
  })
  it("Has the right columns", {
    ig_traps <- read_csv("/workdir/tests/data/IG_POSICION_TRAMPAS_03JUL2022.csv", show_col_types = FALSE)
    expected_name <- c("06/Mar/2023", "07/Mar/2023", "08/Mar/2023", "09/Mar/2023", "10/Mar/2023", "11/Mar/2023", "12/Mar/2023")
    obtained_name <- names(obtained)
    expect_equal(obtained_name[5:11], expected_name)
  })
  it("obtain the right date columns", {
    expected_name <- c("06/Mar/2023", "07/Mar/2023", "08/Mar/2023", "09/Mar/2023", "10/Mar/2023", "11/Mar/2023", "12/Mar/2023")
    obtained_name <- obtain_date_columns(today)
    expect_equal(change_date_to_column_name(obtained_name[1]), expected_name[1])
    expect_equal(change_date_to_column_name(obtained_name[7]), expected_name[7])
  })
})
