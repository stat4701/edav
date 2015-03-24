---
layout: post
title:  "EDAV Spring 2015: Chart critique blog post"
date:   2015-03-24
categories: jekyll/updates 
output: html_document
description:  
---

EDAV fun...
====================

The chart in question 
---------------------

### Solar PV installations by state, or pie chart horror

The following graphic is published on GreenTech Media's U.S. Solar Market Insight Research site, found in this [link][GTM]. GreenTech Media is a market research organization that produces research and industry statistics on the Solar Energy industry. 

The chart we wish to focus on for this post is the second figure in the link, titled '2014 Photovoltaic (PV) Installations by State.' 

![alt text](2014pvmap.png)
![alt text](https://raw.githubusercontent.com/Xtines/edav/gh-pages/_posts/assets/2014pvmap.png)


#### Critiques of above chart
The challenges for this particular chart involve conveying a number of data variables (state, capacity installed, installations by market segment) on a geographical map with space and positional constraints.  
 

Here are the weaknesses I find with this chart -

1. **Proportions within pie charts are unclear, especially with doughnut pie charts** - Pie charts generally make it hard to estimate proportions of segments. In this case, this particular pie chart weakness is made worse by these doughnut pie charts since the reader cannot rely on the angles of the segments to estimate their proportion.  


2. **Size of pie charts are misleading the true scale of the data** - for instance, the pie chart representing CA's amount of installations on the upper left is not reflecting its real scale, which is supposed to be almost 10 times as large as that of the pie chart on the bottom right. 

3. **Color scheme does not carry enough contrast** - The various shades of blue used here makes it hard for the eye to distinguish between the darkest blues. 

4. **Missing states** - Not all states' data are represented on this geographical map due to space limitations.



**Suggestions**: 

* A stacked bar graph could convey the same information more effectively and would address issues no. 1. and 2. 

* Pick a more differentiated color scheme to allow for easier distinction between segments rendered in the fill. 



#### JunkChart's Checkup framework

We also reference [JunkChart's][junkchartscheckup] Trifecta Checkup framework to assess how well the above chart conveys information on the question it is supposed to address.   

> The Trifecta Checkup involves three investigations:
> 
> What is the **question**?
> What does the **data** say?
> What does the **visual** say? 
>

With the above framework, we conclude although this chart is addressing its question - how does the amount of and segment proportions of solar installations compare across states? -- with the relevant data, the weaknesses in the visual representation confuse the message delivery and make it hard for the reader to correctly compare the data across states. 



##Notes on preparing the data set


#### Our data source on solar PV data
The following offers a glance at our data set on U.S. solar PV installations which can be downloaded from [The Open PV Project][OpenPV] -


	  zipcode state size_kW   cost date_installed year latitude  longitude
	1    99701    AK   12.00     NA     2014-03-12 2014 64.83732 -147.75328
	2    99712    AK    5.52     NA     2012-07-31 2012 64.89140 -147.68930
	3    99712    AK    6.00     NA     2012-07-23 2012 64.89069 -147.39092
	4    99645    AK    5.17     NA     2012-06-05 2012 61.56611 -149.29988
	5    99501    AK   17.28 110000     2011-05-25 2011 61.21766 -149.89120
	6    99676    AK    6.00     NA     2011-03-06 2011 62.32223 -150.11779
	7    99701    AK    5.00  40000     2010-10-11 2010 64.84196 -147.71795
	8    99709    AK    5.76     NA     2010-08-02 2010 64.83252 -147.90260
	9    36523    AL   25.00 200000     2010-12-11 2010 30.37797  -88.21493
	10   35640    AL   10.00     NA     2010-09-13 2010 34.44877  -86.96241
	11   35033    AL    5.50     NA     2010-06-28 2010 33.96190  -87.04244


#### Getting the data in shape in R
Here are some steps needed to prepare our data in R before we made our visualizations:


Adding a variable that categorizes solar installations by market segment  or project size (residential, commercial, utility-scale)-


	data <- rawdata %>%
  	mutate(costperwatt = cost/(size_kW*1000)) %>% 
  	mutate(segment=ifelse(between(size_kW, 0, 10), 'residential',
                ifelse(between(size_kW, 10, 200), 'commercial',
                       ifelse(between(size_kW, 200, 30001), 'utility-scale', 'NA'))))

Grouping data by state and year; Adding a variable that sums up statistics by state-

		group_stateyear <- data %>%  
  			group_by(state, year) %>%
  			arrange(state)  %>%
  			summarize(
    		num_installs =n(),               
    		capacity_bystate =sum(size_kW),   
    		mean_costperwatt =mean(costperwatt,na.rm = TRUE)) 



#### Attempts to convey 2014 data in original chart, as well as multi-year data

We try a few plots and lay out the goals of these charts.  


#####Attempt 1: 
*   Convey amount of solar installations by all states in 2014

![alt text](Chart1-2014installs.png)
![alt text](https://raw.githubusercontent.com/Xtines/edav/gh-pages/_posts/assets/Chart1-2014installs.png)

*   Convey amount of solar installations by all states in 2014 broken down by project segment represented with the fill (in color)
![alt text](Chart1-2014bysegment.png)
![alt text](https://raw.githubusercontent.com/Xtines/edav/gh-pages/_posts/assets/Chart1-2014bysegment.png)


#####Attempt 2: Facet grid by year
* Convey amount of solar installations by states over all years, broken down by project segment represented with the fill (in color)


'''allyearssegm <- data %>%
  arrange(state, segment)

ggplot(data=allyearssegm, aes(x=state, y=size_kW, fill=segment)) +
  geom_bar(stat="identity", binwidth=0.5, position="stack") +
  #scale_x_discrete(limits = rev(levels(data$state))) +
  scale_y_continuous(limits = c(0, 40000)) +
  ylab('Capacity installed - by year 2010-2015 YTD') + xlab('State') +
  scale_fill_brewer(palette="Set2")+ 
  coord_flip() +
  facet_grid( ~ year) +
  theme(axis.text.x=element_text(size=8, angle=60, vjust=.3, hjust=0.3))+
  theme(axis.text.y=element_text(size=9))'''


![alt text](Chart2-Barplot_faceted_byyear.png)
![alt text](https://raw.githubusercontent.com/Xtines/edav/gh-pages/_posts/assets/Chart2-Barplot_faceted_byyear.png)






#####Attempt 3: 
*   Convey solar installations by states over all years, broken down by project segment represented with the fill (in color)


**Benefits of small multiples plotting**

By lining up multiple visualizations, small multiples effectively allow for direct comparisons to be made with little effort.

[Flowing Data's][flowingdata] post on small multiples sums up the benefits of this plotting method -  

<The key idea is to slice up your data and use a separate plot to <visualize each slice. The <end result is a grid of charts that all <follow the same visual format, but show different <pieces of the data. <Essentially, a chorus of little stories to help tell a bigger one.

<While the concept is simple, the benefits can be significant. Compared <to a single larger <chart, small multiples can help with over-plotting <— when data is obscured or occluded <because there are too many plotted <items.

<Compared to animation, small multiples present all of the data at once <making it easier for <viewers to naturally compare each facet with <others, instead of trying to flip back and <forth between views.


![alt text](Chart3-Facetwrap_bystate.png)
![alt text](https://raw.githubusercontent.com/Xtines/edav/gh-pages/_posts/assets/Chart3-Facetwrap_bystate.png)


The problem with the above chart is that the y scale is fixed across states which makes it hard to see the y variables for some states where the values are small. 

We can change the scale to a free y-scale to allow for a better viewing of trends over the years within each state. 
The drawback here is the small multiple plots across states are not comparable in scale anymore. 

	ggplot(data=allyearssegm, aes(x=year, y=size_kW)) +
	geom_bar(aes(fill=segment), stat="identity")+
	scale_y_continuous(labels = comma) +
	facet_wrap(~ state, scales= "free_y") + 
	xlab('Year:2010-2015 YTD') + ylab('Capacity installed (kW)')+ 
	theme(axis.text.x=element_text(size=8, angle=60, vjust=.2, hjust=0.2))
	

![alt text](Chart3b-Facetwrap_bystate_freescale.png)
![alt text](https://raw.githubusercontent.com/Xtines/edav/gh-pages/_posts/assets/Chart3b-Facetwrap_bystate_freescale.png)



### Challenges that remain for small multiples charts

While the above charts may do a better job than the original chart in terms of allowing comparisons of installation amounts and installation segments across states, there remain weaknesses. 

The small plot area in small multiples can be limiting as it can be difficult to cram in additional data details/scale labels given the limited plot sizes. 


Next step suggestions: 
One way to improve the above small multiple chart would be to add layering interactions to allow for a closer study of the data details upon interaction without cluttering the whole chart with too much information.
 
An example might be allowing some parts of the graph to be highlighted as the mouse hovers to bring a visual element to the forefront for comparison, or connect the small plots in some way.




[junkchartscheckup]: http://junkcharts.typepad.com/junk_charts/junk-charts-trifecta-checkup-the-definitive-guide.html

[GTM]: http://www.greentechmedia.com/research/ussmi 

[OpenPV]: https://openpv.nrel.gov/search

[flowingdata]: https://flowingdata.com/2014/10/15/linked-small-multiples/
