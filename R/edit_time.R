#' A small function for string->datetime conversion.
#'
#' @param x The string from the time field.
#'
#' @return A datetime.
#' @export
#'
#' @examples
#' edit_time("2020-01-01T10:00:00Z")
#'
edit_time <- function(x){
  gsub("T|Z|X", " ", x) %>%
    lubridate::parse_date_time(., "ymdHMS")
}
