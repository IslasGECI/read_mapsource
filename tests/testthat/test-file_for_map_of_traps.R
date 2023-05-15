library(tidyverse)
describe("from_ig_position_2_maps_of_traps", {
  path <- "/workdir/tests/data/IG_POSICION_TRAMPAS_03JUL2022.csv"
  posicion_trampa <- read_csv(path, show_col_types = FALSE)
  revised_date <- "03-07-2022"
  obtained <- transform_from_ig_position_2_maps_of_traps(posicion_trampa, revised_date)
  it("select the three first columns of ig_position_trampa", {
    expected_names <- c("ID", "Coor-X", "Coor-Y")
    obtained_names <- names(obtained)[1:3]
    expect_equal(obtained_names, expected_names)
  })
  it("add the columns `is_active` with TRUE value", {
    all_are_active <- all(obtained$is_active[1])
    expect_equal(obtained$is_active[1], TRUE)
  })
  it("add the columns `date` with '03-07-2022' value", {
    expected_date <- "03-07-2022"
    all_have_right_date <- all(obtained$date == expected_date)
    expect_equal(obtained$date[1], expected_date)
    expect_true(all_have_right_date)
  })
})

describe("obtain_date_of_name_file", {
  it("returns '12-03-2023' from 'IG_POSICION_TRAMPA_12MAR2023.csv'", {
    files_ig_pt <- "IG_POSICION_TRAMPAS_12MAR2023.csv"
    obtained <- obtain_date_of_name_file(files_ig_pt)
    expect_equal(obtained, "12-03-2023")
  })
  it("returns '03' from 'MAR'", {
    expected <- "03"
    obtained <- MES_2_NUMBER_MONTH[["MAR"]]
    expect_equal(obtained, expected)
  })
})

describe("obtain_unactive_traps_from_clean_position_traps", {
  path_clean_position <- "/workdir/tests/data/example_of_clean_IG_POSICION.csv"
  clean_posicion_trampa <- read_csv(path_clean_position, show_col_types = FALSE)
  obtained <- obtain_inactive_traps_from_clean_position_traps(clean_posicion_trampa)
  it("has all the columns", {
    expected_names <- c("ID", "Coor-X", "Coor-Y", "is_active", "date", "line")
    obtained_names <- names(obtained)
    expect_true(all(obtained_names %in% expected_names))
  })
  it("is_active has FALSE value", {
    expect_false(obtained$is_active[1])
    all_are_inactive <- all(obtained$is_active == FALSE)
    expect_true(all_are_inactive)
  })
  it("date has just NA value", {
    expect_true(obtained$date[1] == "")
    all_are_inactive <- all(obtained$date == "")
    expect_true(all_are_inactive)
  })
})

describe("update_activated_traps", {
  activated_traps <- read_csv("/workdir/tests/data/some_actived_traps.csv", show_col_types = FALSE)
  path_clean_position <- "/workdir/tests/data/example_of_clean_IG_POSICION.csv"
  clean_posicion_trampa <- read_csv(path_clean_position, show_col_types = FALSE)
  inactive_traps <- obtain_inactive_traps_from_clean_position_traps(clean_posicion_trampa)
  it("update with actived traps", {
    active_and_inactive_traps <- "/workdir/tests/data/actived_and_inactive_traps.csv"
    expected <- read_csv(active_and_inactive_traps, show_col_types = FALSE)
    obtained <- inactive_traps |> update_activated_traps(activated_traps)
    expect_equal(obtained, expected)
  })
  it("Expect error update_activated_traps()", {
    active_traps <- read_csv("/workdir/tests/data/some_actived_traps.csv", show_col_types = FALSE)
    inactive_traps <- read_csv("../data/inactive_traps_with_extra_id.csv", show_col_types = FALSE)
    expect_error(update_activated_traps(active_traps, inactive_traps), "\n 🚨 Los IDs de los renglones 15 en IG_POSICION no están en el mapsource 🚨 \n")
  })
})
