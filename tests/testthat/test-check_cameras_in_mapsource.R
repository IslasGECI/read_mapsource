describe("Check cameras", {
  listed_cameras_in_mapsource <- tibble("Name" = c("CT-03-034-AR", "CT-01-001-CF", "CT-07-011-LM"))
  cameras_in_revision_campo <- tibble("ID_camara" = c("CT-01-001-CF", "CT-99-100-XX"))
  cameras_in_revision_campo_green <- tibble("ID_camara" = c("CT-03-034-AR", "CT-01-001-CF", "CT-07-011-LM"))
  it("check if cameras in revision_campo are in mapsource", {
    obtained <- are_all_in_mapsource(cameras_in_revision_campo, listed_cameras_in_mapsource)
    expect_false(obtained)
    obtained <- are_all_in_mapsource(cameras_in_revision_campo_green, listed_cameras_in_mapsource)
    expect_true(obtained)
    # expect_error(check_cameras_in_mapsource(cameras_in_revision_campo, listed_cameras_in_mapsource), "🚨 Los IDs CT-99-100-XX en IG_CAMARAS no están en el mapsource 🚨")
  })
})
