#' @export
remove_duplicated_id <- function(activated_or_inactivated_traps) {
  is_duplicated_id <- activated_or_inactivated_traps$ID |>
    duplicated()
  return(activated_or_inactivated_traps[!is_duplicated_id, ])
}
