---
title: "Data Visualization Blog on World GDP Growth"
author: "Sankara Rao Grandhi"
date: "Sunday, March 22, 2015"
output: html_document
---

World Bank's GDP Growth Chart
=================================

World Bank manages Open Data Source, which incorporates various indicator values of development in countries around the globe. This database describes their data through both tables and visualizations. Unfortunately, some of the charts are difficult to understand. For example, the world GDP chart has over 200 trends without any labels, and it is difficult to match the values with overlapping trends when moving the cursor to the point.

http://databank.worldbank.org/data/views/reports/chart.aspx


![]({{ an image of junk chart }}/assets/World_GDP_junk_chart.png)


GDP Growth Chart Plot Using rworldmap package
==================================================

These data visualizations below are drawn from the same data as the original  chart, but instead the GDP values are plotted on a world map. Based on GDP value ranges, the countries are color coded with heat colors. Each visualization map charts a specific year from 2000 to 2012. All of these aspects makes the data much clearer than the original chart.



```r
library(rworldmap)


ddf <- read.csv("c:/test/un_gdp_growth_map.csv", sep=",")
ddf <- melt(ddf, id = 'Country')


#create a map-shaped window
mapDevice('x11')
#join to a coarse resolution map
spdf <- joinCountryData2Map(ddf, joinCode="NAME",  nameJoinColumn="Country")

mapCountryData(spdf, mapTitle='YR2000', nameColumnToPlot="value", catMethod="fixedWidth")

```
Year 2000 GDP Growth Chart
============================
![]({{ an image YR2000 }}/assets/YR2000.png)

Year 2001 GDP Growth Chart
============================
![]({{ an image YR2001 }}/assets/YR2001.png)

Year 2002 GDP Growth Chart
===============================
![]({{ an image YR2002 }}/assets/YR2002.png)

Year 2011 GDP Growth Chart
===================================
![]({{ an image YR2011 }}/assets/YR2011.png)

Year 2012 GDP Growth Chart
============================
![]({{ an image YR2012 }}/assets/YR2012.png)


