---
title: "Jordan's Blogpost: Breaking down consumer expenditures"
author: "Jordan Rosenblum"
output: html_document
layout: post
description: EDAV bad graph critique and improvement blogpost
tags: assignments
---

## All about my junk chart

I found charts which outline the breakdown of consumer expenditures going back to 2011 from a website called CreditLoan. The original infographics can be found at the link below:

<http://www.creditloan.com/blog/how-the-average-us-consumer-spends-their-paycheck/>

One example from 2011 is below:

![](https://raw.githubusercontent.com/jmrosen155/edav/gh-pages/assets/jordan-blogpost-files/Blogpost_files/figure-html/infographic_example.png)

I found it to be quite difficult to immediately gain any insight from looking at the charts over the years on the above website. Firstly, the infographic contains so many pictures, numbers, and colors, it is difficult to extract any relevant information from the underlying data. Secondly, there is no easy way to compare data over the years. Even a simple bar chart showing how expenditures in various key categories have changed over the years would be helpful. Thirdly, and perhaps most annoyingly, is the inconsistent data presentation formats over the years. For example, in 2009 and 2010, the article presents the data in donut charts which i) have scaling issues, ii) are difficult to read, and iii) have no obvious ordering. Then in 2011 the format changes to a more tabular layout which is slightly easier to read and does have some ordering, but it takes up too much space to absorb in one glance. In other words, I have to scroll up and down to see all of the relevant data. Strangely, data for 2012 seems to be missing (despite the header saying "How Americans spent their income in 2012"). It seems the 2012 data was accidently replaced with data from 2013 in yet another difficult to digest tabular format. To top it all off, there is a 'nice' animated video which lists off percentages for each category again. Sure, some of that data is nice to know, but why not tell me what it means and how it has changed? Raw numbers have little meaning if I have nothing to compare them to. Bottom line, the infographic simply lists out all of the numbers in the Consumer Expenditure Survey in no particular order without providing any interpretation or relative comparison.

## The raw data: cleaning, importing, and formatting

Turns out, the data is released by the Bureau of Labor Statistics and is published on their website annually:

<http://www.bls.gov/cex/>

or

<http://www.bls.gov/news.release/pdf/cesan.pdf>

Getting the data in an easy to use format in R was not trivial but also not terribly difficult. The BLS does release large data tables in .xlsx format, but the data contained in these tables was much more than I needed and the format would not have been easy to use in R (it was designed for use in Excel). Instead, I decided to paste the text data from the pdf file into a tab separated plain-text file. I then had to do a small amount of reformatting before importing the data into R (e.g. removing commas and dollar signs in the numbers so they would not be read in as factors in R and making sure each column was separated by a tab). I then imported the data with column headers and row names. I also had to do a small amount of post processing to convert absolute percentage columns to actual percentages that R can understand (e.g. 3.0% -> 0.03). Lastly, I changed the ordering within the dataframes so that the larger expenditures appear first. This small amount of code for reading in and processing the data is below:


```r
# Read in the data
exp = read.delim('AvgAnnualExp.txt', sep='\t', header=TRUE, check.names=FALSE, row.names=1)
consunit = read.delim('ConsumerUnit.txt', sep='\t', header=TRUE, check.names=FALSE, row.names=1)

#Format percentage columns
exp[4:5] <- exp[4:5]/100
consunit[4:5] <- consunit[4:5]/100

# Change the order of the dataframe so largest category (as of 2013) appears first
exp <- exp[order(exp[3], decreasing=TRUE),]
```

## Onto the visualizations

Now that I have the raw data imported in R, I started experimenting with various ways of visualizing it. For raw consumer expenditure data, I decided that a stacked percentage bar chart by year was the way to go. This way, it is easy to see the breakdown of expenditures in any particular year and see how it changed from year to year on a categorical and overall basis. Edward Tufte and others have noted certain issues with stacked bar charts, especially the difficulty in seeing how various categories of the bar change from one year to the next (since the bars float at different locations in each year). I attempted to solve this issue by putting percentage values within each portion of the stacked bar. This way, it is easy to see how overall expenditutres have changed over the years and it is also easy to see what category contributed to it most. It is much easier to read than having a separate chart for each of the years or 9 categories. Along the way I ran in to a number of issues. Some of what I had to do to clean, transform, and format the data is listed below and is commented in the next code chunk:

- Reshape my data so I could plot it by year and expenditure category
- Arrange the categories in decreasing order based on 2013 so the largest spending category appears first (and make sure the legend has the same ordering)
- Plot the bars as percentages of the total in each year but left the axis as absolute dollar values so total spending trends can be observed as well. It may be a bit misleading looking at the sizes of the stacked bars because the bars themselves are absolute dollar amounts but the percentages inside the categorical bars allow one to compare categorical proportions across years. I realize this may be a bit confusing, but also think it is an worthwhile tradeoff in this case.
- Reformat percentage and dollars so they print nicely in the chart
- Get percentage values to print inside of each individual stacked bar category
- Experiment with text sizes, legend size, and other themes to get the chart to look as clean as possible
- Change the color palette of the charts using RColorBrewer so they do not look like the standard rainbow
- Get the chart as a whole to take up the width of the markdown file

