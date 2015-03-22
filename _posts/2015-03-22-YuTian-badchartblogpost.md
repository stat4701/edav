---
layout: post
title: Bad Charts in Music Industry
author: Yu Tian
date: "March 22, 2015"
description: Blog Post & Presentation
tags: Bad Charts, Presentation, Music
---

## A Report About "Superstar Effect", A Chart About Nothing...

Here is a chart from the [*report*](http://musically.com/2014/03/04/how-digital-music-services-may-be-fuelling-a-superstar-artist-economy/?curator=MediaREDEF) called "How digital music services may be fuelling a ‘superstar artist economy’", by Stuart Dredge.

![](http://musically.com/wp-content/uploads/2014/03/superstar-music.jpg)

### I. Basic Construction Issues
Let alone how poorly is the chart related to the information it's trying to show, it is junky because of these following construction issues:

* Confusing vertical axis

* Data lables are redundant but pointless

* Unnecessary legend text ???

* Wrong choose of stacked column chart

Trying to make it fancy to use stacked column chart but end up messy. (Nice try)

Stacked column charts show the relationship of individual items to the whole, comparing the contribution of each value to a total across categories. A stacked column chart displays values in 2-D vertical stacked rectangles. A 3-D stacked column chart displays the data by using a 3-D perspective only. A third value axis (depth axis) is not used.

Maybe should use 100% stacked column instead. 100% stacked column charts and 100% stacked column in 3-D charts compare the percentage that each value contributes to a total across categories. A 100% stacked column chart displays values in 2-D vertical 100% stacked rectangles. A 3-D 100% stacked column chart displays the data by using a 3-D perspective only. A third value axis (depth axis) is not used.

### II. Message Misalignment

However, the biggest problem of this chart is not telling the story.

```{r}
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

## rMaps and Leaflet Presentation
[![](https://raw.githubusercontent.com/sguleff/edav/gh-pages/_posts/sguleff/rMapsExample.png)](http://rpubs.com/mbisaha/63535)


## rMaps and Leaflet links to get you started
[![](https://raw.githubusercontent.com/sguleff/edav/gh-pages/_posts/sguleff/rMaps_logo.png)](https://raw.githubusercontent.com/sguleff/edav/gh-pages/_posts/sguleff/rMaps.png)

* [*rMaps*](http://rmaps.github.io)

[![](https://raw.githubusercontent.com/sguleff/edav/gh-pages/_posts/sguleff/Leaflet_logo.png)](https://raw.githubusercontent.com/sguleff/edav/gh-pages/_posts/sguleff/Leaflet_logo.png)

* [*Leaflet*](http://leafletjs.com)
* [*Leaflet for R*](http://rstudio.github.io/leaflet/)

