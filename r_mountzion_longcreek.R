####################################################
##
## Dependencies:
library(arcgisbinding) ## requires license from ESRI
library(dplyr)
library(sf)
library(sp)

##
##
##
## Assume here you have your working directory set to where you
## can load a shapefile:
##
## Using this file:
## https://catalog.data.gov/dataset/tiger-line-shapefile-2017-state-illinois-current-place-state-based

ill <- sf::st_read("./tl_2017_17_place.shp")
ill <- st_as_sf(ill)

mtzion <- ill %>% 
  filter(NAME == "Mount Zion")

long <- ill %>% 
  filter(NAME == "Long Creek")

south <- ill %>% 
  filter(NAME == "South Shores")

## 
## There is no public shapefile for South Shores.

##
## Let's combine the two shapefiles we have:

combined <- st_union(mtzion, long)
combined <- st_transform(combined, crs = 4326)

plot(combined$geometry)

arcgisbinding::arc.check_product()
arcgisbinding::arc.write(combined, path = "C:/Noelle GIS/External Resources/Illinois/mtzion_longcreek_shape2.shp")
