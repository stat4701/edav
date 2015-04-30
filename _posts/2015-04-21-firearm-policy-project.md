---
title: "Firearm Homicide and Demography: Do Gun Laws Matter?"
layout: post
output: html_document
---

# Firearm Homicide and Demography: "Do Gun Laws Matter?"

Carmem Domingues, Labib Fawaz, Lauren McCarthy, Michael Bisaha

April 21, 2014

## Introduction
***

[HERE IS A LINK TO OUR PROJECT REPO](https://github.com/mbisaha/edav_final_project)

For our project, we wanted to explore firearm policy in the United States and evaluate any sort of correlation that existed between the strictness of gun laws in a state and the number of observed firearm homicides (as well as homicides in general). Our original discussions were international in focus, comparing various countries on their national homicide rates to their gun policy choices. However, after reviewing available data sources, we found we would have better luck exploring the same topic internally within the US. Not only would we have 50 different gun policies for each state, but we would also be able to find much more granular data at the county level than we would have had internationally.

The primary data source we needed to find was a indicator of gun law strictness for each state. We didn't have enough expertise in gun policy to generate a ranking ourselves, but luckily we found an index that specializes in tracking gun policies.

[Gun Law Index Data](http://www.bradycampaign.org/2013-state-scorecard)

The remainder of the data was relatively easy to find through various government sources, but pulling that information from those sites and standardizing it to fit a county-by-county model for gun homicide was another matter.

[Homicide Data](http://www.icpsr.umich.edu/icpsrweb/content/NACJD/guides/ucr.html)

[Census Demography Data](http://quickfacts.census.gov/qfd/download_data.html)

[Unemployment Data](http://www.bls.gov/lau/#cntyaa)

Once we identified the data sources we'd be working with, there was an impressive amount of data munging to do. The data wasn't always clean or complete, and more importantly we had to spend a great deal of time matching up state and county names across separate datasets to piece together a full picture. Some datasets had well-defined county codes that could be applied across multiple fields, but others required matching up text identifiers with with different spellings and encodings.

Here is a sample of some importing/cleaning done in Python - 

```python
#!/usr/bin/python

import sys
sys.path.append('./')

# Input file: race_2010_input
# 
# Input format (codes): 
# 01001|Autauga County, AL
# 01003|Baldwin County, AL
#
# Input format (state_abbreviations):
# Alabama	AL
# Alaska	AK
# 
# Output format: 
# 01001|Autauga County|Alabama
# 01003|Baldwin County|Alabama

def mapper(argv):

	state_dict = {}

	f = open('state_abbreviations', 'r')
	for l in f:
		name, ab = l.strip().split("\t")

		if ab not in state_dict:
			state_dict[ab] = name

	errors = 0
	for line in sys.stdin:
		try:
			data = line.strip().split("|")
			code = data[0]
			data1 = data[1].strip().split(',')
			if len(data1) == 2:
				county = data1[0]
				state = state_dict[data1[1].replace(" ","")]
				print "%s|%s|%s" %(code, county, state)

		except Exception as e:
			errors += 1
			e = sys.exc_info()[0]
			sys.stderr.write("\nERROR Mapper:  %s **** %s" % (line,e))
			continue

	# print "errors %d" %(errors)

if __name__ == '__main__':
   mapper(sys.argv)
```

Still more cleaning/importing in R...

```R
##read in census data 
CensusDemo <- read.csv(path.expand("~/Desktop/dataset.txt"), header=TRUE, sep=",")
fipsIDs <- read.csv(path.expand("~/Desktop/FIPS_CountyName.txt"),header=FALSE,sep=">")
CensusCols <- read.csv(path.expand("~/Desktop/tables_to_keep_just_nums.txt"),header=FALSE,sep=",")

CensusDemo <- CensusDemo[-which(CensusDemo$fips %in% c(1:56*1000)),]
CensusDemo <- CensusDemo[-1,]

MyCensusData <- CensusDemo[,c(1,which(colnames(CensusDemo) %in% as.character(CensusCols[,1])))]

colnames(MyCensusData) <- c("CountyID","Population2013", "Population2010", "PopU52013", "PopU182013", "PopO652013", "FemalePercent", "WhiteAlonePercent", "BlackAlonePercent","NativeAmAlonePercent", "AsianAlongPercent", "PacIslandPercent", "MultipleRacesPercent", "HispanicPercent", "WhiteNonHispanicPercent", "HighSchoolPlusPercent", "BachelorsPlusPercent", "BelowPovertyPercent", "NonfarmEmployment2012", "PopPerSqMile2010")

for (i in 1:1835) {
    fipsIDs$Name[i] <- substr(fipsIDs[i,1],7,nchar(as.character(fipsIDs[i,1])))
    }

fipsIDs$Name[1836] <- NULL

for (i in 1837:3195) {
    fipsIDs$Name[i] <- substr(fipsIDs[i,1],7,nchar(as.character(fipsIDs[i,1])))
    }

fipsIDs$Name <- sub(", ","|",fipsIDs$Name)

fipsNames <- read.csv(path.expand("~/Desktop/codes_w_statenames.txt"),header=FALSE,sep="|")

MyCensusData <- merge(MyCensusData, fipsNames, by.x="CountyID", by.y="V1")
MyCensusData$nameAppend <- paste(MyCensusData$V2,"|",MyCensusData$V3, sep="")

countydata <- merge(countydata, MyCensusData, by.x="nameAppend", by.y="nameAppend")

countydata <- countydata[-c(which(countydata$STATEFP==72)),]
countydata <- countydata[-1763,]
names(countydata)[36] <- "County"
names(countydata)[37] <- "State"
```

Full R code [here](https://github.com/mbisaha/edav_final_project/blob/master/Data_munging.R).

And finally, we aggregated final data into SQL...

```
Select 
STATE = Substring(nameAppend,charIndex('|',nameAppend)+1,CharIndex('|',Reverse(nameAppend))),
Pop2011 = SUM(CAST(Population2010 as bigint)) ,
Pop2013 = SUM(CAST(Population2013 as bigint))
from [dbo].[Modeldata_Clean]
GROUP BY 
Substring(nameAppend,charIndex('|',nameAppend)+1,CharIndex('|',Reverse(nameAppend)))
Order by 1

Select i.[Index],State = Substring(nameAppend,charIndex('|',nameAppend)+1,CharIndex('|',Reverse(nameAppend))) ,*

from ModelData_Clean C 
INNER JOIN [dbo].[2011_gun_index]  i ON i.State = Substring(nameAppend,charIndex('|',nameAppend)+1,CharIndex('|',Reverse(nameAppend)))
Order by 2 ASC

Select 
	i.[Index],
	Density,
	FH,
	H,
	Population2010,
	PopU182013,
	PopO652013,
	PopulationU1864 = 1 - CAST(PopU182013 as float) - CAST(PopO652013 as float),
	FemalePercent,
	WhiteAlonePercent,
	BlackAlonePercent,
	NativeAmAlonePercent,
	AsianAlongPercent,
	PacIslandPercent,
	MultipleRacesPercent,
	LessThanHighSchool = 1 - Cast(HighSchoolPlusPercent as float),
	BachelorsPlusPercent,
	HighSchoolOnly = Cast(HighSchoolPlusPercent as float) - Cast(BachelorsPlusPercent as float),
	BelowPovertyPercent,
	Employement = Cast(NonfarmEmployment2012 as float)/Cast(Population2013 as float),
	H,
	FH
Into XY1Y2
From ModelData_Clean C 
INNER JOIN [dbo].[2011_gun_index]  i ON i.State = Substring(nameAppend,charIndex('|',nameAppend)+1,CharIndex('|',Reverse(nameAppend)))
```

Full SQL code [here](https://github.com/mbisaha/edav_final_project/blob/master/DataManipulation.sql).


## Exploring the potential variables with choropleth maps

After pulling the variety of variables we considered building into our model, we wanted to better visualize the county-by-county trends across the US. For this, we turned to building choropleth maps for each data point. Taken together, these charts helped us understand each individual variable in greater detail, as well identify which variables may be conveying similar information in terms of our final model.


__Choropleth Maps (raw HTML)__
* [Firearm Homicides](https://raw.githubusercontent.com/mbisaha/edav_final_project/master/Choropleths/Firearm_Homicides.html)
* [Homicides](https://raw.githubusercontent.com/mbisaha/edav_final_project/master/Choropleths/Homicides.html)
* [Population](https://raw.githubusercontent.com/mbisaha/edav_final_project/master/Choropleths/Population.html)
* [Population Density](https://raw.githubusercontent.com/mbisaha/edav_final_project/master/Choropleths/Population_Density.html)
* [Urban-Dwelling Percentage](https://raw.githubusercontent.com/mbisaha/edav_final_project/master/Choropleths/Urban_Population_Density.html)
* [Under-18 Percentage](https://raw.githubusercontent.com/mbisaha/edav_final_project/master/Choropleths/Population_Under_18.html)
* [Under Poverty Line Percentage](https://raw.githubusercontent.com/mbisaha/edav_final_project/master/Choropleths/Population_Under_Poverty_Line.html)
* [High School Graduate Percentage](https://raw.githubusercontent.com/mbisaha/edav_final_project/master/Choropleths/Population_High_School_Graduate.html)

Using the ['leafletR'](https://github.com/chgrl/leafletR) package (which seems to offer more flexibility than the 'leaflet' package produced by RStudio), each individual HTML map can be built directly from data in R.

```R
library("leafletR")

## green-red (low-high) color palette
set_map_color_grrd <- colorRampPalette(c('green', 'white', 'red'))

map_county <- toGeoJSON(countydata, dest="/Users/mbisaha/Desktop/US_County_Shapefiles")

## map UnderPovertyLine							
sty.PopUPoverty <- styleGrad(	prop="BelowPovertyPercent",
								breaks= c(0,2,5,10,15,20,25,30,40,50,60),
								style.par="col",
								style.val=set_map_color_grrd(10),
								leg="Percent Population Below Poverty Line",
								fill.alpha=0.8,
								col="black",
								lwd=0.2,
								marker=NULL)

map <- leaflet(	data=map_county, 
				dest="/Users/mbisaha/Desktop/US_County_Shapefiles/ChoroplethMaps", 
				title="Population Under Poverty Line",
				base.map="positron",
				style=sty.PopUPoverty,
				popup=c("County","State","BelowPovertyPercent"),
				controls="all",
				incl.data=TRUE)
```

Full R code [here](https://github.com/mbisaha/edav_final_project/blob/master/choropleth_code.R).

Population and Population Density are extremely correlated, for example, and so both shouldn't be used in our final model due to collinearity concerns.

## Exploring the potential variables further with parallel coordinates

Now that we better understand many of the variables in play, we want to explore the relationships each one has not only to each other, but to total number of homicides and the gun law strictness index. For this exploration, we turned to parallel coordinates graphs which gave us insight into variable interactions.

This graph required both the [Parallel Coordinates](https://github.com/syntagmatic/parallel-coordinates) and [Slickgrid](https://github.com/mleibman/SlickGrid) packages in order to build the chart in d3.

The slickgrids functionality in particular was extremely useful in mapping individual trajectories in the parallel coordinates graph to specific counties, states, and variable values. In addition to being a great tool for analyzing variable interaction, we also found it useful in catching outliers that deviate from the trend (we even uncovered some misaligned data issues in our first iteration using this chart).

Source Code
* [Scatter](https://github.com/mbisaha/edav_final_project/blob/master/Lauren/scatter.html)
* [Slickgrid](https://github.com/mbisaha/edav_final_project/blob/master/Lauren/slickgrid.html)


## Developing the Model

At this point, it was time to settle on which variables to include in our model. This was equal parts art and science, as we attempted to eliminate as many highly correlated variables from our list while still capturing a range of indicators.

After several rounds of testing model variables, we came to realize that the national dataset we were dealing with would need to be split into two clusters to get more accurate results. The small share of counties with highly dense urban areas were overpowering rural counties who were operating on a widely different scale. To account for this, we opted to use K-means to cluster the data into both rural and urban clusters and run our regression separately on both datasets.

```R
Y1 <- read.csv(path.expand("~/Desktop/Y1.csv"),header=TRUE,sep=",")
Y2 <- read.csv(path.expand("~/Desktop/Y2.csv"),header=TRUE,sep=",")
X1Y1Y2 <- read.csv(path.expand("~/Desktop/X1Y1Y2.csv"),header=TRUE,sep=",")

X <- as.data.frame(X1Y1Y2[,1:9])
Ys <- as.data.frame(X1Y1Y2[,10:11])
scaledX <- scale(X)

clusterIDs <- kmeans(X[,-c(1)],4, iter.max=1000)$cluster
cluster1IDs <- which(clusterIDs==1)
cluster2IDs <- which(clusterIDs==2)
cluster3IDs <- which(clusterIDs==3)
cluster4IDs <- which(clusterIDs==4)
urbanIDs <- c(cluster2IDs,cluster3IDs,cluster4IDs)

ruralX <- X[cluster1IDs,]
urbanX <- X[urbanIDs,]
scaled_ruralX <- scale(ruralX)
scaled_urbanX <- scale(urbanX)

ruralYs <- Ys[cluster1IDs,]
urbanYs <- Ys[urbanIDs,]
```

At this point, we were finally ready to run our linear model on the dataset(s) and learn the effects of each variable on gun and non-gun homicides.

```R
## scaled gunhomicides
AllData <- cbind(scaled_ruralX, ruralYs)

linRegres = lm(FH ~ Index + Density + PopU182013 + FemalePercent + WhiteAlonePercent + LessThanHighSchool + BelowPovertyPercent + UnEmployement + PopPerSqMile2010, data = AllData)
linRegres

ws[,1] <- linRegres$coefficients

AllData <- cbind(scaled_urbanX, urbanYs)

linRegres = lm(FH ~ Index + Density + PopU182013 + FemalePercent + WhiteAlonePercent + LessThanHighSchool + BelowPovertyPercent + UnEmployement + PopPerSqMile2010, data = AllData)
linRegres

ws[,2] <- linRegres$coefficients
```

Full code for K-means clustering and regression model [here](https://github.com/mbisaha/edav_final_project/blob/master/Model%20code%20block.R).

## Model Results

In the end, the model ended up producing some interesting results. In rural areas, the primary predictor of increased gun violence was population density. The remainder of factors had far smaller coefficients, and were tightly clustered. Higher gun strictness was positively correlated, but was on the same order as most other indicators.

In the model for urban areas, the primary predictor of gun homicides by far was the percent of the population without a high school degree. This was followed by the percent of county population living in an urban area and percent of population below the poverty line, respectively. The negative correlation with stricter gun laws was more significant than in the rural model, but was still a marginal factor behind other variables.

[Model Results for Firearm Homicides](http://htmlpreview.github.com/?https://github.com/carmem/edav_final_project/blob/master/D3/gun_homicides.html)

[Model Results for Homicides](http://htmlpreview.github.com/?https://github.com/carmem/edav_final_project/blob/master/D3/homicides.html)

Overall, we concluded that strict gun laws may in fact have a negative correlation with gun homicides in urban areas, with rural firearm homicides being less sensitive to gun policies. In both models, though, the effects of gun laws were marginal and were far less predictive than other variables.


## Gun Homicides and Gun Index changes over time

Lastly, we decided to review our results in the context of recent policy changes. To do this, we found data in the change in gun law strictness in each state in recent years and compared these shifts to the change in firearm homicides over the same period.

[Changes in Gun Homicide per Population](https://github.com/mbisaha/edav_final_project/blob/master/Homocide_Population.html)

