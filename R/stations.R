edit_station <- function(x){
  lat = x$geo[[1]]
  lon = x$geo[[2]]
  address = x$n
  id = x$idx
  u = x$utime
  name = x$name
  return(data.frame("id"=id,"name"=name, "lat"=lat,
                    "lon"=lon, "time"=u))
}

edit_station <- purrr::possibly(edit_station,
                                data.frame("id"=NA,"name"=NA, "lat"=NA,
                                           "lon"=NA, "time"=NA))


#' Get all the stations in your chosen area.
#'
#' @param llon Longitude of the left boundary
#' @param rlon Longitude of the right boundary
#' @param ulat Latitude of the upper boundary
#' @param dlat Latitude of the lower boundary
#'
#' @return Returns a data.frame with basic informations about the stations.
#' @export
#'
#' @examples
#' stations(llon=25.93, rlon=26.2, ulat=44.64, dlat=44.30)
#'
stations <- function(llon, rlon, ulat, dlat){
  bounds <- paste(llon, dlat, rlon, ulat, sep=",")
  statii <- httr::content(httr::POST("https://api.waqi.info/mapq2/bounds",
                                     body = list(bounds=bounds),
                                     encode = "multipart"))$data
  return(purrr::map_dfr(statii, edit_station))
}
