---
title: "Sam Guleff Mini Assignment"
author: "Sam Guleff"
date: "Saturday, February 14, 2015"
output: html_document
layout: post
description: mini-assignment
tags: assignments, Sam Guleff
---

#NYC Accident Data Preliminary Analysis

###Concept:

  Starting with a cleaned version of NYPD's Crash Data which can be obtained at [NYPD Crash Data Band-Aid](http://nypd.openscrape.com/#/).  I wanted to determine the most accident prone locations within the 300,000 sample data set and plot onto a map of each of the 5 boroughs.  I also started looking at most dangerous pedestrian intersections around New York and Columbia University specifically.  Also, I started playing with overlaying a bin map with a few types of bins (cyclists and pedestrians killed, and a variety of primary causes of accidents).  Lastly, I wanted to plot a density of accidents map which I believe would be proportional to the traffic density, however I was unable to correlate that as average traffic density in New York is difficult to find.
  
###Libraries Used:

[ggmap](http://cran.r-project.org/web/packages/ggmap/index.html) - allows for the easy visualization of spatial data and models on top of Google Maps, OpenStreetMaps, Stamen Maps, or CloudMade Maps using ggplot2.

[SQLDF](http://cran.r-project.org/web/packages/sqldf/index.html) - Manipulate R data frames using SQL. Being more comfortable with SQL queries I wanted a package to manipulate the data.


###Commented Code:


```
#Sam Guleff SG2665
#EDAV mini Assignment #1


#load all the libraries needed 
library(ggmap)
library(sqldf)


#functions -------------------------------------------------------------------------------------------


#takes data and returns new size limited dataframe aggregated by lat,long and ordered by a column
AggregateData <- function(DATA, orderByCol, maxValues)
{
  tmp <- paste(sep="", "SELECT lon,lat,sum(",orderByCol,") as agg_",orderByCol, " FROM DATA where lon <> '' and lat <> '' GROUP BY lon,lat order by agg_",orderByCol, " desc limit ", as.character(maxValues))
  return(sqldf(tmp))
}

#takes data and returns new size limited dataframe aggregated by lat, long and ordered by a column where at least 1 cyclists_injured, cyclists_killed, pedestr_killed, pedestr_injured 
AggregateDataPedCyc <- function(DATA, orderByCol, maxValues)
{
  tmp <- paste(sep="", "SELECT lon,lat, SUM(cyclists_injured + cyclists_killed + pedestr_killed + pedestr_injured) as agg_",orderByCol, " FROM DATA where (cyclists_injured + cyclists_killed + pedestr_killed + pedestr_injured) > 0 and lon <> '' and lat <> '' GROUP BY lon,lat HAVING agg_", orderByCol," > 10 order by agg_", orderByCol, " desc limit ", as.character(maxValues))
  return(sqldf(tmp))
}


#takes aggregated data and requires 3 fiels lon, lat and agg_collisions to plot 
plotPointMap <- function(plotData, zoomLevel,  pointSize, pointAlpha, LocationCenter, chartTitle = "")
{
  ZOOM_LEVEL <<- zoomLevel
  #plot the hybrid Google Maps basemap with points on top
  map <- qmap(LocationCenter, zoom = ZOOM_LEVEL, legend = "topleft")
  #map + geom_point(data = colLocations, aes(x =  as.numeric(as.character(lon)), y =  as.numeric(as.character(lat)), color=total_killed), size=GEOMPT_SIZE, alpha=GEOM_ALPHA)
  map + geom_point(data = plotData, aes(x =  as.numeric(as.character(lon)), y = as.numeric(as.character(lat)), color=agg_collisions), size=pointSize, alpha=pointAlpha) +  scale_colour_gradient(low="blue",high="red") + ggtitle(chartTitle)
}

#plot a bin map based on pedestrian and cyclist
plotDeathBinMap <- function(plotData, LocationCenter, zoomLevel, binNumber,  chartTitle = "")
{
  ZOOM_LEVEL <<- zoomLevel

  #select only deaths
  SelectBins <- "SELECT lon,lat, CASE 
  WHEN cyclists_killed > 0 THEN \"cyclists killed\" 
  WHEN pedestr_killed > 0  THEN \"pedestr killed\" 
  ELSE \"None\" END as Injury_Type FROM Allcollisions"
  binSetFull <- sqldf(SelectBins)
  
  #remove the none cases
  SelectRemoveNone <- "SELECT lon,lat, Injury_Type FROM binSetFull WHERE Injury_Type <> \"None\" "
  binMapFiltered <- sqldf(SelectRemoveNone)
  
  #bin types
  binMapFiltered$Injury_Type <- factor(binMapFiltered$Injury_Type, levels = c("cyclists killed", "pedestr killed")) #, "cyclists injured", "pedestr injured"
  
  #map code below
  geo <- stat_bin2d(
    aes(x = as.numeric(as.character(lon)), y = as.numeric(as.character(lat)), colour = Injury_Type, fill = Injury_Type),
    size = .5, bins = 60, alpha = 1/2,
    data = binMapFiltered)
  
  map <- qmap(LocationCenter, zoom = ZOOM_LEVEL, legend = "topleft") + ggtitle(chartTitle)
  
  map + geo 
 
}

#plot alternate ways to bin the data
plotAltBinMap <- function(plotData, LocationCenter, zoomLevel, binNumber,  chartTitle = "")
{
  ZOOM_LEVEL <<- zoomLevel
  
  #select bins
  SelectBins <- "SELECT lon,lat, CASE 
  WHEN aggressive_driving_road_rage > 0 THEN \"Road Rage\" 
  WHEN cell_phone_hand_held > 0  THEN \"Cell Use\" 
  WHEN texting > 0  THEN \"Text\" 
  WHEN unsafe_speed > 0  THEN \"Unsafe Speed\" 

  ELSE \"None\" END as Injury_Type FROM Allcollisions"
  binSetFull <- sqldf(SelectBins)
  
  #remove the none cases
  SelectRemoveNone <- "SELECT lon,lat, Injury_Type FROM binSetFull WHERE Injury_Type <> \"None\" "
  binMapFiltered <- sqldf(SelectRemoveNone)
  
  #bin types
  binMapFiltered$Injury_Type <- factor(binMapFiltered$Injury_Type, levels = c("Road Rage", "Cell Use","Text","Unsafe Speed")) #, "cyclists injured", "pedestr injured"
  
  #map code below
  geo <- stat_bin2d(
    aes(x = as.numeric(as.character(lon)), y = as.numeric(as.character(lat)), colour = Injury_Type, fill = Injury_Type),
    size = .5, bins = 60, alpha = 1/2,
    data = binMapFiltered)
  
  map <- qmap(LocationCenter, zoom = ZOOM_LEVEL, legend = "topleft") + ggtitle(chartTitle)
  
  map + geo 
  
}

#plot a density map of killed and injured pedestrians
plotDensityMap <- function(plotData, LocationCenter, zoomLevel, binNumber,  chartTitle = "")
{
  ZOOM_LEVEL <<- zoomLevel
  
  #select only deaths
  SelectBins  <- "SELECT lon,lat, CASE 
  WHEN cyclists_killed > 0 THEN \"cyclists killed\" 
  WHEN pedestr_killed > 0  THEN \"pedestr killed\" 
  WHEN cyclists_injured > 0  THEN \"cyclists injured\" 
  WHEN pedestr_injured > 0  THEN \"pedestr injured\" 
  ELSE \"None\" END as Injury_Type FROM Allcollisions"
  binSetFull <- sqldf(SelectBins)
  
  #remove the none cases
  SelectRemoveNone<- "SELECT lon,lat, Injury_Type FROM z WHERE Injury_Type <> \"None\" "
  binMapFiltered <- sqldf(SelectRemoveNone)
  
  #bin types and convert lon,lat to num
  z$Injury_Type <- factor(z$Injury_Type, levels = c("cyclists killed", "pedestr killed","pedestr injured","cyclists injured")) #, "cyclists injured", "pedestr injured"
  z$lon <- as.numeric(as.character(z$lon))
  z$lat <- as.numeric(as.character(z$lat)) 
  
  #map code below
  geo <- stat_density2d(
    aes(x = as.numeric(as.character(lon)), y = as.numeric(as.character(lat)), alpha = ..level.., fill = ..level..),
    size = .5, bins = 6, alpha = 1/2,
    data = z, geom = "polygon")
  
  map <- qmap(LocationCenter, zoom = ZOOM_LEVEL, legend = "topleft") + ggtitle(chartTitle)
  
  map + geo
  
}






#Main Code Below -----------------------------------------------------------------------------------

# Set working directory
setwd("Y:/CloudStation/1 TextBooks and Notes/Data Visualization/Homework/")

#parameters for filtering and mapping
MAX_SAMPLES = 1000
LON_ROUND = 4 #factor to round long locations together 4 -> .001 ~70.5ft bucket assuming 24,000 miles per LoN
LAT_ROUND = 3 #factor to round long locations together 3 -> .001 ~352ft bucket assuming 12,000 miles @ 40N
ZOOM_LEVEL = 15
GEOMPT_SIZE = 6
GEOM_ALPHA = .9


#don't reread 44Megs of data is already loaded
if (!exists("Allcollisions"))
{
  Allcollisions <- read.delim("collisions.csv", dec=",")
}


#find most collisions and plot top 1000
clgroup <- AggregateData(Allcollisions, "collisions" , 100000)
plotPointMap(clgroup, 15,  GEOMPT_SIZE, GEOM_ALPHA, "Columbia University, New York", "Most accident prone intersections near Columbia")

clgroup <- AggregateData(Allcollisions, "collisions" , 1000)
plotPointMap(clgroup, 15, GEOMPT_SIZE, GEOM_ALPHA, "Times Square, New York", "TOP Accident Locations near Midtown")
plotPointMap(clgroup, 13, GEOMPT_SIZE, GEOM_ALPHA, "Brooklyn, New York", "TOP Accident Locations near Brooklyn")
plotPointMap(clgroup, 13,  GEOMPT_SIZE, GEOM_ALPHA, "Queens, New York", "TOP Accident Locations near Queens")
plotPointMap(clgroup, 13, GEOMPT_SIZE, GEOM_ALPHA, "Bronx, New York", "TOP Accidents Location near The Bronx")
plotPointMap(clgroup, 13, GEOMPT_SIZE, GEOM_ALPHA, "Staten Island, New York", "TOP Accident Locations near Staten Island")

#data on ped + cyc accidents only
clgroup <- AggregateDataPedCyc(Allcollisions, "collisions" , 300000)
plotPointMap(clgroup, 15,  GEOMPT_SIZE, GEOM_ALPHA, "Columbia University, New York", "Most Dangerous Pedestrian Intersections near Columbia")
plotPointMap(clgroup, 12, 3, GEOM_ALPHA, "Times Square, New York", "Most Dangerous Pedestrian Intersections around NYC")


#data bined into cyclist and pedestrian deaths
plotDeathBinMap(Allcollisions, "Times Square, New York", 12, 60, "Deadly Pedestrian Accidents")

#density plot of all pedestrian accidents
plotDensityMap(Allcollisions, "Times Square, New York", 11, 6,  chartTitle = "Density of Pedestrian Accidents")

#alternate binning of data
plotAltBinMap(Allcollisions, "Times Square, New York", 12, 60, "Potential Causes of Accidents")
```

###Results:

**Aggregated 5 years of traffic accidents showing most likely locations of accidents within neighborhoods or boroughs.**

![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_accColumbia.png)
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_accMidtown.png)
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_accBrooklyn.png)
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_accQueens.png)
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_accBronx.png)
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_accStatenIsland.png)

**Aggregated 5 years of traffic accidents showing pedestrian & cyclist accidents within neighborhoods or boroughs.**
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_pedColumbia.png)
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_pedNYC.png)

**Bins on map showing where deadly accidents have occurred by pedestrian & cyclist.**
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_deathbin.png)

**Attempt to plot accident density overlaied onto New York City map.**
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_densityplot.png)

**Bins on map showing possible causes of accidents**
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_altbin1.png)
![](https://raw.githubusercontent.com/sguleff/edav/assignmentbranch/_posts/sguleff/sg2665_altbin2.png)

###Difficulties and Issues:
  * Strange issue with variables and functions.  Likely relating to environment (namespace) 
  * Binning proved difficult to plot and took longer to munge into the proper format for bin and density graphs
  * Would like to clean up functions to better handle sorting, filtering, grouping to make further analysis cleaner and easier.
