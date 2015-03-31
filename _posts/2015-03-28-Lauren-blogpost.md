#git add .
#git commit -m "added graph"
#git push origin gh-pages
---
layout: post
title:  "EDAV Spring 2015: Chart critique blog post"
date:   2015-03-29
categories: jekyll/updates 
output: html_document
author: Lauren McCarthy
---

![20 Year Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/chart.png)

#Graph Critique

+ x and y axis do not start from zero making the seperation of the data exaggerated.
+ Wrong data point: MIT is shown as a public college.
+ Does not show all the data.
+ Data uses 20 Year Net Return on investment excluding financial aid.

#Improvements

+ Use data to inlcude % of Annual ROI including financial aid. The % of Annual ROI is the % of expected ROI recieved every year after graduation.
+ Show the first plot with x-axis and y-axis starting from zero as well as with % of Annual ROI vs Total 4 Year cost
+ Show a histogram of the Total 4 Year Cost of all colleges labeling Public vs. Private. 
+ Show the average ROI and average 4 Year Cost of Private vs. Public Colleges.

#My Plots
##In all plots Blue represents a Private School and Red represents a Public School
![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/figure_1.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/figure_2.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/figure_3.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/figure_4.png)

#Analysis

+ Scatter Plot: Updated Graph does not show as much of a differentiation between Public vs. Private Colleges.
+ Histogram: Shows the distribution of the 4 Year Cost of Colleges Private vs. Public. As we can see Private colleges are much more distributed at the higher prices than public.
+ Density Graphs: I found the density graphs to have the most useful information. While it shows a differentiation between the cost of the Public colleges vs the private colleges. The ROI Density graph shows that they pick generally in the same place showing that there is not much of an advantage to go to a private school in terms on ROI. This could also be due to the fact that in general Private schools give much larger Financial Aid packages therefore, despite the schools being expensive the average ROI will have the Finacial Aid factored in.

#Conclusion

+ Make sure your graphs are using the correct axis to not exaggerate the results
+ Sometimes more plots but simple plots are better than complicated graphs
+ Sometimes a more general conclusion can be better than a very specific one. For example: In general the return on investment for Private colleges is better than Public vs. The Best return on investment is from this one specific college.

#Code

+ Code using python to clean up the data.

```
with open('data_percents.csv', 'w') as f:
    i = 0
    for line in open('raw_data_percents.tsv'):
        if i == 0:
            # skip this line, it's the rank
            i += 1
            continue
        elif i == 1:
            if line.startswith("("):
                continue
            else:
                a = line.split("\t")
                name = a[0].replace(",","")
                private = 1 if 'Private' in a[1] else 0
                i += 1
        else:
            a = line.split("\t")
            roi = float(a[0][:-1].replace("<", ""))
            cost = float(a[1][1:].replace(",", ""))
            i = 0

            f.write("%s,%s,%s,%s\n" % (name,private,roi,cost))
```


+ Code to plot graphs using python and ggplot. This is a work in progress. I was not able to get the legends to show up on the plot. It seems that these should show up automatically. I will continue to work on this. I would also like to use a more sophisticated packing so that when scrolling over the data the feature will automatically appear. To be continued...

```
from ggplot import * 
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt

df=pd.read_csv('data_percents_2.csv',sep=',', header=None, names=['College','Private','ROI','Cost'])

p_1=ggplot(df, aes(x='Cost',y='ROI', color='Private')) + geom_point() + labs("Total 4 Year Cost","% "+"Annual Return on investment") + ggtitle("Private vs. Public Colleges Cost vs ROI")+ xlim(25000,250000)
p_2=ggplot(df, aes(x='Cost',fill='Private'))+ geom_histogram() + labs("Total 4 Year Cost")+ggtitle("Private vs Public Collages 4 Year Cost")
p_3=ggplot(df, aes(x='Cost',color='Private')) + geom_density() +labs("Total 4 Year cost", "Denisty")+ggtitle("Density Graph for Private vs. Public")
p_4=ggplot(df, aes(x='ROI',color='Private')) + geom_density() +labs("ROI","Density")+ggtitle("Density Graph for ROI Private vs Public")

```

