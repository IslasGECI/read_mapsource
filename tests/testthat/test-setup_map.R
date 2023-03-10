describe("remove_duplicated_id", {
  data_with_duplicated_id <- tibble::tibble(
    ID = c("a", "c", "b", "b", "d"),
    some_values = c(1, 2, 3, 4, 5)
  )
  expected <- tibble::tibble(
    ID = c("a", "c", "b", "d"),
    some_values = c(1, 2, 3, 5)
  )
  obtained <- remove_duplicated_id(data_with_duplicated_id)
  expect_equal(obtained, expected)
})
