library(testtools)

describe("Create csv from mapsource", {
  it("Run traps for one week", {
    mapsource_path <- "/workdir/tests/data/"
    today <- ymd("2023-04-21")
    write_position_traps_for_one_week(mapsource_path, today = today)
    output_file <- "/workdir/data/IG_POSICION_TRAMPAS_23ABR2023.csv"
    obtained_csv <- read_csv(output_file, show_col_types=FALSE)
    expected_path <- "../data/expected_IG_POSICION_TRAMPAS_23ABR2023.csv"
    expected_csv <- read_csv(expected_path, show_col_types=FALSE)
    expect_equal(obtained_csv, expected_csv)
    delete_output_file(output_file)
  })
})