The code for all of the above bullets and the chart itself are below:


```r
# Load ggplot
library(ggplot2)

# Reshaping my data so that I can plot it by year and category
library(reshape2)
datm <- melt(cbind(exp[1:3], Category = rownames(exp[1:3])), id.vars = c('Category'))

library(plyr)

# Get the levels for the categories to be a factor and order the categories
datm$Category = factor(datm$Category, levels = row.names(exp))
datm = arrange(datm, variable, Category)

# Calculate the percentages
datm = ddply(datm, .(variable), transform, percent = value/sum(value) * 100)

# Format the labels and calculate their positions
datm = ddply(datm, .(variable), transform, pos = (cumsum(value) - 0.5 * value))
datm$label = paste0(sprintf("%.0f", datm$percent), "%")

# Plot it
library(grid)
library(scales)
plot1 <- ggplot(datm, aes(x = factor(variable), y = value, fill = Category)) +
  geom_bar(stat = "identity", width = .7) +
  geom_text(aes(y = pos, label = label), size = 5) +
  scale_y_continuous(labels = dollar) + 
  coord_flip() +
  xlab('Year') + 
  ylab('Average annual expenditure') +
  scale_fill_brewer(palette="Spectral") +
  theme(axis.text=element_text(size=20), axis.title=element_text(size=20), legend.text=element_text(size=20), legend.title=element_text(size=20), legend.key.size=unit(1.5,"cm"))

plot1
```

![](https://raw.githubusercontent.com/jmrosen155/edav/gh-pages/assets/jordan-blogpost-files/Blogpost_files/figure-html/figure3.png)

In the above chart, it is pretty easy to tell that the percentage breakdown of consumer expenditures by category has been largely consistent over the last 3 years. For the most part, absolute expenditures in each category are just scaled up or down based on the total expenditure amount. It would have been very difficult to come to this conclusion just from looking at the original 'junk' chart.

I also decided to look at some other data on characteristics of consumer units (e.g. age, number in household, vehicles in household, percentage of households that own a home, and total income before taxes). For example, the average age has moved slightly higher, slightly fewer households own a home, and income has jumped around a bit (largely tracking total expenditures). Most of the data hasn't changed substantially over the last 3 years, though. I was thinking of ways to overlay this data on my previous chart but I determined that adding even more data to that chart might have been too confusing and overwhelming. In the end, I realized that the small changes in age, home ownership, and other factors did not have an observable impact on categorical expenditures (e.g. the slight increase in age did not lead to much more spending on insurance and lower home ownership didn't significantly impact housing expenditures). Over a longer period of time, there probably is some relation, however. Nevertheless, for only 3 years of data, I decided to simply plot a stacked bar chart of total expenditures as a subset income which seems to tell most of the story. The code and chart are below: 


```r
# Getting total expenditures by year
totalexp <- data.frame(colSums(exp[1:3]))
colnames(totalexp) <- c("Total expenditures")

# Getting income and expenditures into the same data frame
income <- t(consunit[7,1:3])
excessincome <- income - totalexp
colnames(excessincome) <- colnames(income)
expinc <- data.frame(t(data.frame(totalexp, excessincome, check.names=FALSE)), check.names=FALSE)
expinc <- melt(cbind(expinc, Category = rownames(expinc)), id.vars = c('Category'))

# Calculate the percentages
expinc = ddply(expinc, .(variable), transform, percent = value/sum(value) * 100)

# Format the labels and calculate their positions
expinc = ddply(expinc, .(variable), transform, pos = (cumsum(value) - 0.5 * value))
expinc$label = paste0(sprintf("%.0f", expinc$percent), "% of income")
expinc$label[expinc$Category == "Income before taxes"] <- ''

# Plot it
plot2 <- ggplot(expinc, aes(x = factor(variable), y = value, fill = Category)) +
  geom_bar(stat = "identity", width = .7) +
  geom_text(aes(y = pos, label = label), size = 5) +
  scale_y_continuous(labels = dollar) + 
  coord_flip() +
  xlab('Year') + 
  ylab('Amount') +
  scale_fill_brewer(palette="Spectral") +
  theme(axis.text=element_text(size=20), axis.title=element_text(size=20), legend.text=element_text(size=20), legend.title=element_text(size=20), legend.key.size=unit(1.5,"cm"))

plot2
```

![](https://raw.githubusercontent.com/jmrosen155/edav/gh-pages/assets/jordan-blogpost-files/Blogpost_files/figure-html/figure4.png)

Over the 3 years from 2011 to 2013, there really isn't much more to add to the story other than changes in income seem to be the driver of changes in expenditures, with total expenditures consistently being about 80% of total income before taxes. Categorical expenditures have tracked total expenditures (confirmed in the first chart above) and total expenditures have tracked total income (confirmed in the second chart above).

Some possibilities for further exploration on data that was not included in the original infographic include looking at the variance of expenditures among consumers instead of just average trends to see if the income gap has widened over the years. The BLS also has more granular data on expenditures (e.g. education, mortgage, etc) and consumer units (e.g. education level, race, region, etc) which may also add to the story.
