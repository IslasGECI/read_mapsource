describe("Check cameras", {
  listed_cameras_in_mapsource <- tibble("Name" = c("CT-03-034-AR", "CT-01-001-CF", "CT-07-011-LM"))
  listed_two_cameras_in_mapsource <- tibble("Name" = c("CT-03-034-AR", "CT-01-001-CF"))
  cameras_in_revision_campo <- tibble("ID_camara" = c("CT-01-001-CF", "CT-99-100-XX"))
  cameras_in_revision_campo_green <- tibble("ID_camara" = c("CT-01-001-CF", "CT-03-034-AR", "CT-07-011-LM"))
  it("check if cameras in revision_campo are in mapsource", {
    obtained <- are_all_in_mapsource(cameras_in_revision_campo, listed_cameras_in_mapsource)
    expect_false(obtained)
    obtained <- are_all_in_mapsource(cameras_in_revision_campo_green, listed_cameras_in_mapsource)
    expect_true(obtained)
    obtained <- are_all_in_mapsource(cameras_in_revision_campo_green, listed_two_cameras_in_mapsource)
    expect_false(obtained)
  })
  it("Obtain diff in cameras IDs", {
    obtained <- get_missing_ids_in_mapsource(cameras_in_revision_campo, listed_cameras_in_mapsource)
    expected <- c("CT-99-100-XX")
    expect_equal(obtained, expected)
  })
  it("Get message if cameras in revision_campo are in mapsource", {
    expect_message(check_cameras_in_mapsource(cameras_in_revision_campo_green, listed_cameras_in_mapsource), "💚 Todas las cámaras están en el mapsource 💚")
  })
  it("Get error if cameras in revision_campo are not in mapsource", {
    expect_error(check_cameras_in_mapsource(cameras_in_revision_campo, listed_cameras_in_mapsource), "🚨 Los IDs CT-99-100-XX en IG_CAMARAS no están en el mapsource 🚨")
  })
})
