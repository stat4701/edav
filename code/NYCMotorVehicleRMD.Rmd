---
title: "Mini assignment 1"
author: "Kedar Patil"
date: "February 16, 2015"
output: html_document
layout: post
description: mini-assignment
tags: assignments, Kedar Patil
---

#NYC Motor Vehicle Collision Data

###Background

This data has been downloaded from as of 02/15/2015, [NYC Open Data](https://data.cityofnewyork.us/NYC-BigApps/NYPD-Motor-Vehicle-Collisions/h9gi-nx95) website. It has 531,574 records and covers activity from 07/01/2012 to 02/10/2015. This analysis focuses only on full year 2013-2014.



###Preliminary Findings

Strong seasonality is observed, with injuries peaking around beginning of summer, when more people are out on street.


```{r, echo=FALSE, message=FALSE}
nycmvc_data <- read.csv("/Users/kedarpatil/edav/data/NYPD_Motor_Vehicle_Collisions.csv")

#FIXING DATES
nycmvc_data$DATE <- as.Date(nycmvc_data$DATE, format='%m/%d/%Y')

#CREATING SUMMARY TABLE
library(plyr)
mth_frq_all <- ddply(nycmvc_data, c(year_grp="strftime(nycmvc_data$DATE, format='%Y')",
                                    mnth_grp="strftime(nycmvc_data$DATE, format='%m')"), 
                 summarise, Inj_Pers=sum(NUMBER.OF.PERSONS.INJURED), 
                 Fat_Pers=sum(NUMBER.OF.PEDESTRIANS.KILLED))

#CHARACTER TO NUMERIC
mth_frq_all$mnth_grp <- as.numeric(mth_frq_all$mnth_grp)

#PLOT 2013-2014 INJURIES ONLY
library(dplyr)
fltr_mth_frq_all <- filter(mth_frq_all, year_grp=="2013"|year_grp=="2014")

#PLOT INJURIES
require(ggplot2)
require(scales) # for removing scientific notation

(ggplot(fltr_mth_frq_all, aes(x=mnth_grp, y=Inj_Pers, color=year_grp, xmin=1, xmax=12, ymin=0, ymax = 7000)) 
 + geom_line(size=1) + geom_point(size=3)
 + ggtitle("YoY Overall Injuries - 2013-2014") 
 + scale_y_continuous(labels = comma)
 + scale_x_discrete(labels = comma)
 + theme(plot.title=element_text(size=rel(1.5), face="bold"))
 + theme(axis.title=element_text(size=15), 
         axis.text=element_text(size=10), 
         legend.text=element_text(size=10),
         legend.title=(element_text(size=10)))
 + labs(x="Month", y="Observed Frequency", color="Year"))

```







Motor vehicle injuries form the biggest share of injuries, followed by pedestrians. Number of injuries has not changed substantially across two years.


```{r, echo=FALSE, message=FALSE}
#PLOT 2013-2014 INJURIES ONLY - DEEPER DIVE
mth_frq_deep <- ddply(nycmvc_data, c(year_grp="strftime(nycmvc_data$DATE, format='%Y')",
                                    mnth_grp="strftime(nycmvc_data$DATE, format='%m')"), 
                     summarise,                 
                     Pedestrians=sum(NUMBER.OF.PEDESTRIANS.INJURED),
                     Cyclists=sum(NUMBER.OF.CYCLIST.INJURED),
                     Motorists=sum(NUMBER.OF.MOTORIST.INJURED))
 
#CHARACTER TO NUMERIC
mth_frq_deep$mnth_grp <- as.numeric(mth_frq_deep$mnth_grp)

library(dplyr)
fltr_mth_frq_deep <- filter(mth_frq_deep, year_grp=="2013"| year_grp=="2014")


#MELTING DATA
require(reshape2)
tmp_melt <- melt(fltr_mth_frq_deep,
                 id = c("year_grp", "mnth_grp"),
                 variable.name = "Injury_Category", value.name = "Freq")

tmp_melt_bar <- ddply(tmp_melt, c("year_grp","Injury_Category"),
                       summarise, "Frequency" = sum(Freq))

require(scales) # for removing scientific notation

(ggplot(tmp_melt_bar, aes(x=Injury_Category, y=Frequency, fill=year_grp, ymax = 45000)) + geom_bar(position="dodge",stat="identity")
 + geom_text(aes(label=comma(Frequency)), vjust=-1, size=3.5, position=position_dodge(.9))
 + scale_y_continuous(labels = comma)
 + ggtitle("YoY Injuries by Category - 2013-2014")
 + theme(plot.title=element_text(size=rel(1.5), face="bold"))
 + theme(axis.title=element_text(size=15), 
         axis.text=element_text(size=10), 
         legend.text=element_text(size=10),
         legend.title=(element_text(size=10)))
 + labs(x="Injury Category", y="Observed Frequency", fill="Year"))

```







Further, pedestrians and cyclists have somewhat opposite relationship when it comes to injuries

```{r, echo=FALSE, message=FALSE}
#PLOT 2013-2014 INJURIES ONLY - DEEPER DIVE - LINE
tmp_melt_line <- ddply(tmp_melt, c("mnth_grp","Injury_Category"),
                      summarise, "Frequency" = sum(Freq))

(ggplot(tmp_melt_line, aes(x=mnth_grp, y=Frequency, color=Injury_Category, xmin=1, xmax=12, ymin=0)) 
 + geom_line(size=1) + geom_point(size=3)
 + ggtitle("Injuries by Category - 2013-2014") 
 + scale_y_continuous(labels = comma)
 + scale_x_discrete(labels = comma)
 + theme(plot.title=element_text(size=rel(1.5), face="bold"))
 + theme(axis.title=element_text(size=15), 
         axis.text=element_text(size=10), 
         legend.text=element_text(size=10),
         legend.title=(element_text(size=10)))
 + labs(x="Month", y="Observed Frequency", color="Category"))

```







Passenger and SUVs contribute most to injuries

```{r, echo=FALSE, message=FALSE}
#PLOT VEHICLE TYPE AND INJURY
inj_veh_typ <- ddply(filter(nycmvc_data, DATE>"2012-12-31" & DATE<"2015-01-01"),
                     c("VEHICLE.TYPE.CODE.1"), 
                      summarise,                 
                      Pedestrians=sum(NUMBER.OF.PEDESTRIANS.INJURED),
                      Cyclists=sum(NUMBER.OF.CYCLIST.INJURED),
                      Motorists=sum(NUMBER.OF.MOTORIST.INJURED))

tmp_melt <- melt(inj_veh_typ,
                 id = c("VEHICLE.TYPE.CODE.1"),
                 variable.name = "Injury_Category", value.name = "Frequency")

tmp_melt_bar <- filter(tmp_melt, Injury_Category=="Pedestrians")
tmp_melt_bar <- filter(tmp_melt, Injury_Category=="Cyclists")
tmp_melt_bar <- filter(tmp_melt, Injury_Category=="Motorists")

require(scales) # for removing scientific notation

(ggplot(tmp_melt_bar, aes(x=reorder(VEHICLE.TYPE.CODE.1,Frequency), y=Frequency, fill=VEHICLE.TYPE.CODE.1)) 
 + geom_bar(stat="identity")
 + coord_flip()
 #+ geom_text(aes(label=comma(Frequency)), vjust=-1, size=6, position=position_dodge(.9))
 + scale_y_continuous(labels = comma)
 + ggtitle("Injuries by Vehicle Type - 2013-2014 - Pedestrians")
# + ggtitle("Injuries by Vehicle Type - 2013-2014 - Cyclists")
# + ggtitle("Injuries by Vehicle Type - 2013-2014 - Motorists")
 + theme(plot.title=element_text(size=rel(1), face="bold"))
 + theme(axis.title=element_text(size=15), 
         axis.text=element_text(size=10), 
 #        legend.text=element_text(size=10),
         legend.title=(element_text(size=10)))
 + guides(fill=FALSE)
 + labs(x="Injury Category", y="Observed Frequency", fill="Vehicle"))

```




Looking for intersections that have had >= 15 pedestrians injured in last 2 years, we see clusters in mid-town and upper manahattan and Bronx. There are a few spots in Queens and Brooklyn as well.

```{r, echo=FALSE, message=FALSE, cache=FALSE, warning=FALSE}
#CREATING SUMMARY TABLE
library(plyr)
injureped=subset(nycmvc_data,NUMBER.OF.PEDESTRIANS.INJURED > 0)

injureped_loc <- ddply(injureped, c("LONGITUDE", "LATITUDE"), 
                     summarise, Inj_No=sum(NUMBER.OF.PERSONS.INJURED))

injureped_loc_sum <- ddply(injureped_loc, c("Inj_No"), 
                       summarise, FreqCnt=length(Inj_No))

high_injure_loc_ped <- subset(injureped_loc, Inj_No >= 15)

library(ggmap)
nycmap <- get_map(location = "Queens, New York", zoom=11)

(nyc1 <- ggmap(nycmap) + scale_color_discrete(name = ">=15 Pedestrians Injured - 2013-2014")
    + ggtitle(">=15 Pedestrians Injured - 2013-2014")
 + theme(plot.title=element_text(size=rel(1), face="bold"))
 + theme(legend.text=element_text(size=0),
         legend.title=(element_text(size=0)),
        legend.position="none")
+ geom_point(data=high_injure_loc_ped, aes(LONGITUDE, LATITUDE, color = 'Pedestrians'), size=2, alpha=1))
```



Major streets and intersections around 14th, 23rd, 34th, 42nd, and Times Square, as well as 119th, 125th, and 135th streets seem to have high number of injuries.

```{r, echo=FALSE, message=FALSE, cache=FALSE, warning=FALSE}
nycmap <- get_map(location = "Flatiron, New York", zoom=13)

(nyc1 <- ggmap(nycmap) + scale_color_discrete(name = ">=15 Pedestrians Injured - 2013-2014")
 + ggtitle(">=15 Pedestrians Injured - Mid, Lower Manhattan")
 + theme(plot.title=element_text(size=rel(1), face="bold"))
 + theme(legend.text=element_text(size=0),
         legend.title=(element_text(size=0)),
         legend.position="none")
 + geom_point(data=high_injure_loc_ped, aes(LONGITUDE, LATITUDE, color = 'Pedestrians'), size=3))




nycmap <- get_map(location = "Harlem, New York", zoom=14)

(nyc1 <- ggmap(nycmap) + scale_color_discrete(name = ">=15 Pedestrians Injured - 2013-2014")
 + ggtitle(">=15 Pedestrians Injured - Upper Manhattan & Bronx")
 + theme(plot.title=element_text(size=rel(1), face="bold"))
 + theme(legend.text=element_text(size=0),
         legend.title=(element_text(size=0)),
         legend.position="none")
 + geom_point(data=high_injure_loc_ped, aes(LONGITUDE, LATITUDE, color = 'Pedestrians'), size=3))
```