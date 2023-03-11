describe("remove_duplicated_id", {
  data_with_duplicated_id <- tibble::tibble(
    ID = c("a", "c", "b", "b", "d"),
    some_values = c(1, 2, 3, 4, 5)
  )
  expected <- tibble::tibble(
    ID = c("a", "c", "b", "d"),
    some_values = c(1, 2, 3, 5)
  )
  obtained <- remove_duplicated_id(data_with_duplicated_id)
  expect_equal(obtained, expected)
})

describe("obtain_activated_traps_from_ig_posicion_path", {
  ig_posicion_path <- "/workdir/tests/data/IG_POSICION_TRAMPAS_10MAR2023.csv"
  obtained <- obtain_activated_traps_from_ig_posicion_path(ig_posicion_path)
  expected <- read_csv("/workdir/tests/data/activated_traps.csv", show_col_types = FALSE)
  expect_equal(obtained, expected)
})

describe("obtain_data_from_full_path", {
  expected <- "10-03-2023"
  obtained <- obtain_date_from_full_path("/workdir/tests/data/IG_POSICION_TRAMPAS_10MAR2023.csv")
  expect_equal(obtained, expected)
})

describe("files_ig_posicion_trampas", {
  expected <- c("IG_POSICION_TRAMPAS_03JUL2022.csv", "IG_POSICION_TRAMPAS_10MAR2023.csv")
  obtained <- files_ig_posicion_trampas("/workdir/tests/data")
  expect_equal(obtained, expected)
})

describe("obtain_char_date_from_mapsource_file", {
  it("returns '2023-03-04' from '/workdir/data/IG_TRAMPAS_05MAR2023.txt'", {
    expected <- "05-03-2023"
    obtained <- obtain_char_date_from_mapsource_file("/workdir/data/IG_TRAMPAS_05MAR2023.txt")
    expect_equal(obtained, expected)
  })
  it("returns '03-07-2022' from '/workdir/test/data/IG_TRAMPAS_03JUL2022.txt'", {
    expected <- "03-07-2022"
    obtained <- obtain_char_date_from_mapsource_file("/workdir/test/data/IG_TRAMPAS_03JUL2022.txt")
    expect_equal(obtained, expected)
  })
})

describe("obtain_date_name_from_mapsource_file", {
  it("return '05MAR2023' from 'IG_TRAMPAS_05MAR2023'", {
    obtained_date_name <- obtain_date_name_from_mapsource_file("/workdir/tests/data")
    expected_date_name <- "05MAR2023"
    expect_equal(obtained, expected)
  })
})
