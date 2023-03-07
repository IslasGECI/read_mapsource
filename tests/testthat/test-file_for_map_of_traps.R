describe("from_ig_position_2_maps_of_traps", {
  it("select the three first columns of ig_position_trampa", {
  })
})

describe("obtain_date_of_name_file", {
  it(" returns '12-03-2023' from 'IG_POSICION_TRAMPA_12MAR2023.csv'", {
    files_ig_pt <- "IG_POSICION_TRAMPA_12MAR2023.csv"
    obtained <- obtain_date_of_name_file(files_ig_pt)
    expect_equal(obtained, "12-03-2023")
  })
})