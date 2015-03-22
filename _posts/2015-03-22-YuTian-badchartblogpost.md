---
layout: post
title: Bad Charts in Music Industry
author: Yu Tian
date: "March 22, 2015"
description: Blog Post & Presentation
tags: Bad Charts, Presentation, Music
---
# *Bad Charts in Music Industry*

## Case I: A Report About "Superstar Effect", A Chart About Nothing...

Here is a chart from the [*report*](http://musically.com/2014/03/04/how-digital-music-services-may-be-fuelling-a-superstar-artist-economy/?curator=MediaREDEF) called "How digital music services may be fuelling a ‘superstar artist economy’", by Stuart Dredge.

![](http://musically.com/wp-content/uploads/2014/03/superstar-music.jpg)

### I. Basic Construction Issues
Let alone how poorly is the chart related to the information it's trying to show, it is junky because of these following construction issues:

* Confusing vertical axis

The vertical axis on the left is repeated, which should be halved instead, therefore makes it hard to read. "$0, $0.5, $1, $1.5, $2, $2.5,..." is the correct version of the vertical axis.

* Data lables are redundant but pointless

With the vertical axis fixed, readers can easily read the number each bar represents, so that the labels on the bars seem to be excessive. The chart will look more neat without them as well.

### II. Message Misalignment

However, the biggest problem of this chart is not telling the story. If you read the article, you'll doubt the that the chart and the article aren't about the same thing at all.

#### *What do we get from the chart?*

* A decreasing trend.

Since the chart is organized in annual order, a very straightforward message is that the total income in music industry and the proportion made by the remainder artists are decreasing from 2000 to 2013. If we read it more carefully, we can see a drop in the amount made by superstar artists as well.

* Proportion for the most recent year.

The stacked column bar does give us an idea about how superstar income and remainder income compared against each other during the years, however, the exact proportiona are hard to read from the absolute amounts except for the most recent year 2013.

#### *What's the idea of the article?*

* Superstar Aritist Economy

One of the key findings of this article is that while artists’ share of total recorded-music income has grown from 14% in 2000 to 17% in 2013, the top 1% of musical works are now accounting for 77% of all those artist revenues thanks in part to a “tyranny of choice” on digital services. One background knowledge is that digital music services were expected to balance the share of income between superstars and the remainder artists as a result of "long tail effect", but it ended up fuelling a "superstar aritist economy" because only a small portion (1%) of the digital catelogue was streamed or purchased seriously. 

From the context, it would be nicer to deliver the message in the chart that the top 1% (superstar) artists continue to earn about 75 percent of total income and this distribution has not changed noticeably despite the Long Tail phenonmenon. Therefore, it would be more appropriate to emphasize the proportions instead of the absolute amounts in the *stacked column chart^{1}*. I would be more interested in how the proportions changed over time, thus I will consider using a *100% stacked column chart^{2}* to show the evolvement in proportions and use a line chart layered on top to show the trends in absolute amounts. 

Note 1: *Stacked column charts* show the relationship of individual items to the whole, comparing the contribution of each value to a total across categories. 

Note 2: Maybe should use *100% stacked column chart* compares the percentage that each value contributes to a total across categories.


### III. How to improve

* Bad choice of stacked column chart

Trying to make it fancy to use stacked column chart but end up messy. (Nice try)



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

