describe("Check set of cameras are equal in revision_campo and mapsource", {
  it("Check cameras", {
    revision_campo_path <- "/workdir/tests/data/installed_cameras.csv"
    mapsource_path <- "/workdir/tests/data/ig_cameras.txt"
    expect_no_error(check_cameras(revision_campo_path, mapsource_path))
  })
})
