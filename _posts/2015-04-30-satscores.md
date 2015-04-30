---
layout: pres
title: SAT Scores for the High Schools in New York City
description: Erin, Maura, Stephen, Xu and Casey's final project. 
tags: slides
---

<section>

## SAT Scores for High Schools in 
## New York City
![](http://www.gogeometry.com/gmat/word_cloud_sat_255.gif)
_[Link to the our project repositiory](https://github.com/eringrand/edavproj)_
</section>


<section>

## The plan:  

1. What were our goals?  What questions did we seek to answer? 
1. Where did we get our data? What are the problems with our data?
1. What parts of the data were interesting?
1. Demonstration of our code.
1. Discussion of our visualizations and results. 
1. What are the next steps?

</section>


<section>
<section>

## Goals
1. Visualizing poverty and other SES metrics with Scholastic Performance Standards.
1. Discover and display any correlations between assement data and community information. 

</section>

<section>
## Questions to Answer: 
1. Is there a correlation between SAT scores and other school information?
1. How do the schools' performance map with poverty and income in New York City?
1. How do the schools' performance relate to teachers', parents', and students' feeling about their experience with the school? 

</section>
</section>



<section>
<section>

## Data Sources 

1. [NYC OpenData SAT Scores 2012](https://data.cityofnewyork.us/Education/SAT-Results/f9bf-2cp4)
1. [NYC OpenData DOE High School Directory 2014-2015](https://data.cityofnewyork.us/Education/DOE-High-School-Directory-2014-2015/n3p6-zve2)
1. [Income by ZipCode](http://zipatlas.com/us/city-comparison/median-household-income.html)
1. [Income by Neighborhood](http://furmancenter.org/research/sonychan/2013-state-of-new-york-citys-housing-and-neighborhoods-report)
1. Class Sizes 2010-2011
1. School Safety Report
1. [Neighborhood Tabulation Areas Shape File](http://www.nyc.gov/html/dcp/html/bytes/dwn_nynta.shtml)

</section>

<section>
## Problems / Issues / Concerns with the Data

1. _Missing data:_ We lose a lot of data from schools that didn't report their scores.
1. _Time:_ The data we're using come from vastly different years.  
1. _Aggregation:_ We had trouble choosing how to aggregate the information in a way that made the most sense. (Zipcodes? Neighborhoods? School Districts? Boroughs?)

</section>


<section>
## Data Columns

_Pulled some variables that we thought might be important._

1. SAT scores: critical reading, math, writing and total out of 1600 scale
1. Avg Household Income
1. School gender ratios, average class sizes
1. Safety concerns

</section>

<section>
## Tools

1. For the data and exploratory plots: R
2. For the map: CartoDB
3. For the survey visualization: Crossfilter

</section>

<section>
## Data Munging

1. [Sample Code - Joinng tables](https://github.com/eringrand/edavproj/blob/master/scripts/join.R)
1. [Sample Code - Exploration plots](https://github.com/eringrand/edavproj/blob/master/scripts/pairsplot.R) 
1. [Sample Code - Correlations](https://github.com/eringrand/edavproj/blob/master/scripts/correlation.R)

</section>

<section>
## Cluster Centers 
_Kmeans cluster center assignments for the SAT scores._

![](https://raw.githubusercontent.com/eringrand/edavproj/master/slides/table.png)

</section>

</section>


<section>
## Visualizations

1. [CartoDB Map](https://stephenra.cartodb.com/viz/128259f8-eedf-11e4-9692-0e018d66dc29/embed_map)
1. [Exploration of Environmental Effects on SAT Score](https://raw.githubusercontent.com/eringrand/edavproj/master/slides/boxplots.png)
1. [Exploration of the Survery Questions](https://github.com/eringrand/edavproj/blob/master/data/2013nycschoolsurvey/survey_analysis.Rmd)
1. [Visualization of Important Survey Questions with SAT Scores](https://github.com/eringrand/edavproj/blob/master/crossfilter/index.html)

</section>

<section>

<section>
### Exploration of Environmental Effects on SAT Score

![](https://raw.githubusercontent.com/eringrand/edavproj/master/slides/boxplots.png)
</section>

<section>

### Basic Correlation Fits

![](https://raw.githubusercontent.com/eringrand/edavproj/master/slides/apclasses.png)
</section>

<section>
### Basic Correlation Fits

![](https://raw.githubusercontent.com/eringrand/edavproj/master/slides/avgsize.png)
</section>
</section>
