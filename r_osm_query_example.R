##
## OSM Sourced "Abandoned" Sites:
## Noelle C. 


####################################################
## Make sure these packages are installed:
install.packages("osmdata")
install.packages("ggmap")
install.packages("arcgisbinding") ## you may need to search github for this.
install.packages("sf")
install.packages("ggplot2")
install.packages("dplyr")



##
## Call the libraries into the session:
library(osmdata)
library(ggmap)
arcgisbinding::arc.check_product()
library(arcgisbinding)
library(sf)
library(ggplot2)
library(dplyr)

####################################################
##
## Check the available features:
available_features()

##
## Pick the features in Chicago that are abandoned:
q <- getbb("Chicago") %>% 
             opq() %>% 
             add_osm_feature("railway")

## This functions sends a query to OpenSourceMap (OSM)
## OSM Data to OSM_sf:
railway <- osmdata_sf(q)

##
## Extract the points with sf::st_sf:
points <- st_sf(abandon$osm_points)

##
## Extract the polygons:
polygons <- st_sf(abandon$osm_polygons)

##
## Use arcgisbindings to write a shapefile:
arc.write(path = "./R_bridge/osm_source_abandon.shp", data = points)

##
## Use get_map() to grab the map of Chicago:

chi_map <- get_map(getbb("Chicago"), maptype = "toner-background")

##
## Call the railway points on a map of Chicago:
ggmap(chi_map)+
  geom_sf(data = railway$osm_polygons,
          inherit.aes = FALSE,
          colour = "#238443",
          fill = "#004529",
          alpha = .5,
          size = 4,
          shape = 21)+
  geom_sf(data = railway$osm_points,
          inherit.aes = FALSE,
          colour = "red",
          fill = "red",
          alpha = .2,
          size = 1,
          shape = 19)+
  labs(x = "", y = "")
