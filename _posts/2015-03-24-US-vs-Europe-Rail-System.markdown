---
layout: post
title:  "US Rail System vs Europe"
date:   2015-03-24
---

<h3> Source article: <a href='https://www.aei.org/publication/mind-the-gap-us-and-european-train-safety/'>Mind the gap: US and European train safety</a> </h3>

The author  states in the blog, 
 <blockquote>   "A good measure of safety is passenger miles traveled per reported passenger injury (defined here to include fatalities). A higher number is better: It means that a passenger can travel more miles before expecting to face an injury." </blockquote>

![Here is the chart I am critiquing](/assets/source_chart.jpg)

In the blog, the author attempts to show the bad condition of the US passenger train system by comparing passenger miles traveled per reported passenger injury with the worst rated rail systems of European countries. This is done using a time-series line graph that presents miles traveled for the US and the 6 European countries with the worst rated rail systems. </p>

With the graph, the author aims to demonstrate to the reader the frequency in which injuries occur in the rail system of the US as compared with the six worst rail systems in Europe for each of the years between 2004 and 2012.

Although the chart seems to passably carry the intended message, it still required a close look and deeper observation to completely understand its intent. The choice of the line chart is one of the reasons for the confusion of the reader. When I first saw the chart, I immediately began to look for year-to-year changes in miles travelled per reported injury, for each of the countries instead of looking to compare the y-values of each country against the US. I believe the message can be better carried with a grouped/stacked bar chart or an area chart. 

Here is an example of a slightly better chart with the data for all the countries in one plot:

<a href="https://github.com/EHDEV/ehdev.github.io/blob/master/assets/grouped_all.png"><img src="http://github.com/EHDEV/ehdev.github.io/blob/master/assets/grouped_all.png" width="685" height="450" /> </a>

But this still runs into the problem of too much information in one plot that may distract the reader.

Also, while the author intends to compare the US against the lowest ranked countries in terms of their rail systems, he inadvertently leads us to compare each country with one another by putting everything in one chart. Instead, the author could make a better and stronger statement with six plots that show the numbers for the US vs. each of the other countries, as I will demonstrate below.

Lastly, I must object to the choice of colors and dashed lines in the graph. Even though, the author tried to make the US data distinct by using a solid red line, the dashed lines for the other countries and the colors of the lines make the graph confusing. It's not very easy to identify the countries in the graph.

Although they take up relatively more space, these six charts are better because we can better compare the US's rail system against each of the countries. The contrast between the US and the other countries is clearer and more dramatic.


<a href='https://github.com/EHDEV/ehdev.github.io/blob/master/assets/plots.png'><img src="https://github.com/EHDEV/ehdev.github.io/blob/master/assets/plots.png" width="685" height="450"/></a>

and alternative visualizations:

<a href='https://github.com/EHDEV/ehdev.github.io/blob/master/assets/alt_bar.png'><img src="https://github.com/EHDEV/ehdev.github.io/blob/master/assets/alt_bar.png" width="50" height="50"/></a>
<a href='https://github.com/EHDEV/ehdev.github.io/blob/master/assets/alt_line.png'><img src="https://github.com/EHDEV/ehdev.github.io/blob/master/assets/alt_line.png" width="50" height="50"/></a>

Here is the <a href="https://gist.github.com/EHDEV/c250eb4b860966572899"> R source code for the plots </a>.
