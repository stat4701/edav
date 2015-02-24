nycmvc_data <- read.csv("/Users/kedarpatil/edav/data/NYPD_Motor_Vehicle_Collisions.csv")

#FIXING DATES
nycmvc_data$DATE <- as.Date(nycmvc_data$DATE, format='%m/%d/%Y')
range(nycmvc_data$DATE)


#CREATING SUMMARY TABLE
library(plyr)
mth_frq_all <- ddply(nycmvc_data, c(year_grp="strftime(nycmvc_data$DATE, format='%Y')",
                                    mnth_grp="strftime(nycmvc_data$DATE, format='%m')"), 
                 summarise, Inj_Pers=sum(NUMBER.OF.PERSONS.INJURED), 
                 Fat_Pers=sum(NUMBER.OF.PEDESTRIANS.KILLED))

#CHARACTER TO NUMERIC
mth_frq_all$mnth_grp <- as.numeric(mth_frq_all$mnth_grp)


#PLOT INJURIES
require(ggplot2)
(ggplot(mth_frq_all, aes(x=mnth_grp, y=Inj_Pers, color=year_grp)) + geom_line() + geom_point() +
ggtitle("YoY Overall Injuries") + theme(plot.title=element_text(size=rel(2), face="bold")) 
+ theme(axis.title=element_text(size=25)))

#PLOT FATALITIES
(ggplot(mth_frq_all, aes(x=mnth_grp, y=Fat_Pers, color=year_grp)) + geom_line() + geom_point() +
   ggtitle("YoY Overall Fatalities") + theme(plot.title=element_text(size=rel(2), face="bold")) 
 + theme(axis.title=element_text(size=25)))


#PLOT 2013-2014 INJURIES ONLY
library(dplyr)

fltr_mth_frq_all <- filter(mth_frq_all, year_grp=="2013"|year_grp=="2014")

require(scales) # for removing scientific notation

(ggplot(fltr_mth_frq_all, aes(x=mnth_grp, y=Inj_Pers, color=year_grp, xmin=1, xmax=12, ymin=0)) 
 + geom_line(size=1) + geom_point(size=3)
 + ggtitle("YoY Overall Injuries - 2013-2014") 
 + scale_y_continuous(labels = comma)
 + scale_x_discrete(labels = comma)
 + theme(plot.title=element_text(size=rel(2.5), face="bold"))
 + theme(axis.title=element_text(size=25), 
         axis.text=element_text(size=16), 
         legend.text=element_text(size=18),
         legend.title=(element_text(size=18)))
 + labs(x="Month", y="Observed Frequency", color="Year"))




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
 + geom_text(aes(label=comma(Frequency)), vjust=-1, size=6, position=position_dodge(.9))
 + scale_y_continuous(labels = comma)
 + ggtitle("YoY Injuries by Category - 2013-2014")
 + theme(plot.title=element_text(size=rel(2.5), face="bold"))
 + theme(axis.title=element_text(size=25), 
         axis.text=element_text(size=16), 
         legend.text=element_text(size=18),
         legend.title=(element_text(size=18)))
 + labs(x="Injury Category", y="Observed Frequency", fill="Year"))



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
 + theme(plot.title=element_text(size=rel(2), face="bold"))
 + theme(axis.title=element_text(size=15), 
         axis.text=element_text(size=10), 
 #        legend.text=element_text(size=10),
         legend.title=(element_text(size=10)))
 + guides(fill=FALSE)
 + labs(x="Injury Category", y="Observed Frequency", fill="Vehicle"))





#PLOT CONTRIBUTING FACTOR AND INJURY SCATTER PLOT
filter_inj_veh_typ <- filter(nycmvc_data, DATE >"2012-12-31" & DATE <"2015-01-01")
inj_veh_typ <- ddply(filter(nycmvc_data, DATE>"2012-12-31" & DATE<"2015-01-01" 
                            & CONTRIBUTING.FACTOR.VEHICLE.1 != "" & CONTRIBUTING.FACTOR.VEHICLE.1 != "Unspecified"),
                     c("CONTRIBUTING.FACTOR.VEHICLE.1"), 
                     summarise,                 
                     Pedestrians=sum(NUMBER.OF.PEDESTRIANS.INJURED),
                     Cyclists=sum(NUMBER.OF.CYCLIST.INJURED),
                     Motorists=sum(NUMBER.OF.MOTORIST.INJURED))

(bp1 <- ggplot(inj_veh_typ, aes(x=Pedestrians, y=Cyclists)) + geom_point(size=2) 
            + ggtitle("Scatter plot Pedestrians vs Cyclists"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) 
            + theme(axis.title=element_text(size=25))
            + geom_text(aes(x=Pedestrians+500, y=Cyclists+50, label=CONTRIBUTING.FACTOR.VEHICLE.1), size=4, hjust=1))

