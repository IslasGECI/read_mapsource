describe("Check cameras", {
  listed_cameras_in_mapsource <- tibble("Name" = c("CT-03-034-AR", "CT-01-001-CF", "CT-07-011-LM"))
  cameras_in_revision_campo <- tibble("ID_camara" = c("CT-01-001-CF", "CT-99-100-XX"))
  cameras_in_revision_campo_green <- tibble("ID_camara" = c("CT-01-001-CF", "CT-03-034-AR", "CT-07-011-LM"))
  two_cameras_in_revision_campo <- tibble("ID_camara" = c("CT-03-034-AR", "CT-07-011-LM"))
  it("check if cameras in revision_campo are in mapsource", {
    obtained <- are_id_sets_equal(cameras_in_revision_campo, listed_cameras_in_mapsource)
    expect_false(obtained)
    obtained <- are_id_sets_equal(cameras_in_revision_campo_green, listed_cameras_in_mapsource)
    expect_true(obtained)
    obtained <- are_id_sets_equal(two_cameras_in_revision_campo, listed_cameras_in_mapsource)
    expect_false(obtained)
  })
  it("Obtain diff in cameras IDs", {
    obtained <- get_missing_ids_in_mapsource(cameras_in_revision_campo, listed_cameras_in_mapsource)
    expected <- c("CT-99-100-XX")
    expect_equal(obtained, expected)
    obtained <- get_missing_ids_in_revision_campo(two_cameras_in_revision_campo, listed_cameras_in_mapsource)
    expected <- c("CT-01-001-CF")
    expect_equal(obtained, expected)
  })
  it("Get message if cameras in revision_campo are in mapsource", {
    expect_message(check_cameras_in_mapsource(cameras_in_revision_campo_green, listed_cameras_in_mapsource), "💚 Todas las cámaras están en el mapsource 💚")
  })
  it("Get message if cameras in mapsource are in revision_campo", {
    expect_message(check_cameras_in_revision_campo(cameras_in_revision_campo_green, listed_cameras_in_mapsource), "💚 Todas las cámaras están en el revision_campo 💚")
  })
  it("Get error if cameras in revision_campo are not in mapsource", {
    expect_error(double_check(cameras_in_revision_campo, listed_cameras_in_mapsource), "🚨 Los IDs CT-99-100-XX en IG_CAMARAS no están en el mapsource 🚨")
  })
  it("Get error if cameras in mapsource are not in revision_campo", {
    expect_error(double_check(two_cameras_in_revision_campo, listed_cameras_in_mapsource), "🚨 Los IDs CT-01-001-CF en mapsource no están en el revision_campo 🚨")
  })
})
