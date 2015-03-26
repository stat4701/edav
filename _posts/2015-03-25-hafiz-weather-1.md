---
title: "Weather Visualization - State of Play"
author: "Hafiz Ahsan"
date: "March 25, 2015"
output: html_document
layout: post
description: blog
---

### Intro

Why weather visualization ?

Weather is broadcast over Radio and TV. It is part of the news. It is pulled in and displayed on the our PCs and laptops in toolbars and widgets. It comes via apps bundled with smartphones. From dedicated websites. From dedicated TV channels. Even from car navigation systems. In short, we swim in weather data. 

My original intent was to survey how weather data is presented in mobile apps, find the best-in-class viz and to investigate if we can improve some aspects. I was going to focus only on apps and I needed to know what apps people use. So, I put together a short online survey to understand what people like/dislike about the apps they use.

 Thanks class! We have 14 responses.  The survey result is [here]({{site.baseurl}}/assets/aha2140/weather/survey-results.pdf). 

There was a surprise in the survey results. For primary source of weather info websites are just as popular as apps (six votes for each). I thought people would use apps more. 

So, with this new data I expanded my survey scope to include major web sites. In fact, I'll cover websites first.


### Weather sites 

There is a balance that needs to be struck in a weather website. Things that are likely at play

* Audience goal (e.g. know today's forecast, see storm/radar map, plan for the weekend, plan a trip)
* Audience skill level for interpreting data (e.g. how well they can read a graph)
* Audience expectations (e.g. do the expect same information as TV/Radio) 
* Ad dollars

#### Weather.com
* Alexa US rank: [33](http://www.alexa.com/siteinfo/weather.com). NYT is ranked 30. So, this is pretty high. It is also the most popular weather-related site.
* Weather info is about < 5% of the landing page real-estate. On most pages the signal-to-noise-ratio is very low. 
* I am not an expert in site design, but...the boxes baffle me.  I also don't see the need for the background weather image -- maybe some people like it.
* Slightly more useful than the landing page: click on "Full Forecast" which is hard to see (an artifact of the box-style design, I think). 

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/today.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/today.png" width="50%">
</a>

* A bit more useful: Exanded view of a day:

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/expanded.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/expanded.png" width="50%">
</a>

* Here is the 10-day view. Note that it shows only seven boxes and you have to scroll/tap to see all 10. 

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/10-day.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/10-day.png" width="50%">
</a>



### Weather Underground
Alexa US Ranking: 115

Site is much cleaner. 

* A 10-day graph that's busy but is pretty good. 
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/wunderground/10-day.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/wunderground/10-day.png" width="50%">
</a>


* A Full month view. Useful for weekend or trip planning.

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/wunderground/month.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/wunderground/month.png" width="50%">
</a>


### Accuweather
Alexa US Ranking: 128

* The expanded view looks similar. 
* The descriptions are quite good.
* Highs are in larger font than lows. 
* Graphics aren't that crazy

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/today.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/today.png" width="50%">
</a>

* An extended forecast. Useful for planning.

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/extended.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/extended.png" width="50%">
</a>

* A history/forcast timeseries plot. Basic and has a lot of potential if worked on.

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/trend-forecast.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/trend-forecast.png" width="50%">
</a>



### Forecast.io
Alexa US Ranking: 3,431

* Clean and nice UI with some (small) quirks. 
* Nicely done main forecast. A bit lower in the page. I'd put it at the top. 
* Note the lack of color and tacky graphics.

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/forecast.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/forecast.png" width="50%">
</a>


* Expanding a day is also very informative. Great "visualization integerity".
* Would probably be better with a emperature curve.

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/today.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/today.png" width="50%">
</a>

* Forecast lines that exposes the outputs of different models.
* Likely confusing for an average "consumer" (why five temperature lines?)

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/forecast-lines.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/forecast-lines.png" width="50%">
</a>


### Google

* Searching for weather in Google gives you a very nice weather graph. Someone pointed this out (thanks!). 
* SVG/HTML5
* Y axis does not start at zero. A necessary tradeoff that needs to be made to accomodate the relative ups and downs which are not that extreme. 
* Periods of rain and cloud under the curve are still orange (semantic resonance issue?).
* Radar maps are not on the page (but a click away). 

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/google/search.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/google/search.png" width="50%">
</a>

* Also works in mobile browsers. But no graphs.

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/google/mobile.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/google/mobile.png" width="50%">
</a>

* Precipitation view. Semantically resonant colors. Y axis starts at zero (thankfully) 

<a href="{{site.baseurl}}/assets/aha2140/weather/sites/google/prec.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/google/prec.png" width="50%">
</a>


### Weather Apps


#### iOS 8

TODO

#### iOS Weather Widgets

[This](http://9to5mac.com/2014/09/26/ios-8-weather-widgets-best/) post shows the stat of the art for iOS 8 "weather widgets". From that post:

<img src="http://9to5mac.files.wordpress.com/2014/09/iphone-6-weather-widgets.jpg?w=704&h=463" width=" 80%">

#### The Weather Channel App

Screenshots are from iPhone 5s running iOS7. 

* The landing page wastes 99% of the screen real-estate. Probably on purpose so we need to swipe vertically to see everything else. Probably to make the app more friendly to large-format ads.
* There is no "Jump to" to see a 5-day or 10-day forecast.
* Horizontal swiping gives you different places.
* No graphs

<img src="{{site.baseurl}}/assets/aha2140/weather/apps/weather-channel/screenshots.png">


#### Accuweather

Screenshots are from App Store (iOS8). 

* Lots of blue
* One graph, not clear or easy to interpret.

<img src="{{site.baseurl}}/assets/aha2140/weather/apps/accuweather/screenshots.png">

#### Storm

<img src="{{site.baseurl}}/assets/aha2140/weather/apps/storm/screenshots.png">

#### Dark Sky

<img src="{{site.baseurl}}/assets/aha2140/weather/apps/darksky/screenshots.png">


#### Weather Underground

<img src="{{site.baseurl}}/assets/aha2140/weather/apps/wunderground/screenshots.png" width="100%">


<img src="{{site.baseurl}}/assets/aha2140/weather/apps/wunderground/hourly.png" width="75%">

#### MSN Weather

<img src="{{site.baseurl}}/assets/aha2140/weather/apps/msn/screenshot.png" width="80%">



### Recap

* Mass-consumption sites have confusing navigation and suffers from graphics overload. 
* The Best-in-class
   * Google weather strikes a decent balance. 
   * Forecast.io has really good graphs but probably more for data-friendly audience.
