---
title: "Bad Graph Critique"
author: "Sam Guleff"
date: "Thursday, March 22, 2015"
output: html_document
layout: post
description: Bad-Graph-Critiquie
tags: assignments, Sam Guleff, leaflet, C#, D3, JavaScript, CSS, Bar Plot, Chord Chart, Sample Code, Presentaiton
---

###Facinating Facts About Wine
In 2012 the world produced approxinately <b>25.7 billion liters of wine</b>.  

####Staggering!

<ul>
  <li >That's about <b>10,280 olympic swimming pools full</b></li>
    <li> Or <b>814 liters per second</b>, every second, all year long.</li>
  <li>Last year Americans' alone consumed <b>324 million cases or 3.9 billion liters of wine</b>.</li>
</ul>

<H3 style="color:#16B73E">Which countries produce the most wine and where is it being consumed?</H3>
<hr>

###Critique of a Bad Chart
The inspiration for this post was a graph I found on a website showing the largest wine producers in the world.  The chart had many poor design choice.

- The pie chart makes it impossible to read numbers, or determine rank.
- Very poor use of colors.
- The article indicates the top 15 but the chart only shows top 10.
- Chart shows a breakout pie chart for no reason.

![](http://i1.wp.com/italianwinecentral.com/wp-content/uploads/Top-15-wine-producing-countries-2014.png)

[Bad Chart Article](http://italianwinecentral.com/top-fifteen-wine-producing-countries-2014/)

<hr>

###Basic Chart Improvement

Showing Top wine producing countries on a dynamic chart

[My D3 Bar Chart](http://embed.plnkr.co/E1Nayp0uliecWs8Hs5bH/preview)

<iframe chart_1="" height="650" width="1000" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
http://embed.plnkr.co/E1Nayp0uliecWs8Hs5bH/preview"></iframe>


###Geospacial Representation of Wine Production With Pop Ups
![](https://raw.githubusercontent.com/sguleff/edav/gh-pages/_posts/sguleff/BlogPostFiles/leafletWineDistribution.png)

###Drilling Down Further 
Representing the production and trade of wine around the world on a dynamic chord chart.

[Awesome Chord Chart](http://embed.plnkr.co/GT3y1l85TOH1bKdMDYDh/preview)

<iframe chart_2="" height="950" width="950" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
http://embed.plnkr.co/GT3y1l85TOH1bKdMDYDh/preview"></iframe>

<hr>

###How can I generate these charts?

To generate this graph I leveraged code from Mike Bostock's D3 sample Gallery on GitHub, as well as some c# code that I will discuss below.

[D3 Bar Chart Code](https://github.com/sguleff/edav/blob/gh-pages/_posts/sguleff/BlogPostFiles/barChart.html)

Using the data from the article  I wanted to better represent the data so my first thought was to show the largest producers on a map as a choropleth map using leaflet.

[R Leaflet Code](https://github.com/sguleff/edav/blob/gh-pages/_posts/sguleff/BlogPostFiles/WineMap.R)

To ease the creation of D3 charts from data, I created a C# D3 library and application that automatically generates the chord chart, bar chart (HTML, Javascript, JSON, and csv objects needed)

[My C# D3 Library](https://github.com/sguleff/edav/blob/gh-pages/_posts/sguleff/BlogPostFiles/SamGuleffCSharpD3Library.cs)

D3  Chord Chart code and data needed to render it.

[My Chord Chart Code](https://github.com/sguleff/edav/blob/gh-pages/_posts/sguleff/BlogPostFiles/chordChart.html)

[My Chord Chart Data #1](https://github.com/sguleff/edav/blob/gh-pages/_posts/sguleff/BlogPostFiles/chordChart.json)

[My Chord Chart Data #2](https://github.com/sguleff/edav/blob/gh-pages/_posts/sguleff/BlogPostFiles/chordChart.csv)

<hr>

### The Pain Part #1
Taking the plunge and trying to code a dynamic chart using D3 is no easy task.  D3 is very complex and offers a variety of charts. The first task was to deconstruct the sample code and determine how to generate the data in the proper format. 

Unfortunately there was no trivial way to get the data into the correct format so I ended up creating a simple C# library and application which now allows a user a simpe method to generate the html, Java Script, JSON, and csv files needed to render the chart.  
*Note that this code is also what I used to generate the dynamic bar chart.

### The Pain Part #2

Now comes the trickiest and most time consuming part:

- finding the missing wine distribution data.
- Where it wasn't available use another source as a proxy 
- Munge and combine the data into a usable form for my library

After an absurd amount of searching and work I was able to collect a lot of the needed information from the following sites:

[US Wine Exports Since 2012](http://www.wineinstitute.org/resources/pressroom/02212013)

 - Had to use population as a proxy for EU to member nation distributions
 - More accurate would have been to use wine consumption which would have been available.
 
[Germany Wine Exports (proxy by revenue)](http://www.statista.com/statistics/266100/wine-revenue-of-german-exports-by-country/)

[Tons of Wine Related Statistics](http://www.oiv.int/oiv/cms/index?rubricId=44538631-7ad2-49cb-9710-ad5b957296c7)
 
[France (but rough)](http://www.english.rfi.fr/americas/20120214-french-wine-and-spirits-exports-soar-record-101-billion-euros)
 
[Finally!! A good source for many countries](http://gain.fas.usda.gov/Recent%20GAIN%20Publications/Wine%20Annual_Rome_EU-27_2-22-2013.pdf)
 
[Argentina Data](http://gain.fas.usda.gov/Recent%20GAIN%20Publications/Wine%20Annual_Buenos%20Aires_Argentina_3-2-2012.pdf)
 
[Chile Wine Data](http://www.vdqs.net/2013Talca/documents/informations/The%20Chilean%20Wine%20Industry.pdf)
 
<hr>

### Wrapping it up

Overall this was a great learning lesson.  Now, with a little refactoring I have some C# code I can use to generate great dynamic graphs for D3.  I may pursue cleaning up the code and rounding out the library to help other windows developers have better access to the great D3 Library.

<H3 style="color:#DD1111">Wow what a crazy amount of work...</H3>

