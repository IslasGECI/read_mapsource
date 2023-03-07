library(tidyverse)
describe("from_ig_position_2_maps_of_traps", {
  path <- "/workdir/tests/data/IG_POSICION_TRAMPAS_03JUL2022.csv"
  posicion_trampa <- read_csv(path, show_col_types = FALSE)
  revised_date <- "03-07-2022"
  obtained <- transform_from_ig_position_2_maps_of_traps(posicion_trampa, revised_date)
  it("has not na in Nombre_del_responsable", {
    there_is_not_na <- all(!is.na(obtained$Nombre_del_responsable))
    expect_true(there_is_not_na)
  })
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
    files_ig_pt <- "IG_POSICION_TRAMPA_12MAR2023.csv"
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
  it("has all the columns", {
    path_clean_position <- "/workdir/tests/data/example_of_clean_IG_POSICION.csv"
    clean_posicion_trampa <- read_csv(path_clean_position, show_col_types = FALSE)
    obtained <- obtain_inactive_traps_from_clean_position_traps(clean_posicion_trampa)
    expected_names <- c("ID", "Coor-X", "Coor-Y", "is_active", "date", "line")
    obtained_names <- names(obtained)
    expect_true(all(obtained_names %in% expected_names))
  })
})
