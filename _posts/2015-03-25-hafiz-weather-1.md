---
title: "Weather Visualization"
author: "Hafiz Ahsan"
date: "March 25, 2015"
output: html_document
layout: post
description: blog
---
[Hafiz Ahsan](mailto:aha2140@columbia.edu)

### Intro

Weather data is everywhere. Weather is broadcast over Radio and TV. It is part of the news. It is pulled in and displayed on the our PCs and laptops in widgets and status bars. It comes via apps bundled with smartphones. From dedicated websites. From dedicated TV channels. Even from car navigation systems. It might well be the most frequently used (and predicted) time-series data. 

My original intent for the blog was to survey how weather data is presented in mobile apps, find the best-in-class viz and to investigate if we can improve some aspects. I was going to focus only on apps and I needed to know what apps people use. So, I put together a short online survey to understand what people like/dislike about the apps they use and sent it to the class.

 Thanks class! We have 14 responses.  The survey result is [here]({{site.baseurl}}/assets/aha2140/weather/survey-results.pdf). 

There was a surprise in the survey results. For primary source of weather info websites are just as popular as apps (six votes for each). I thought people would use apps more. 

With this new data I expanded my blog scope to include major web sites. In fact, I'll cover websites first.


### Weather sites 

There is a balance that needs to be struck in a weather website. Things that are at play are:

