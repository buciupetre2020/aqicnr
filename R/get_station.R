#' Get the air quality and air pollution data from a station
#'
#' @param id The ID of the station (Run stations() function to get these)
#'
#' @return A tibble with all the measurements available.
#' @export
#'
#' @examples
#' get_station("125707")
#'
get_station <- function(id){
  message(paste("Processing id", id, "..."))
  link <- paste0("https://airnet.waqi.info/airnet/feed/hourly/", id)
  ceva <- httr::content(httr::GET(link))
  if(ceva$status!="ok"){
    return(NA)
  } else {
    indicatori <- names(ceva$data)
    rez <- dplyr::tibble(ceva=ceva$data) %>%
      dplyr::mutate(indicator = indicatori) %>%
      tidyr::unnest(ceva) %>%
      tidyr::unnest_wider(ceva) %>%
      dplyr::mutate(id = id) %>% dplyr::relocate(indicator)
  }
return(rez)
}
