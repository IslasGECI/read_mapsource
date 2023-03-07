library(tidyverse)
describe("from_ig_position_2_maps_of_traps", {
  path <- "/workdir/tests/data/IG_POSICION_TRAMPAS_03JUL2022.csv"
  posicion_trampa <- read_csv(path, show_col_types = FALSE)
  obtained <- transform_from_ig_position_2_maps_of_traps(posicion_trampa)
  it("has not na in Nombre_del_responsable", {
    there_is_not_na <- all(!is.na(obtained$Nombre_del_responsable))
    expect_true(there_is_not_na)
  })
  it("select the three first columns of ig_position_trampa", {
    expected_names <- c("ID", "Coor-X", "Coor-Y")
    obtained_names <- names(obtained)
    expect_equal(obtained_names, expected_names)
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
