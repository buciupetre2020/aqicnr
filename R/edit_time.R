#' A small function for datetime conversion
#'
#' @param x The time string returned by the `get_station` function.
#'
#' @return A datetime
#' @export
#'
#' @examples
#' edit_time("2020-01-03T10:00:00Z")
#'
edit_time <- function(x){
  gsub("T|Z|X", " ", x) %>%
    lubridate::parse_date_time(., "ymdHMS")
}