(bp1 <- ggplot(inj_veh_typ, aes(x=Pedestrians, y=Motorists)) + geom_point(size=2) 
 + ggtitle("Scatter plot Pedestrians vs Cyclists"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) 
 + theme(axis.title=element_text(size=25))
 + geom_text(aes(x=Pedestrians+500, y=Motorists+500, label=CONTRIBUTING.FACTOR.VEHICLE.1), size=4, hjust=1))

(bp1 <- ggplot(inj_veh_typ, aes(x=Motorists, y=Cyclists)) + geom_point(size=2) 
 + ggtitle("Scatter plot Pedestrians vs Cyclists"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) 
 + theme(axis.title=element_text(size=25))
 + geom_text(aes(x=Motorists+500, y=Cyclists+50, label=CONTRIBUTING.FACTOR.VEHICLE.1), size=4, hjust=1))


(bp1 <- ggplot(inj_veh_typ, aes(x=Pedestrians, y=Cyclists, z=Motorists)) + geom_point(size=2) 
 + ggtitle("Scatter plot Pedestrians vs Cyclists"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) 
 + theme(axis.title=element_text(size=25)))
 + geom_text(aes(x=Pedestrians+500, y=Cyclists+50, label=CONTRIBUTING.FACTOR.VEHICLE.1), size=4, hjust=1))


# Spinning 3D scatterplot
# Install X11/XQuartz for Mac
# Install and load rgl package
install.packages("rgl")
require("rgl")
require("RColorBrewer")
plot3d(inj_veh_typ$Pedestrians,  # x variable
       inj_veh_typ$Cyclists,  # y variable
       inj_veh_typ$Motorists,   # z variable
       xlab = "Pedestrians",
       ylab = "Cyclists",
       zlab = "Motorists",
       col  = "orange", 
       size = 5)

killedped=subset(nycmvc_data,NUMBER.OF.PEDESTRIANS.KILLED > 0)
killedcyc=subset(nycmvc_data,NUMBER.OF.CYCLIST.KILLED > 0)
killedmot=subset(nycmvc_data,NUMBER.OF.MOTORIST.KILLED > 0)

library(ggmap)
nycmap <- get_map("New York City", zoom="auto")

(nyc1 <- ggmap(nycmap) + scale_color_discrete(name = "Fatal Accidents") +
  geom_point(data=killedped, aes(LONGITUDE, LATITUDE, color = 'Pedestrians'), size=3) +
  geom_point(data=killedcyc, aes(LONGITUDE, LATITUDE, color = 'Cyclists'), size=3) +
  geom_point(data=killedmot, aes(LONGITUDE, LATITUDE, color = 'Motorists'), size=3))

#CREATING SUMMARY TABLE
library(plyr)
#injureped=subset(nycmvc_data,(PEDS_HURT=(NUMBER.OF.PEDESTRIANS.INJURED+NUMBER.OF.PEDESTRIANS.KILLED)) > 0)
injureped=subset(nycmvc_data,NUMBER.OF.PEDESTRIANS.INJURED > 0)
injurecyc=subset(nycmvc_data,NUMBER.OF.CYCLIST.INJURED > 0)
injuremtr=subset(nycmvc_data,NUMBER.OF.MOTORIST.INJURED > 0)

injureped_loc <- ddply(injureped, c("LONGITUDE", "LATITUDE"), 
                     summarise, Inj_No=sum(NUMBER.OF.PERSONS.INJURED))
injurecyc_loc <- ddply(injurecyc, c("LONGITUDE", "LATITUDE"), 
                       summarise, Inj_No=sum(NUMBER.OF.CYCLIST.INJURED))
injuremtr_loc <- ddply(injuremtr, c("LONGITUDE", "LATITUDE"), 
                       summarise, Inj_No=sum(NUMBER.OF.MOTORIST.INJURED))

injureped_loc_sum <- ddply(injureped_loc, c("Inj_No"), 
                       summarise, FreqCnt=length(Inj_No))
injurecyc_loc_sum <- ddply(injurecyc_loc, c("Inj_No"), 
                           summarise, FreqCnt=length(Inj_No))
injuremtr_loc_sum <- ddply(injuremtr_loc, c("Inj_No"), 
                           summarise, FreqCnt=length(Inj_No))

high_injure_loc_ped <- subset(injureped_loc, Inj_No >= 15)
high_injure_loc_cyc <- subset(injurecyc_loc, Inj_No >= 10)
high_injure_loc_mtr <- subset(injuremtr_loc, Inj_No >= 30)

library(ggmap)
nycmap <- get_map(location = "Queens, New York", zoom=11)

(nyc1 <- ggmap(nycmap) + scale_color_discrete(name = ">=15 Pedestrians Injured - 2013-2014")
    + ggtitle(">=15 Pedestrians Injured - 2013-2014")
 + theme(plot.title=element_text(size=rel(2), face="bold"))
 + theme(legend.text=element_text(size=0),
         legend.title=(element_text(size=0)),
        legend.position="none")
+ geom_point(data=high_injure_loc_ped, aes(LONGITUDE, LATITUDE, color = 'Pedestrians'), size=3))



