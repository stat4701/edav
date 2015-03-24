---
title: "Hafiz's Hack - NYC vehicle collision data exploration"
author: "Hafiz Ahsan"
output: html_document
layout: post
description: mini-assignment
tags: assignments
---

Here is a first-cut time-domain analysis of the vehicle collisions data. 


[Rendered R Markdown]({{site.baseurl}}/assets/aha2140/collision-analysis-1.html)


[R Markdown source]({{site.baseurl}}/assets/aha2140/collision-analysis-1.rmd)


It would interesting to further explore the relationship between the weather phenomena and vehicle collisions. The data already shows that snow days have an outsized effect and we can already see that from the data. I have been living and driving around NYC for last 16 years and my hunch is that weather definitely plays a role. For example, I noticed that the first significant snowfall of the year causes a lot of accidents. Sleet and black ice are also big contributing factors. So, it would be great to see what this dataset say about that. 

To that end, I've reached  out to the folks who run [forecast.io](forecast.io).  They confirmed that we can get historical hourly weather data (temperature, pressure, rainfall etc) using their API. It looks like Weather Underground has a nice API so that could work as well. If you ahve spare cycles and want to work on this please shoot me an email.


One final nugget. It's about [S-N-O-W-M-A-G-E-D-D-O-N 2015](http://nypost.com/tag/snowmageddon-2015/) (que to Jon Stewert doing a facepalm). We had this great weather non-event event at the end of January. Interesting fact: it had an outsized effect on vehicle collision rates. Of course! NYC was forced off the roads and the number of collisions took a dive (exercise to the reader: spot that in one of the plots). 

