##code to plot wine production onto a world map.
##Code by Sam Guelff for EDAV STATW4701 Columbia University Spring 2015
##data was pulled from http://italianwinecentral.com/top-fifteen-wine-producing-countries-2014/
##world map boundaries were downloaded from http://thematicmapping.org/downloads/world_borders.php


#set working directory
setwd("~/HomeSVN/R/Data Visualization/Blog Post")

#Install leaflet if needed
require(devtools)
devtools::install_github("rstudio/leaflet")

# then install a few extra packages
library(leaflet)
library(magrittr)
library(maptools)
library(reshape2)


############################

#load the SpacialPolygonsDataFrame
countryLines <- readShapeSpatial("TM_WORLD_BORDERS-0.3.shp")
countryLines$proj4string <- "+proj=longlat +ellps=clrk66"

#load any info I have on the Water Sources to append to the Geo Dataset
wineExportData <- read.table('wineExports.tsv', header=TRUE, sep="\t", fileEncoding="windows-1252")

#function to distribute Colors
pal <- colorQuantile("YlGn", NULL, n = 5)

#Load the Spacial Polygons Data Fram
country_popup <- paste("<strong>Name of the Country: </strong>", 
                      countryLines$NAME, 
                      "<br><strong>HectaLiters of Export: </strong>")

#append my data onto the SpacialPolygonsDataFrame
countryLines@data = data.frame(countryLines@data, wineExportData[match(countryLines@data[,"NAME"], wineExportData[,"Country"]),])
              


#map backgroup and attribution
mb_tiles <- 'http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
mb_attribution <- 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid,IGN, IGP, UPR-EGP, and the GIS User Community'



#load data and show
leaflet(data = countryLines) %>%
  setView(-10,40, zoom = 2) %>%
  addTiles(urlTemplate = mb_tiles,  
           attribution = mb_attribution) %>%
  addPolygons(fillColor = ~pal(Year2014), 
              fillOpacity = 0.8, 
              color = "#BDBDC3", 
              weight = 1, popup = country_popup)
