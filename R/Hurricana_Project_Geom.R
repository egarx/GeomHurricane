
#' PART 1
#' We are working with polygon point projections
#' Helps to compute geocode projections by quadrant

#' @param point longitude and latitude
#' @param quadrant one of 4 quadrants
#' @param distance scaled distance in meters for the projection
#'
#' @return data frame with point projections
#'
#' @importFrom geosphere destPoint
#'
#' @export

projections <- function(point, quadrant, distance){
  # destination point travelling along a the shortest path on an ellipsoid
  dest_points <- geosphere::destPoint(p = point, b = quadrant, d = distance)

  # save the two points projections to a data frame
  pp <- data.frame(x = c(dest_points[,"lon"], point[1]),
                   y = c(dest_points[,"lat"], point[2]))

  return(pp)
}


#' PART 2
#' Create GeomHurricane
#'
#' This function creates the geom
#'
#' @importFrom magrittr %>% %<>%
#' @importFrom dplyr mutate bind_rows
#' @importFrom grid polygonGrob gpar
#' @import ggplot2
#'
#' @export


GeomHurricane <-
  ggplot2::ggproto("GeomHurricane", ggplot2::Geom,
                   required_aes = c("x", "y", "r_ne", "r_se", "r_sw", "r_nw"),
                   default_aes = ggplot2::aes(fill = 1, colour = 1, alpha = 1,
                                              scale_radius = 1),
                   draw_key = ggplot2::draw_key_polygon, # (data, params, size)
                   draw_group = function(data, panel_scales, coord) {

                     # convert nautical miles to meters and scale
                     # nautical mile is equal to 1852.001 meters
                     nauts_meter <- 1852.001
                     data %<>%
                       dplyr::mutate(r_ne = r_ne * nauts_meter * scale_radius,
                                     r_se = r_se * nauts_meter * scale_radius,
                                     r_sw = r_sw * nauts_meter * scale_radius,
                                     r_nw = r_nw * nauts_meter * scale_radius)

                     # init point params
                     point <- c(data[1,]$x, data[1,]$y)

                     # init other aesthetics
                     fill <- data[1,]$fill
                     # color does not work, use British spelling
                     colour <- data[1,]$colour
                     alpha <- data[1,]$alpha

                     # compute geocode projections by quadrant
                     ne <- projections(point, 0:90, data[1,]$r_ne)
                     se <- projections(point, 90:180, data[1,]$r_se)
                     sw <- projections(point, 180:270, data[1,]$r_sw)
                     nw <- projections(point, 270:360, data[1,]$r_nw)

                     # combine the quadrant dataset rows
                     quad_all  <- rbind(ne, se, sw, nw)

                     #  final combined geom data frame
                     df <- coord$transform(quad_all, panel_scales)

                     grid::polygonGrob(x = df$x, y = df$y,
                                       gp = grid::gpar(fill = fill,
                                                       col = colour,
                                                       alpha = alpha))
                   }
  )


#' PART 3
#' Geom hurricane layer
#'
#' This function builds a geom layer based on \code{GeomHurricane}
#'
#' @param mapping mapping through ggplot2
#' @param data map data through ggplot2
#' @param stat map statistic through ggplot2
#' @param position map position through ggplot2
#' @param na.rm remove NAs
#' @param show.legend default to layer
#' @param inherit.aes inherit aes from main ggplot layer
#' @param ... more arguments for the layer
#'
#'@import ggplot2
#'
#' @return returns a ggplot2 graphical object
#'
#' @export


GeomHurricane <- function(mapping = NULL, data = NULL, stat = "identity",
                           position = "identity", na.rm = FALSE,
                           show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    geom = GeomHurricane, mapping = mapping,
    data = data, stat = stat, position = position,
    show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
