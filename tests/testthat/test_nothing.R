describe("Get version of the module", {
  it("The version", {
    expected_version <- c("0.2.0")
    obtained_version <- packageVersion("readMS")
    version_are_equal <- expected_version == obtained_version
    expect_true(version_are_equal)
  })
})
