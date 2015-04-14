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
![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/Colleges_Scatter.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/Collages_Histogram_Cost.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/Colleges_Histogram_ROI.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/Denisty_Cost.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/Density_ROI.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/Top_25_Cost_bar.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/Top_25_ROI_bar.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/Top_25_Cost_label.png)

![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/Top_25_ROI_label.png)

#Analysis

+ Scatter Plot: Updated Graph does not show as much of a differentiation between Public vs. Private Colleges.
+ Histogram: (1) Shows the distribution of the 4 Year Cost of Colleges Private vs. Public. As we can see Private colleges are much more distributed at the higher prices than public. (2) Shows the distribution of the ROI of Colleges Private vs. Public. As we can see the highest ROIs are actually from Public colleges.
+ Density Graphs: I found the density graphs to have the most useful information. While it shows a differentiation between the cost of the Public colleges vs the private colleges. The ROI Density graph shows that they pick generally in the same place showing that there is not much of an advantage to go to a private school in terms on ROI. This could also be due to the fact that in general Private schools give much larger Financial Aid packages therefore, despite the schools being expensive the average ROI will have the Financial Aid factored in.
+Last I tried to make different plots just showing the top 25 highest ranking in Total 4 Year Cost and ROI. With less data, it seems to confirm what our other plots are saying without an overwhelming amount of data.
+The label posts are not the most pretty graphs, however, I like that they provide a little more information and still show the distribution of Private vs Public pretty well.

#Conclusion

+ Make sure your graphs are using the correct axis to not exaggerate the results
+ Sometimes more plots but simple plots are better than complicated graphs
+ Sometimes a more general conclusion can be better than a very specific one. For example: In general the return on investment for Public vs Private colleges is not much different; where a very specific conclusion is the the best return on investment is from the University of Virginia, a Public College.

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
#This file reads in the csv manually cleaned up data and plots using ggplot
from ggplot import * 
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt

df=pd.read_csv('data_percents_fixed.csv',sep=',', header=None, names=['College','Type','ROI','Cost'])

#plots simple (ALL DATA)
p_1=ggplot(df, aes(x='Cost',y='ROI', color='Type')) + geom_point() + labs('Total 4 Year Cost','% '+'Annual Return on investment') + ggtitle('Private vs. Public Colleges: ROI vs Cost')
p_2=ggplot(df, aes(x='Cost',fill='Type'))+ geom_histogram(alpha=0.75) + labs('Total 4 Year Cost')+ggtitle('Private vs Public Collages: 4 Year Cost')
p_3=ggplot(df, aes(x='ROI',fill='Type'))+ geom_histogram(alpha=0.75) + labs('ROI')+ggtitle('Private vs Public Collages: ROI')
p_4=ggplot(df, aes(x='Cost',fill='Type')) + geom_density(alpha=0.75) +labs('Total 4 Year Cost', 'Denisty')+ggtitle('Density Graph for Cost: Private vs. Public')
p_5=ggplot(df, aes(x='ROI',fill='Type')) + geom_density(alpha=0.75) +labs('ROI','Density')+ggtitle('Density Graph for ROI: Private vs Public')


#plots top 25
#top ten ROI
sort_ROI=df.sort_index(ascending=[False], by = ['ROI'])
top_25_ROI=sort_ROI.head(25)

#top ten 4 Year Total
sort_4Year=df.sort_index(ascending=[False], by = ['Cost'])
top_25_4Year=sort_4Year.head(25)


#plot top 25 with names
p_6=ggplot(top_25_ROI, aes(x='Cost', y='ROI', label='College', color='Type')) +geom_text(angle=25,size=7.5) + labs('Total 4 Year Cost','% '+'Annual Return on investment') + ggtitle('Top 25 ROI: Private vs. Public')+ylim(13.5,18.7)+xlim(25000,250000)
p_7=ggplot(top_25_4Year, aes(x='Cost', y='ROI', label='College', color='Type')) +geom_text(angle=25,size=7.5) + labs('Total 4 Year Cost','% '+'Annual Return on investment') + ggtitle('Top 25 Cost: Private vs. Public')

p_8=ggplot(aes(x='Cost', fill='Type'), data=top_25_4Year) + geom_bar() +labs('Total 4 Year Cost','Count')+ggtitle('Top 25 Cost: Private vs Public Collages')
p_9=ggplot(aes(x='ROI', fill='Type'), data=top_25_ROI) + geom_bar() + labs('ROI','Count')+ggtitle('Top 25 ROI: Private vs Public Collages')


```

