##
## OSM Sourced "Railway" Sites in Terre Haute:
## Noelle C. 


####################################################
## Make sure these packages are installed:
install.packages("osmdata")
install.packages("ggmap")
install.packages("sf")
install.packages("ggplot2")
install.packages("dplyr")

## This one requires the R-ArcGIS Bridge to be installed from within ArcMap/ArcPro.
install.packages("arcgisbinding") 
arcgisbinding::arc.check_product()
library(arcgisbinding)

##
## Call the libraries into the session:
library(osmdata)
library(ggmap)
library(sf)
library(ggplot2)
library(dplyr)

####################################################
##
## Check the available features:
available_features()

## These are feature tags that you can use to query 
## OpenSourceMap Data.

##
## Pick the features in Chicago that are abandoned:
q <- getbb("Terre Haute") %>% 
             opq() %>% 
             add_osm_feature("railway")

## This functions sends a query to OpenSourceMap (OSM)
## OSM Data to OSM_sf:
railway <- osmdata_sf(q)

##
## Extract the points with sf::st_sf:
points <- st_sf(railway$osm_points)

##
## Extract the polygons:
polygons <- st_sf(railway$osm_polygons)

## OPTIONAL:
## Use arcgisbinding to write a shapefile:
arc.write(path = "./R_bridge/osm_source_railway.shp", data = points)

##
## Use get_map() to grab the map of Chicago:

terre <- get_map(getbb("Terre Haute"), maptype = "toner-background")

##
## Call the railway points/lines on a map of Terre Haute, IN:
ggmap(terre)+
  geom_sf(data = railway$osm_lines,
          inherit.aes = FALSE,
          colour = "#238443",
          fill = "#004529",
          alpha = .5,
          size = 0.5,
          shape = 1)+
  labs(x = "", y = "")
