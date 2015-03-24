---
title: "rMaps sample code to play with #3"
author: "Sam Guleff"
date: "March 01, 2015"
output: html_document
layout: post
description: mini-assignment
tags: assignments, Sam Guleff, rMaps, Sample Code, Presentation, Mexico, Crime, Data
---

Full file will be available here:

[rMapsBlogSample.R](https://github.com/sguleff/edav/blob/gh-pages/_posts/sguleff/rCode/rMapsMexicoDataMap.R)

[Data can be downloaded from data.gov](http://catalog.data.gov/dataset/consumer-complaint-database/resource/8842d7a8-d34e-4ad6-b324-8f8cb3c5beef)

First lets pull the data from the internet and load into a dataframe.

```
#Install rMaps
require(devtools)
install_github('ramnathv/rCharts@dev')
install_github('ramnathv/rMaps')

#libraries to load
library(rMaps) #Mapping package
library(rcharts) #rcharts needed by rMaps
library(sqldf) #filter and manipulate the data as needed
library(lubridate) #clean up the dates as quickly as possible

###############################
# Code below takes consumer complaints with financial products and plots an ichoropleth map showing state
# by state issue counts over years.
###############################

#Set working directory to dataset(s)
setwd("~/Desktop/Dataset")

#Read in all data 
myData <- read.csv2("Consumer_complaints.csv",header = TRUE, sep = ",", quote = "\"")

```
As usual we need to clean and format the data to show.  One note is that it's critical 
that the data state names are characters and not factors and time for the slider is an 
integer.

```

#clean up dates to years
myData$Date.received <- as.character(year(mdy(myData$Date.received)))


#aggregate to state and year
plotData <- sqldf("select count(*) as Count, State, \"Date.received\" as Year from myData group by State, 
                  \"Date.received\" having State <> '' ")
#ensure that the year is in integer or slider will not work
plotData$Year <- as.integer(plotData$Year)
plotData$State <- as.character(plotData$State)

```
Call rMaps and output map

```

## set date for the ichoropleth map
library("rMaps")
d1 <- ichoropleth(Count ~ State, data = plotData, ncuts = 8, pal = 'YlOrRd', 
                  animate = 'Year'
)
d1$save('rMaps2.html', cdn = TRUE)

```
Additionall the code below should work but the rMaps package doesn't render the map

```
####################################
# Attempt to work with failed bank time list to plot a state by state over time comparison
# Code does not work correctly
#####################################

#Read in all data 
myData <- read.csv2("Failed_banklist.csv",header = TRUE, sep = ",", quote = "\"")

#replace the poorly formated string as dates
myData$Closing.Date <- dmy(myData$Closing.Date)

#reformat for group by to clean strings
#myData$Closing.Date <- paste(sep="", "1-", as.character(month(myData$Closing.Date)), "-", as.character(year(myData$Closing.Date)))
myData$Closing.Date <- as.character(year(myData$Closing.Date))



plotData <- sqldf("select count(*) as count, ST, \"Closing.Date\" as date from myData group by ST, \"Closing.Date\"   ")


plotData$date <- as.integer(plotData$date)
plotData$ST <- as.character(plotData$ST)

d1 <- ichoropleth(count ~ ST, data = plotData, ncuts = 3, pal = 'YlOrRd', 
                  animate = 'date'
)
d1$save('rMaps3.html', cdn = TRUE)
d1

##############################
```
<iframe chart_1="" height="600" width="800" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
http://embed.plnkr.co/9o7GfU6YsuqhEsB5ZEz3/preview
"></iframe>


