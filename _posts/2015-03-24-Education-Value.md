---
title: "Monetary Value of Education: Bad graph critique and improvement blog post"
layout: post
output: html_document
description: EDAV bad graph critique and improvement blogpost
---

# What is the worth of your education?
Tony Paek  
March 22, 2015  

## Introduction
***
The graph critique is based on the Economist's article titled *[It depends on what you study, not where](http://www.economist.com/news/united-states/21646220-it-depends-what-you-study-not-where)*. The article presents a scatter plot of the average rate of return on investment from 240 educational institution in the United States (shown below) and makes two following claims.

1. what people studied affects the future earnings of graduates
2. where people study does not affect the future earnings of graduates

<img src="http://cdn.static-economist.com/sites/default/files/imagecache/original-size/images/print-edition/20150314_USC467_0.png" alt="Drawing" style="width: 700px;"/>

## Graph Critique
***
The graph above has many issues, which are addressed below.

### 1. Two Claims in One Graph
The author makes two claims from one graph. The first one is that what people study affects the earnings of graduates. The second is that where people studied does not affect the earnings. I intend to verify if those claims are true, by creating separate graphs that serve to answer those two questions separately.

### 2. Choice of Variables

**X-Axis : Selectivity of a School**

Selectivity is important. However, is it the most important consideration when high schoolers evaluate colleges? Brown University, for example, is more selective in admitting students than Caltech, but do students think Brown would offer better earning potentials compared to Caltech? I disagree. However plagued it may be, the ranking of a university would be a more natural aspect to look at when people consider the potential earnings with the degrees in those colleges.

Therefore, my data exploration will thus noy only look at the selectivity of a school, but also the ranking of a university, graduation rate, its tuition in order to make inference about the correlations of those factors in student's earning potentials. 

**Y-Axis : Average Rate of Return on Educational Investment**

20 year annual average return is calculated as below:

$$ Average Rate of Return = \frac{(Aggregate Earnings of Degree Holder)-(Aggregate Earnings of Highschoolers)-(4Year Tuition)}{(20* 4Year Tuition)} $$

The choice of Y-Axis makes the graph uninformed. I don't think the rate of return on college investement is appropriate. When the graph does not even provide how much it costs to obtain a bachelor's degree at a particular institution, the variable at a y-axis that represents the annual return on average in percentage does not inform me how much an individual insittution would help the graduates earn. The aggregate return on investment over 20 years, on the other hand, would be a better piece of information.

### 3. Direction of Selected Variables

In addition, the direction of the axis was not natural to me. It would seem more natural that more selective schools are located on the right. For features that may be inversely correlated, the direction of the axis changed so that positive slopes are expected.

### 4. Omission of Variables

I'm not sure if it was intentional, but noticeable omissions of data exist in the graph. For arts/humanities data points, data for universities with an admission rate less than 10% do not exist. I think this severely scews the results in favor of engineering/computer science/maths degrees, and also the slope of a curve. I intend to address it by incorporating data points without bias.

## Data Collection
***
**PayScale Data**

Data from *PayScale* that indicated the overall earnings of an institution were extracted. Sources are *[here](http://www.payscale.com/college-roi/)*. Since data were present in one html page, and I just had to merely paste and copy in Excel, and do some data cleaning in Python. 796 colleges were extracted from *PayScale*.

**U.S. News Data**

*U.S. News* had the most comprehensive ranking of national universities. Sources are *[here](http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities)*.

Data were scattered in multiple pages, which necessitated the use of Python + Beautifulsoup to extract data. As the tables were not clean, a lot of exception handling had to be done to correctly scrape data required for analysis. Here is the link to my ipython notebook for scraping the data. 273 colleges were extracted from *U.S. News*.

**Entity Matching**

Matching two universities was the most challenging portion of this project. The only available key values used to match two universities were names. While the names of private universities were more or less consistent, many state universities were represented very differently and inconsistently. Quite a lot of manual work was performed. The code to perform such tasks is shown here.

Eventually, except for 24 colleges that did not have a match, all the universities scraped from U.S. News were merged with data from *PayScale*, so that a comprehensive set of data points is plotted.

Clean data used for the analysis is below.

*[U.S. News College Rank Data + Payscale College Value Data](https://github.com/tonypaek/uni_value/blob/master/uni_rank_int/uni.csv)*

*[Payscale College Value Data Divided by Major](https://github.com/tonypaek/uni_value/blob/master/uni_major/uni_major.csv)*

*[Payscale College Value Data Divided by Career](https://github.com/tonypaek/uni_value/blob/master/uni_career/uni_career.csv)*

The codes used to scrap and process data are *[here]( https://github.com/tonypaek/uni_value/tree/master/Data_Processing)*.

## Impelementation
***

**1. Static Graph (Rank vs ROI)**
A simple static graph(sort of) was created, with the features that let me choose the x-axis variables, which can be accessed *[here](http://tonypaek.shinyapps.io/UniversityValue-rank-static)*.

The codes used to produce the graph above are *[here](https://github.com/tonypaek/uni_value/tree/master/uni_rank_stat)*.

**2. Interactive Graph (Rank vs ROI)**
The graph lets users (i) filter the results by rank, admission rate, graduation rate, tuition cost, name, and (ii) select variables to be displayed for both x and y axis, which can be accessed *[here](http://tonypaek.shinyapps.io/UniversityValue-rank-interactive)*.

The codes used to produce the graph above are *[here](https://github.com/tonypaek/uni_value/tree/master/uni_rank_int)*.

**3. Interactive Graph Organized Grouped by Major **
The graph lets users filter the results by ROI and total tuition, name of university, which can be accessed *[here](http://tonypaek.shinyapps.io/UniversityValue-Major)*.

The codes used to produce the graph above are *[here](https://github.com/tonypaek/uni_value/tree/master/uni_rank_major)*.


**4. Interactive Graph Organized Grouped by Career **
The graph lets users filter the results by ROI and total tuition, name of university, which can be accessed *[here](http://tonypaek.shinyapps.io/UniversityValue-Career)*.

The codes used to produce the graph above are *[here](https://github.com/tonypaek/uni_value/tree/master/uni_rank_career)*.
