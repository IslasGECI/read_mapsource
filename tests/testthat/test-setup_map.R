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
  obtained <- files_ig_posicion_trampas("/workdir/data")
  expect_equal(obtained, expected)
})
