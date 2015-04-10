---
author: Dennis Lyubyvy
layout: post
description: mini-assignment
---

### The average temperature for the hospital
_Blogpost by Denys Liubyvyi, dvl2110_

![The average temperature for the hospital]({{ site.baseurl }}/assets/dennis_blogpost/12pcs-lot-LCD-Home-and-Baby-digital-Electronic-font-b-thermometer-b-font-baby-temperature-font.jpg)

The normal temperature for the individual is 98.6 °F. However for the population of people the average temperature is totally absurd thing. In Russian language “the average temperature for the hospital” is an established metaphor for lying statistics. 

In many situations we see plotted mean or median (somehow better) of the our data, which doesn’t represent the true data distribution. 

One of the example I have met is the map of median NYC restaurant grading on [IQuantNY](http://iquantny.tumblr.com/post/76928412519/think-nyc-restaurant-grading-is-flawed-heres) blog: 

![Median restaurant score]({{ site.baseurl }}/assets/dennis_blogpost/map.jpg)

Here is the problem I have with this map: I don’t really understand what it gives to me. Should I consider not going to restaurants in red zip codes? Should I move to live to Staten Island? How dangerous are red zones and how safe are green ones?

The average level as an indicator doesn’t allow me to understand what is really going on. 

Let’s apply The Trifecta Checkup framework to analyse [this map](http://junkcharts.typepad.com/junk_charts/junk-charts-trifecta-checkup-the-definitive-guide.html). The framework involves three investigations: 

*	What is the QUESTION? 
*	What does the DATA say?
*	What does the VISUAL say? 

__What is the QUESTION? __
The question is probably what zip codes are the most dangerous in terms of restaurant’s sanitary 

__What does the DATA say?__
The data says what restaurants are the most 

__What does the VISUAL say? __
The visual says the average of the score, which doesn’t allow me to detect if all of the restaurants have the similar score or some of them are bad and some are good. Since I am oriented as a customer to good ratio of price and value I should probably look for the zip code with minimal ratio of the bad-scored restaurants.

As alternative, I propose to work with quintiles of the data. Particularly, to plot not the mean/median but the share of the most disturbing quartiles. In this case it’s a grade C for the restaurants. 

![Percentage of C restaurant score]({{ site.baseurl }}/assets/dennis_blogpost/dennis_map.png)

This map highlight with red color zip codes with the highest probability to find the C-grades restaurant. The zones somehow different (it is clear if you see at Staten Island) and in my opinion more representative. 

Let’s find some more example of “don’t use blindly the mean or median” thesis. 

Here is the plot from the [Washington Post](http://www.washingtonpost.com/local/making-time-for-kids-study-says-quality-trumps-quantity/2015/03/28/10813192-d378-11e4-8fce-3941fc548f1c_story.html) article describing that people spending more time with kids: 

![Time with kids]({{ site.baseurl }}/assets/dennis_blogpost/wp.png)

It’s seems like people tent to spend much more time with kids now than in 1975. Especially men. But can we blindly trust this data? How can we interpreter it? 

Let’s look at the following plot:

![Average working hours]({{ site.baseurl }}/assets/dennis_blogpost/Rplot03.png)

It’s average working hours per week of responders of General Social Survey since 1973. The growth itself looks pretty scaring, however the absolute value doesn’t. Because this is the mean. How we plot differently the same data? We can plot the percentage of people working more than 40 hours per week and look how did that changed. 

![Percentage of people with high working hours]({{ site.baseurl }}/assets/dennis_blogpost/Rplot05.png)

As you can see, percentage of people working hard didn’t change so dramatically as average hours, which ones again confirm the thesis that average estimation should be used with a great care.

The best approach that allow us to explore the data and getting answers to all questions proposed by interactive approach of Shiny: you can tune the plot until you show the 

<iframe style="border: none; width: 1000px; height: 1150px;" src="https://denniskorablev.shinyapps.io/census-app/" width="1600" height="1000"></iframe>

I believe this approach should be used in as many cases as possible when we are trying to make an exploratory data analysis.


