---
title: "rMaps sample code to play with #1"
author: "Sam Guleff"
date: "March 01, 2015"
output: html_document
layout: post
description: mini-assignment
tags: assignments, Sam Guleff, rMaps, Sample Code, Presentaiton
---

Full file will be available here:

[rMapsBlogSample.R](https://github.com/sguleff/edav/blob/gh-pages/_posts/sguleff/rCode/rMapsBlogSample.R)

We will begin by installing rMaps which is not located in the official Cran respository

```
#Install rMaps
require(devtools)
install_github('ramnathv/rCharts@dev')
install_github('ramnathv/rMaps')

#libraries to load
library(rMaps)
library(Quandl)
library(reshape2)
library(knitr)
library(plyr)
library(dplyr)
library(rcharts)

```

We will be working with US violent Crimerate data from Quandl.
Quandl is a great source of small datasets that can be read directly into R 
through the Quandl package.

*Sample Quandl dataset*

[Apple Stock Price](https://www.quandl.com/data/WIKI/AAPL-Apple-Inc-AAPL)

```
###############################
#Violent Crime Rate heatmap Cholorpleths for US
##############################

#load US Violent Crimerate data from Quandl
vcData = Quandl("FBI_UCR/USCRIME_TYPE_VIOLENTCRIMERATE")

```

To show the power of rMaps we will go through a lot of munging and use the existing
underlying libraries and a little Angular JS to show how to produce animated and static 
choropleth maps.

Below is all the data munging that will need to be copleted 

```
#format Dataframe with html
kable(head(vcData[,1:9]), format = 'html', table.attr = "class=nofluid")

#reshape data to year, state and crime and subset
datm <- melt(vcData, 'Year', 
             variable.name = 'State',
             value.name = 'Crime'
)
datm <- subset(na.omit(datm), 
               !(State %in% c("United States", "District of Columbia"))
)

#format new Dataframe with html
kable(head(datm), format = 'html', table.attr = "class=nofluid")

#transform the data
datm2 <- transform(datm,
                   State = state.abb[match(as.character(State), state.name)],
                   fillKey = cut(Crime, quantile(Crime, seq(0, 1, 1/5)), labels = LETTERS[1:5]),
                   Year = as.numeric(substr(Year, 1, 4))
)
kable(head(datm2), format = 'html', table.attr = "class=nofluid")


#format fill for map
fills = setNames(
  c(RColorBrewer::brewer.pal(5, 'YlOrRd'), 'white'),
  c(LETTERS[1:5], 'defaultFill')
)


#use dply to create LargeList format of data for map
dat2 <- dlply(na.omit(datm2), "Year", function(x)
{
  y = toJSONArray2(x, json = F)
  names(y) = lapply(y, '[[', 'State')
  return(y)
})


#### End data munging section
```

Now for the fun part map generation.  The first map is a simple static map

```
#Siplest R Chart example static map could have used GGMaps

options(rcharts.cdn = TRUE)
map <- Datamaps$new()
map$set(
  dom = 'chart_1',
  scope = 'usa',
  fills = fills,
  data = dat2[[1]],
  legend = TRUE,
  labels = TRUE
)
map


```

And now a more dynamic map with a slider bar

```
map2 = map$copy()
map2$set(
  bodyattrs = "ng-app ng-controller='rChartsCtrl'"
)
map2$addAssets(
  jshead = "http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.2.1/angular.min.js"
)

map2$setTemplate(chartDiv = "
  <div class='container'>
    <input id='slider' type='range' min=1960 max=2010 ng-model='year' width=200>
    <span ng-bind='year'></span>
    <div id='' class='rChart datamaps'></div>  
  </div>
  <script>
    function rChartsCtrl($scope){
      $scope.year = 1960;
      $scope.$watch('year', function(newYear){
        map.updateChoropleth(chartParams.newData[newYear]);
      })
    }
  </script>"
)

map2$set(newData = dat2, scope = 'usa')
map2

```
<iframe chart_1="" height="500" width="800" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
http://rmaps.github.io/blog/posts/animated-choropleths/fig/animated_choro.html
"></iframe>

And now we will have an animated version of the same map with a play button

```

map3 = map2$copy()
map3$setTemplate(chartDiv = "
  <div class='container'>
    <button ng-click='animateMap()'>Play</button>
    <div id='chart_1' class='rChart datamaps'></div>  
  </div>
  <script>
    function rChartsCtrl($scope, $timeout){
      $scope.year = 1960;
      $scope.animateMap = function(){
        if ($scope.year > 2010){
          return;
        }
        mapchart_1.updateChoropleth(chartParams.newData[$scope.year]);
        $scope.year += 1
        $timeout($scope.animateMap, 1000)
      }
    }
  </script>"
)
map3

```

<iframe chart_1="" height="500" width="800" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
http://rmaps.github.io/blog/posts/animated-choropleths/fig/autochoro.html
"></iframe>

Finally let's see how we can render a very similar map with just one call and far less munging

```
map$set(dom = 'chart_1', newData = dat2, scope = 'usa', fills = fills, legend = TRUE, labels = TRUE)
map

#shows the 1 line of code needed to create 

source('ichoropleth.R')
ichoropleth(Crime ~ State,
            data = datm2[,1:3],
            pal = 'PuRd',
            ncuts = 5,
            animate = 'Year'
)

```

<iframe chart_1="" height="500" width="800" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
http://rmaps.github.io/blog/posts/animated-choropleths/fig/ichropleth.html
"></iframe>

Let's look at a more simple example of a heatmap of crime data applied over a map 
of Houston.  Now the rMaps will use the leaflet.js library to render the maps.  All
customization will be done through leaflet. Notice that the data must be stored in
a JSON in a list rather than directly through a dataframe.

```

###############################
#call a Leaflet map and apply a heatmap on top of it
##############################


library(rMaps)
L2 <- Leaflet$new()
L2$setView(c(29.7632836,  -95.3632715), 10)
L2$tileLayer(provider = "MapQuestOpen.OSM")
L2
#get the data
data(crime, package = 'ggmap')
library(plyr)
crime_dat = ddply(crime, .(lat, lon), summarise, count = length(address))
crime_dat = toJSONArray2(na.omit(crime_dat), json = F, names = F)
cat(rjson::toJSON(crime_dat[1:2]))
#heatmap it
# Add leaflet-heat plugin. Thanks to Vladimir Agafonkin
L2$addAssets(jshead = c(
  "http://leaflet.github.io/Leaflet.heat/dist/leaflet-heat.js"
))

# Add javascript to modify underlying chart
L2$setTemplate(afterScript = sprintf("
<script>
  var addressPoints = %s
  var heat = L.heatLayer(addressPoints).addTo(map)           
</script>
", rjson::toJSON(crime_dat)
))
L2
```
<iframe chart_1="" height="500" width="800" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
http://rmaps.github.io/blog/posts/leaflet-heat-maps/fig/leaflet_heatmap.html
"></iframe>

