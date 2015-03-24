# First, install leaflet
require(devtools)
devtools::install_github("rstudio/leaflet")

library(leaflet)
library(magarittr)
library(maptools)

## read in data as csv file
NOx_NY <- read.csv(path.expand("~/Desktop/NOx_NY.csv"), header=TRUE, sep=",")

## review data format
head(NOx_NY)

## basic leaflet map - OpenStreetMaps is default background tile
leaflet() %>% addTiles()

## other sets of tiles can be used, http://leaflet-extras.github.io/leaflet-providers/preview/index.html
leaflet() %>% addTiles('http://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png')

## map attributions also recommended
m = leaflet() %>% addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', 
	attribution = 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, 		Aerogrid,IGN, IGP, UPR-EGP, and the GIS User Community')
m

##set zoom (format is long, lat)
m %>% setView(-77.03653,38.897676, zoom = 16)


## Example of adding circles at lon/lat points - searches for typical lat/lon variable names automatically
m <- NULL
m %>% leaflet(data = NOx_NY)  %>% addTiles()
m %>% addCircles(data = NOx_NY)


## manipulating size of radius by a variable, and setting colors
m %>% addCircleMarkers(radius = ~Emissions.in.Tons/80, color = 'red')

## breakdown by source (can override existing data with new data for mapping conditions)

types <- as.list(as.character(unique(NOx_NY$Source.Type)))
m %>% addCircleMarkers(data = subset(NOx_NY, Source.Type == "Airport"), radius = ~Emissions.in.Tons/80, color = 'red')

## Layering Markers onto the map
rowmax <- NOx_NY[which.max(NOx_NY$Emissions.in.Tons),3:4]

m %>% addCircleMarkers(data = NOx_NY, radius = ~Emissions.in.Tons/80, color = 'red') %>% addMarkers(rowmax[1,2], rowmax[1,1], icon = JS("L.icon({iconUrl: 'http://www.grinningplanet.com/2004/04-20/industry-camera-thumb.gif', iconSize: [30,30]})"))

## can also explicitly graph paths, points, rectangles, and polygons onto the map as well
linetest <- subset(NOx_NY, Source.Type == "Electricity Generation via Combustion")
m %>% addPolylines(linetest$Longitude, linetest$Latitude, stroke=0.2) %>% addCircleMarkers(subset(NOx_NY, Source.Type == "Electricity Generation via Combustion"))

## add Popup Pins
m %>% addPopups(-73.959902,40.809379, "Here's our classroom!")


## import shapefile for county lines and add projection class (maptools forces you to do this manually)
## if given the choice, rgdal is a better package to use but doesn't currently have Mavericks binary on CRAN...

countylines <- readShapeSpatial("~/Desktop/NYCountyShp/CEN2000nycty.036.shp.07865/cty036.shp")
countylines$proj4string <- "+proj=longlat +ellps=clrk66"

## add counties as polygons
m %>% addTiles() %>% addPolygons(data=countylines)
m %>% addTiles() %>% addPolygons(data=countylines, fill = TRUE, color = "blue")

## change fill opacity
m %>% addTiles() %>% addPolygons(data=countylines, fill = TRUE, color = "blue", fillOpacity= 0.1, stroke = FALSE)

## add could add lines as well
m %>% addTiles() %>% addLines(data=countylines)
m %>% addPolylines(data=countylines, weight = 2, color = "white")

##Combine multiple features into single graph
m = m %>% addPolygons(data=countylines, fill = TRUE, color = "green", fillOpacity= 0.1, stroke = FALSE)
m = m  %>% addPolylines(data=countylines, weight = 2, color = "white")
m = m  %>% addCircleMarkers(data = subset(NOx_NY, Source.Type == "Airport"), 
                       radius = ~Emissions.in.Tons/80, 
                       color = 'red')
m = m %>% addCircleMarkers(data = subset(NOx_NY, Source.Type == "Electricity Generation via Combustion"), 
                       radius = ~Emissions.in.Tons/80, 
                       color = 'blue')
m = m %>% addMarkers(rowmax[1,2], rowmax[1,1], 
                 icon = JS("L.icon({iconUrl: 'http://www.grinningplanet.com/2004/04-20/industry-camera-thumb.gif', iconSize: [30,30]})"))
m
