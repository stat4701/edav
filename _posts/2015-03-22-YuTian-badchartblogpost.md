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

The chart needs to be fixed so that it doesn't have any basic construction issues and more is consistent with the report context.

Here is a table with information got directly from the chart and calculations I made accordingly.

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
</style>
<table class="tg">
  <tr>
    <th class="tg-031e">year</th>
    <th class="tg-031e">superstar</th>
    <th class="tg-031e">remainder</th>
    <th class="tg-031e">total</th>
    <th class="tg-031e">superstar_proportion</th>
    <th class="tg-031e">remainder_proportion</th>
  </tr>
  <tr>
    <td class="tg-031e">2000</td>
    <td class="tg-031e">2.72</td>
    <td class="tg-031e">1.11</td>
    <td class="tg-031e">3.83</td>
    <td class="tg-031e">0.710182768</td>
    <td class="tg-031e">0.289817232</td>
  </tr>
  <tr>
    <td class="tg-031e">2001</td>
    <td class="tg-031e">2.71</td>
    <td class="tg-031e">1.1</td>
    <td class="tg-031e">3.81</td>
    <td class="tg-031e">0.711286089</td>
    <td class="tg-031e">0.288713911</td>
  </tr>
  <tr>
    <td class="tg-031e">2002</td>
    <td class="tg-031e">2.53</td>
    <td class="tg-031e">1.01</td>
    <td class="tg-031e">3.54</td>
    <td class="tg-031e">0.714689266</td>
    <td class="tg-031e">0.285310734</td>
  </tr>
  <tr>
    <td class="tg-031e">2003</td>
    <td class="tg-031e">2.36</td>
    <td class="tg-031e">0.92</td>
    <td class="tg-031e">3.28</td>
    <td class="tg-031e">0.719512195</td>
    <td class="tg-031e">0.280487805</td>
  </tr>
  <tr>
    <td class="tg-031e">2004</td>
    <td class="tg-031e">2.37</td>
    <td class="tg-031e">0.9</td>
    <td class="tg-031e">3.27</td>
    <td class="tg-031e">0.724770642</td>
    <td class="tg-031e">0.275229358</td>
  </tr>
  <tr>
    <td class="tg-031e">2005</td>
    <td class="tg-031e">2.39</td>
    <td class="tg-031e">0.87</td>
    <td class="tg-031e">3.26</td>
    <td class="tg-031e">0.733128834</td>
    <td class="tg-031e">0.266871166</td>
  </tr>
  <tr>
    <td class="tg-031e">2006</td>
    <td class="tg-031e">2.43</td>
    <td class="tg-031e">0.83</td>
    <td class="tg-031e">3.26</td>
    <td class="tg-031e">0.745398773</td>
    <td class="tg-031e">0.254601227</td>
  </tr>
  <tr>
    <td class="tg-031e">2007</td>
    <td class="tg-031e">2.36</td>
    <td class="tg-031e">0.77</td>
    <td class="tg-031e">3.13</td>
    <td class="tg-031e">0.75399361</td>
    <td class="tg-031e">0.24600639</td>
  </tr>
  <tr>
    <td class="tg-031e">2008</td>
    <td class="tg-031e">2.28</td>
    <td class="tg-031e">0.73</td>
    <td class="tg-031e">3.01</td>
    <td class="tg-031e">0.757475083</td>
    <td class="tg-031e">0.242524917</td>
  </tr>
  <tr>
    <td class="tg-031e">2009</td>
    <td class="tg-031e">2.18</td>
    <td class="tg-031e">0.68</td>
    <td class="tg-031e">2.86</td>
    <td class="tg-031e">0.762237762</td>
    <td class="tg-031e">0.237762238</td>
  </tr>
  <tr>
    <td class="tg-031e">2010</td>
    <td class="tg-031e">2.07</td>
    <td class="tg-031e">0.64</td>
    <td class="tg-031e">2.71</td>
    <td class="tg-031e">0.763837638</td>
    <td class="tg-031e">0.236162362</td>
  </tr>
  <tr>
    <td class="tg-031e">2011</td>
    <td class="tg-031e">2.1</td>
    <td class="tg-031e">0.64</td>
    <td class="tg-031e">2.74</td>
    <td class="tg-031e">0.766423358</td>
    <td class="tg-031e">0.233576642</td>
  </tr>
  <tr>
    <td class="tg-031e">2012</td>
    <td class="tg-031e">2.12</td>
    <td class="tg-031e">0.65</td>
    <td class="tg-031e">2.77</td>
    <td class="tg-031e">0.76534296</td>
    <td class="tg-031e">0.23465704</td>
  </tr>
  <tr>
    <td class="tg-031e">2013</td>
    <td class="tg-031e">2.17</td>
    <td class="tg-031e">0.66</td>
    <td class="tg-031e">2.83</td>
    <td class="tg-031e">0.766784452</td>
    <td class="tg-031e">0.233215548</td>
  </tr>
</table>

| year	|superstar	|remainder	|total	    |superstar proportion	|remainder proportion|
| ----- |-----------|-----------|-----------|---------------------|--------------------|
| 2000	|2.72	      |1.11	      |3.83	      |0.710182768	        |0.289817232         |
| 2001	|2.71	      |1.1	      |3.81	      |0.711286089	        |0.288713911         |
| 2002	|2.53	      |1.01	      |3.54	      |0.714689266	        |0.285310734         |
| 2003	|2.36	      |0.92	      |3.28	      |0.719512195	        |0.280487805         |
| 2004	|2.37	      |0.9	      |3.27	      |0.724770642	        |0.275229358         |
| 2005	|2.39	      |0.87	      |3.26	      |0.733128834	        |0.266871166         |
| 2006	|2.43	      |0.83	      |3.26	      |0.745398773	        |0.254601227         |
| 2007	|2.36	      |0.77	      |3.13	      |0.75399361	          |0.24600639          |
| 2008	|2.28	      |0.73	      |3.01	      |0.757475083	        |0.242524917         |
| 2009	|2.18	      |0.68	      |2.86	      |0.762237762	        |0.237762238         |
| 2010	|2.07	      |0.64	      |2.71	      |0.763837638	        |0.236162362         |
| 2011	|2.1	      |0.64	      |2.74	      |0.766423358	        |0.233576642         |
| 2012	|2.12	      |0.65	      |2.77	      |0.76534296	          |0.23465704          |
| 2013	|2.17	      |0.66	      |2.83	      |0.766784452	        |0.233215548         |



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

