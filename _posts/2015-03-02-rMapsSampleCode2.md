---
title: "rMaps sample code to play with #2"
author: "Sam Guleff"
date: "March 01, 2015"
output: html_document
layout: post
description: mini-assignment
tags: assignments, Sam Guleff, rMaps, Sample Code, Presentation, Mexico, Crime, Data
---

Full file will be available here:

[rMapsBlogSample.R](https://github.com/sguleff/edav/blob/gh-pages/_posts/sguleff/rCode/rMapsMexicoDataMap.R)

First lets pull the data from the internet and load into a dataframe.

```
# Download crime data if we don't have it
## From crimenmexico.diegovalle.net/en/csv
## All local crimes at the state level
if (!file.exists("fuero-comun-estados.csv.gz"))
{
  download.file("http://crimenmexico.diegovalle.net/en/csv/fuero-comun-estados.csv.gz", 
                "fuero-comun-estados.csv.gz")
}

#don't reread data is already loaded
if (!exists("crime"))
{
  crime <- read.csv("fuero-comun-estados.csv.gz")

}

```
use sqldf to filter and manipulate the dataframe

```
#filter to homicides intentional
crime <- sqldf("select * from crime where crime == 'HOMICIDIOS' and type == 'DOLOSOS'")

#aggregate and filter
hom <- sqldf("Select state_code,year,type, sum(count) as total, avg(population) as population, sum(count) / (population * 100000) as rate from crime where year > 1997 and year < 2013  group by state_code,year,type order by state_code, year")

#file with code to state mappings
codes <- read.csv2("states.csv", header = TRUE, sep = ",", quote = "\"")

#remove col 1, convert types, rename column headers
codes <- codes[-1]
codes$NAME <- iconv(codes$NAME, "windows-1252", "utf-8")
codes$CODE <- as.numeric(codes$CODE)
names(codes) <- c("state_code", "name")

#join state code names with numbers
hom <- sqldf("select * from hom join codes on hom.state_code = codes.state_code")

## set date for the ichoropleth map
library("rMaps")
d1 <- ichoropleth(rate ~ name, data = hom, ncuts = 9, pal = 'YlOrRd', 
                  animate = 'year',  map = 'states'
)

```
we're missing the geographic representation of mexico in the default package so we can 
load from a GEOJSON file. and output map

```
#json file contains description of mexican states locations
d1$set(
  geographyConfig = list(
    dataUrl = "https://dl.dropboxusercontent.com/u/10794332/mx_states.json"
  ),
  scope = 'states',
  setProjection = '#! function( element, options ) {
  var projection, path;
  projection = d3.geo.mercator()
  .center([-89, 21]).scale(element.offsetWidth)
  .translate([element.offsetWidth / 2, element.offsetHeight / 2]);
  
  path = d3.geo.path().projection( projection );
  return {path: path, projection: projection};
  } !#'
)

#show in viewer and save html output
d1
d1$save('rMapsMexicoDataMap.html', cdn = TRUE)
```
<iframe chart_1="" height="600" width="650" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
http://embed.plnkr.co/rdBprmBzLPIrVvCVyJ7I/preview
"></iframe>

[Final Results](http://embed.plnkr.co/rdBprmBzLPIrVvCVyJ7I/preview)
