describe("Check cameras", {
  listed_cameras_in_mapsource <- tibble("Name" = c("CT-03-034-AR", "CT-01-001-CF", "CT-07-011-LM"))
  one_listed_cameras_in_mapsource <- tibble("Name" = c("CT-01-001-CF"))
  cameras_in_revision_campo <- tibble("ID_camara" = c("CT-01-001-CF", "CT-99-100-XX"))
  cameras_in_revision_campo_green <- tibble("ID_camara" = c("CT-01-001-CF", "CT-03-034-AR", "CT-07-011-LM"))
  two_cameras_in_revision_campo <- tibble("ID_camara" = c("CT-03-034-AR", "CT-07-011-LM"))
  it("Obtain diff in cameras IDs", {
    obtained <- get_missing_ids(cameras_in_revision_campo[["ID_camara"]], listed_cameras_in_mapsource[["Name"]])
    expected <- c("CT-99-100-XX")
    expect_equal(obtained, expected)
    obtained <- get_missing_ids(listed_cameras_in_mapsource[["Name"]], two_cameras_in_revision_campo[["ID_camara"]])
    expected <- c("CT-01-001-CF")
    expect_equal(obtained, expected)
  })
  it("Get correct message", {
    expect_message(double_check(cameras_in_revision_campo_green, listed_cameras_in_mapsource), "💚 La revisión de cámaras es correcta 💚")
  })
  it("Get error if cameras in revision_campo are not in mapsource", {
    expect_error(double_check(cameras_in_revision_campo, one_listed_cameras_in_mapsource), "🚨 Los IDs CT-99-100-XX en IG_CAMARAS no están en el mapsource 🚨")
  })
  it("Get error if cameras in mapsource are not in revision_campo", {
    expect_error(double_check(two_cameras_in_revision_campo, listed_cameras_in_mapsource), "🚨 Los IDs CT-01-001-CF en mapsource no están en el revision_campo 🚨")
  })
})
