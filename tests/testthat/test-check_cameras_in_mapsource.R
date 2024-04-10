describe("Check cameras", {
  listed_cameras <- read_csv("/workdir/tests/data/ig_cameras_waypoints.csv", show_col_types = FALSE)
  rows_of_installed_cameras <- extract_installed_cameras(listed_cameras)
  write_csv(rows_of_installed_cameras, "/workdir/tests/data/installed_cameras.csv")
  cameras_in_revision_campo <- tibble("ID_camara" = c("CT-01-001-CF", "CT-99-100-XX"))
  it("check if cameras in revision_campo are in mapsource", {
    obtained <- check_cameras_in_mapsource(cameras_in_revision_campo, rows_of_installed_cameras)
  })
})