* Audience goal (know today's forecast, see storm/radar map, plan for the weekend, plan a trip)
* Audience skill level for interpreting data (how well they can read a graph)
* Audience expectations (do the expect same information as TV/Radio) 
* Ad dollars

#### Weather.com
It's a very popular site. Alexa US rank: [33](http://www.alexa.com/siteinfo/weather.com). NYT is ranked 30. It is also the most popular among weather-related site. 

Unfortunately, Weather info is about < 5% of the landing page real-estate. On most pages the signal-to-noise-ratio is very low. I am not an expert in site design, but...the box-driven-design-style baffles me. I also don't see the need for the background weather image -- maybe some people like it. Slightly more useful than the landing page is the "Full Forecast" page. Note the big empty space in the middle of the screen. 
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/today.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/today.png" width="50%">
</a>

A bit more useful: Exanded view of a day:
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/expanded.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/expanded.png" width="50%">
</a>

Here is the 10-day view. Note that it shows only seven boxes and you have to scroll/tap to see all 10. 
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/10-day.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/weather-dot-com/10-day.png" width="50%">
</a>



### Weather Underground
Alexa US Ranking: 115, The site has a much cleaner design. I'll highlight only things that caught my eye.

The 10-day graph is busy but is pretty good. It has a lot of promise. I think this will appeal to the data-driven folks. Note the alternate shades for nights, the semantically resonant blue for rain forecast and the innovative use of wind direction on a time series. 
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/wunderground/10-day.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/wunderground/10-day.png" width="70%">
</a>


Here is the full month view. I can see that it would be useful for weekend or trip planning.
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/wunderground/month.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/wunderground/month.png" width="70%">
</a>


### Accuweather
Alexa US Ranking: 128. The  site uses a box-style layout for forecast as well. Background colors of the boxes change with forecast. The descriptions are short and to-the-point. Interesting: highs are in larger font than lows. You can see a 5-day or 45 day forecast. 
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/today.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/today.png" width="50%">
</a>

Here is the 45-day forecast. It reuses the same boxy format.
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/extended.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/extended.png" width="50%">
</a>

The site does have a history/forecast timeseries plot at the bottom of one page. It shows the averages and both history and forecast for 30 days. Unfortunately, it looks like an afterthought.
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/trend-forecast.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/accuweather/trend-forecast.png" width="50%">
</a>



### Forecast.io
Alexa US Ranking: 3,431. Clean and nice UI with some (minor) quirks. However, is for data-driven folks. The main forecast is a bit lower in the page. Not sure why the globe has to be there. I'd not put the globe at the top. The site is free from tacky color and graphics. A relief!

This is the main forecast chart. Maybe the icons could use color. 
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/forecast.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/forecast.png" width="50%">
</a>

An expanded day chart. A bit too reliant on grayscale for my taste. It'd probably be better with a temperature line chart. 
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/today.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/today.png" width="50%">
</a>

These are wonderful line charts for temperature and precipitation forecast. The show the output outputs of different prediction models and an average. I wonder if this would be confusing for an average "consumer" (why five temperature lines?). These charts also expands to full screen. 
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/forecast-lines.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/forecast/forecast-lines.png" width="50%">
</a>


### Google

Someone pointed this out on the survey (thanks!). Searching for weather in Google gives you a very nice weather graph.  It uses SVG/HTML5. Notice that the Y axis does not start at zero. It is probably a necessary trade-off to accommodate the relative ups and downs which are not that extreme. However, there are some semantic resonance issues. The chart is shaded in yellowish-orange and that corresponds to sunlight. Unfortunately periods of rain and cloud under are also shaded orange. Also notice that it shortens an entire day to an icon. It can rain late in the day but it will still be the same icon. 
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/google/search.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/google/search.png" width="70%">
</a>

The chart works in mobile browsers, but without the graphs.
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/google/mobile.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/google/mobile.png" width="40%">
</a>

This is the precipitation view. Semantically resonant colors. Y axis does start at zero.  
<a href="{{site.baseurl}}/assets/aha2140/weather/sites/google/prec.png">
  <img src="{{site.baseurl}}/assets/aha2140/weather/sites/google/prec.png" width="50%">
</a>


### Weather Apps

Let's now switch to Apps. Apps have the added advantage of touch-friendliness. So my expectations from apps are higher. I also think that they will be used more in future and take traffic away from websites. Let's see how they look. 

#### iOS 8

iOS8 weather app is pretty and basic. It has nice small icons and lots of scrolling features. No charts though.
<img src="{{site.baseurl}}/assets/aha2140/weather/apps/weather-channel/screenshots.png">

iOS8 also introduced Weather Widgets. [This](http://9to5mac.com/2014/09/26/ios-8-weather-widgets-best/) post shows reviews the widgets. Here's an image from that post. 
<img src="http://9to5mac.files.wordpress.com/2014/09/iphone-6-weather-widgets.jpg?w=704&h=463" width=" 80%">

#### The Weather Channel App

The landing page wastes 99% of the screen real-estate. Probably on purpose so we need to swipe vertically to see everything else. Probably to make the app more friendly to large-format ads. There is no "Jump to" to see a 5-day or 10-day forecast. Horizontal swiping gives you different places. Also no charts.
<img src="{{site.baseurl}}/assets/aha2140/weather/apps/weather-channel/screenshots.png">


#### Accuweather
Why do weather apps need to be blue and use lots of blue. There is a line chart though. Not clear or easy to interpret, but still.
<img src="{{site.baseurl}}/assets/aha2140/weather/apps/accuweather/screenshots.png">

#### Storm
This app seems to be geared for people tracking storms. It does attempt a line plot. The charts seem busy though. 
<img src="{{site.baseurl}}/assets/aha2140/weather/apps/storm/screenshots.png">

#### Dark Sky

Forecast.io's charts. I am not sold on the "faded globe" background though. Note the "Rain starting in 13 min" warning. Very well done!
<img src="{{site.baseurl}}/assets/aha2140/weather/apps/darksky/screenshots.png" width="100%">


#### Weather Underground
The app does a nice job of spread out text, graphics and map. There are chats. Navigation is not a pain.   
<img src="{{site.baseurl}}/assets/aha2140/weather/apps/wunderground/screenshots.png" width="70%">

The app also uses the landscape mode for larger charts. 
<img src="{{site.baseurl}}/assets/aha2140/weather/apps/wunderground/hourly.png" width="75%">

#### MSN Weather

Thanks to Justin I have some Windows phone screenshots of the stock weather app. Nothing special to report here. Blue overload.
<img src="{{site.baseurl}}/assets/aha2140/weather/apps/msn/screenshot.png" width="80%">



### Recap

Many weather websites have confusing navigation and suffers from graphics overload. Two standout/interesting sites from  visualization point are:
* Google search weather
* Forecast.io 

Apps are a wild bunch. They generall suffer from color and text overload. Very few apps attempt timeseries plots. Maybe people are conditioned to seeing weather in that way and maybe that's also the best way, I am not sure. Standouts are:
* Weather Underground
* Dark Sky 

### An experiment

Here is an attempt to create a weather time series that blends a data-centric view and qualitative information. It's a static image mock up. I started from a Weather Underground chart and gradually added and removed elements. I didn't want to spend a lot of time on figuring out a charting package and instead wanted to focus on the visualization. So, image mock up with paint/gimp seemed like a good idea.  

Here is how it was built:

* Started with Weather Underground time series plot: Temperature line, night and day shades, Midnight line
* Added explicitly values for highs and lows
* Removed lines to make the plot lighter. I think more lines and shaeds can be removed.
* Added a "weather strip" that shows cloud cover and rain and sun. I used the real probabilities from the Weather Underground cloud and precipitation forecasts and rounded them up to remove visual noise. I also tried to be semantically consistent with colors. The weather strip can accommodate weather events like snow or storms using colors and textures. 
* Added descriptive text at the bottom. It is consistent with the forecast strip and provides a quick radio/TV weatherman style narrative.
* Added a one sentence summary. It could as well go to the top.

<img src="{{site.baseurl}}/assets/aha2140/weather/exp1.png">

As for implementing this, I looked around and I couldn't find a library/package that would be an automatic fit. The line plot is easy with many of them but few of them support the area shading to show the nights. The "weather strip" is even harder. I considered using a bar chart with one hour wide bars and same height where colors are set by weather type. It didn't look good so I stopped pursuing it. Please let me know if you can think of an easy way to implement it.
