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
+ Show a histogram of the Total 4 Year cost of all colleges labeling Public vs. Private. 

#My Plots
![Return on Investment For Public and Private Colleges](https://raw.githubusercontent.com/lm2221/edav/gh-pages/_posts/assets/Lauren/figure_1.png)

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


+ Code to plot graphs using python and ggplot.