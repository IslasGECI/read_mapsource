describe("Check set of cameras are equal in revision_campo and mapsource", {
  it("Check cameras", {
    revision_campo_path <- "/workdir/tests/data/installed_cameras.csv"
    mapsource_path <- "/workdir/tests/data/ig_cameras.txt"
    expect_no_error(check_cameras(revision_campo_path, mapsource_path))
  })
})

describe("Check set of traps are equal in POSICION and MAPSOURCE files", {
  it("Check traps", {
    positions_path <- "/workdir/tests/data/POSICION_XX.xlsx"
    mapsource_path <- "/workdir/tests/data/cutted_mapsource_for_traps.txt"
    expect_message(check_traps(positions_path, mapsource_path), "💚 La revisión de trampas es correcta 💚")
  })
})
