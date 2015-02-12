---
layout: post
title: mini-assignment
description: mini-assignment
tags: assignments
---

## NYPD Vehicle Collisions

[![](http://media.tumblr.com/f77302b69f17622c7064cc2c50169dfe/tumblr_inline_n1hn0jgPsl1szvr4h.jpg)](http://iquantny.tumblr.com/post/77684693503/visualizing-traffic-safety-as-we-prepare-for)

1. Get the data
1. Aggregate injuries / involvement of vehicles, pedestrians, cyclists in some way
1. Plot your findings by some other feature (vehicle type, borough, cross streets, etc.)
1. Tell us something about date or time of day and traffic crashes.
1. Discuss potential research questions that you could begin to answer with this data — have intersection reconstructions or :traffic_light: (e.g. West End Ave; West 96th St/Broadwayreduced collisions or their severity? Do bike lanes make roads safer for cyclists? Are :bicyclist: a menace to :walking:?


### Extra challenge 1

Get an api key and write a script that makes a query (you can hard code the query, the point is to do away with file snapshots).

### Extra challenge 2

Parse the `(long, lat)` string into numeric longitude and latitude columns.

### Extra challenge 3

Using either the api, a filter, or another snapshot slice, compare to another month, quarter, or year. 

## Disease Cases in the US over time

Use this from WSJ as a starting point.

[![](http://front.dadaviz.com/media/viz_images/the-impact-of-vaccines-on-measles-1423735549.08-5507041.png)](http://graphics.wsj.com/infectious-diseases-and-vaccines/)

The data comes from the CDC, via [Project Tycho](https://www.tycho.pitt.edu). 

1. Get the data for one or more diseases
1. Read the data into R or python
1. Aggregate to years
1. Aggregate to regions
1. Make plots by year and/or week and discuss.

### extra challenge 1

Parse the ‘week’ information into an actual date with Week resolution.

Does the seasonality vary across states or regions?

### extra challenge 2

Plot something from this dataset on a map. Whether a snapshot, some summary, or some comparison, or all of them.
