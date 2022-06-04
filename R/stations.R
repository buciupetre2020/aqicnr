edit_station <- function(x){
  lat = x$g[[1]]
  lon = x$g[[2]]
  address = x$n
  id = x$x
  u = x$u
  c = x$c
  a = x$a
  S = x$S
  return(data.frame("address"=address, "id"=id, "lat"=lat,
                    "lon"=lon, "u"=u, "c"=c, "a"=a,"S"=S))
}

edit_station <- purrr::possibly(edit_station,
                                data.frame("address"=NA, "id"=NA, "lat"=NA,
                                           "lon"=NA, "u"=NA, "c"=NA, "a"=NA, "S"=NA))


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
