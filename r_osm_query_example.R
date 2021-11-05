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
install.packages("rgeos")
install.packages("rgdal")
install.packages("RPostgreSQL")
install.packages("rpostgis")


## This one requires the R-ArcGIS Bridge to be installed from within ArcMap/ArcPro.
install.packages("arcgisbinding") 
arcgisbinding::arc.check_product()
library(arcgisbinding)

##
## Call the libraries into the session:
library(osmdata)
library(ggmap)
library(sf)
library(sp)
library(ggplot2)
library(dplyr)
library(rgdal)
library(raster)
library(rgeos)
library(RPostgreSQL)
library(rpostgis)

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
points <- st_transform(points, crs = 4326)


##
## Extract the polygons:
polygons <- st_sf(railway$osm_polygons)
polygons <- st_transform(polygons, crs = 4326)

##
## Extract the lines:
lines <- st_sf(railway$osm_lines)
lines <- st_transform(lines, crs = 4326)

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

####################################################
##
## We will only deal with sf and sfc type objects in this part.

## Assume here you have your working directory set to where you
## can load a shapefile:

ind

ind <- st_as_sf(ind)
##
## Let's do some Analytics on the object lines:


raster::shapefile("")

str(points)

