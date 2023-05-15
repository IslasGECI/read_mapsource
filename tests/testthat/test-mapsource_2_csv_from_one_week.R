library(testtools)

describe("Create csv from mapsource", {
  it("Run traps for one week", {
    mapsource_path <- "/workdir/tests/data/"
    today <- ymd("2023-04-21")
    write_position_traps_for_one_week(mapsource_path, today = today)
    output_file <- "/workdir/data/IG_POSICION_TRAMPAS_23ABR2023.csv"
    obtained_csv <- read_csv(output_file, show_col_types = FALSE)
    expected_path <- "../data/expected_IG_POSICION_TRAMPAS_23ABR2023.csv"
    expected_csv <- read_csv(expected_path, show_col_types = FALSE)
    expect_equal(obtained_csv, expected_csv)
    delete_output_file(output_file)
  })
})
describe("Read id, sunday, responsable name from last week", {
  it("read_id_sunday_and_responsable_from_last_week()", {
    last_week_path <- "/workdir/tests/data/IG_POSICION_TRAMPAS_10MAR2023.csv"
    obtained <- read_id_sunday_and_responsable_from_last_week(last_week_path)
    expected <- read_csv("/workdir/tests/data/expected_read_id_responsable_and_sunday.csv")
    expect_equal(obtained, expected)
  })
})
describe("copy status traps", {
  it("Example of 10MAR2023 but NA in status and responsable", {
    example_without_status <- read_csv("/workdir/tests/data/example_IG_POSICION_TRAMPAS_10MAR2023_with_NA.csv")
    traps_status <- read_csv("/workdir/tests/data/expected_read_id_responsable_and_sunday.csv")
    obtained <- example_without_status |>
      copy_trap_status(traps_status)
    expected <- read_csv("/workdir/tests/data/expected_copy_trap_status.csv")
    expect_equal(obtained, expected)
  })
})
describe("Get position tramps csv path", {
  it("get_current_position_tramps_from_directory()", {
    directory <- "/workdir/tests/data"
    today <- ymd("2022-07-2")
    obtained <- get_current_position_tramps_from_directory(directory, today)
    expected <- "/workdir/tests/data/IG_POSICION_TRAMPAS_03JUL2022.csv"
    expect_equal(obtained, expected)
  })
})
describe("Get position tramps with status from directory path", {
  it("get_current_position_tramps_from_directory()", {
    directory <- "/workdir/tests/data"
    today <- ymd("2022-07-2")
    example_without_status <- read_csv("/workdir/tests/data/example_IG_POSICION_TRAMPAS_10MAR2023_with_NA.csv")
    obtained <- .obtain_week_with_status(example_without_status, directory, today)
    write_csv(obtained, "/workdir/tests/data/expected_copy_trap_status_03JUL2022.csv")
    expected <- read_csv("/workdir/tests/data/expected_copy_trap_status_03JUL2022.csv")
    expect_equal(obtained, expected)
  })
})