nycmap <- get_map(location = "Flatiron, New York", zoom=13)

(nyc1 <- ggmap(nycmap) + scale_color_discrete(name = ">=15 Pedestrians Injured - 2013-2014")
 + ggtitle(">=15 Pedestrians Injured - Mid, Lower Manhattan")
 + theme(plot.title=element_text(size=rel(2), face="bold"))
 + theme(legend.text=element_text(size=0),
         legend.title=(element_text(size=0)),
         legend.position="none")
 + geom_point(data=high_injure_loc_ped, aes(LONGITUDE, LATITUDE, color = 'Pedestrians'), size=4))




nycmap <- get_map(location = "Harlem, New York", zoom=14)

(nyc1 <- ggmap(nycmap) + scale_color_discrete(name = ">=15 Pedestrians Injured - 2013-2014")
 + ggtitle(">=15 Pedestrians Injured - Upper Manhattan & Bronx")
 + theme(plot.title=element_text(size=rel(2), face="bold"))
 + theme(legend.text=element_text(size=0),
         legend.title=(element_text(size=0)),
         legend.position="none")
 + geom_point(data=high_injure_loc_ped, aes(LONGITUDE, LATITUDE, color = 'Pedestrians'), size=4))


#BOROUGH
borough_typ <- ddply(filter(nycmvc_data, DATE>"2012-12-31" & DATE<"2015-01-01"),
                        c("BOROUGH"), 
                        summarise,                 
                     Pedestrians=sum(NUMBER.OF.PEDESTRIANS.INJURED),
                     Cyclists=sum(NUMBER.OF.CYCLIST.INJURED),
                     Motorists=sum(NUMBER.OF.MOTORIST.INJURED))

tmp_melt <- melt(borough_typ,
                 id = c("BOROUGH"),
                 variable.name = "Injury_Category", value.name = "Frequency")

require(scales) # for removing scientific notation

(ggplot(tmp_melt, aes(x=Injury_Category, y=Frequency, fill=BOROUGH)) 
 + geom_bar(position="dodge",stat="identity")
 #+ geom_text(aes(label=comma(Frequency)), vjust=-1, size=6, position=position_dodge(.9))
 + scale_y_continuous(labels = comma)
 + ggtitle("Borough - 2013-2014")
 + theme(plot.title=element_text(size=rel(2), face="bold"))
 + theme(axis.title=element_text(size=25), 
         axis.text=element_text(size=16), 
         legend.text=element_text(size=18),
         legend.title=(element_text(size=18)),
         legend.position="bottom")
 #+ guides(fill=FALSE)
 + labs(x="Contributing Factor", y="Observed Frequency", fill="BOROUGH"))


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



#PLOTTING ON MAP
library("plyr")
nonmis_latlong <- filter(nycmvc_data, LATITUDE != "NA" | LONGITUDE != "NA" )

nonmis_latlong_sum <- ddply(nonmis_latlong, c("LONGITUDE","LATITUDE"), summarise, Inj_Pers=sum(NUMBER.OF.PERSONS.INJURED))

require(ggplot2)
require(maps)

states_map <- map_data("state", region="New York")
states_map <- rename(states_map, c("long" = "LONGITUDE", "lat" = "LATITUDE"))

states_map_merged <- merge(nonmis_latlong_sum, states_map, 
                           by.x = "LONGITUDE", by.y = "LATITUDE")

(ggplot(states_map, aes(x=long, y=lat, group=group)) 
 + geom_polygon(fill="grey", color="white")
 + coord_map())

(ggplot(nonmis_latlong_sum, aes(x="LONGITUDE", y="LATITUDE", group=group)) 
 + geom_polygon(fill="grey", color="white")
 + coord_map())

(ggplot(nonmis_latlong_sum, aes("long","lat")) 
   + geom_polygon(aes(group=group), data="state")
   + cord_maps())

#PLOTTING ON GOOGLE MAP
install.packages("googleVis")
require(googleVis)



install.packages("ggmap")
library("ggmap")

myMap <- get_map(location=c(nonmis_data$LATITUDE,nonmis_data$LONGITUDE), source="google", maptype="roadmap", crop=FALSE)
ggmap(myMap)

ggmap(nonmis_data)+
  geom_point(aes(x = LONGITUDE, y = LATITUDE), data = nonmis_data,
             alpha = .5, color="darkred", size = 3)



nonmis_data$LATITUDE <- as.character(nonmis_data$LATITUDE)
nonmis_data$LONGITUDE <- as.character(nonmis_data$LONGITUDE)

mutate(nonmis_data,
       LATLONG = cat('LATITUDE','LONGITUDE'))

Inj_geo <- gvisMap(nycmvc_data, locationvar=cat(as.character(nycmvc_data$LATITUDE),":",as.character(nycmvc_data$LONGITUDE)))

plot(Inj_geo)
