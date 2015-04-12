getwd()
setwd("/Users/kedarpatil/edav/data")

nycspeed_data <- read.table("LinkSpeedQuery.txt", sep="\t", header=TRUE)
trafficvol_data <- read.csv("Traffic_Volume_Counts__2012-2013_.csv")
trafficvol_data$Date <- as.Date(trafficvol_data$Date, format='%m/%d/%Y')

require(reshape2)
trafficvol_melt <- melt(trafficvol_data,
                 id = c("ID", "Segment.ID","Roadway.Name","From","To","Direction","Date"),
                 variable.name = "Hour", value.name = "Traffic.Volume")

trafficvol_melt2 <- trafficvol_melt[order(trafficvol_melt$ID, trafficvol_melt$Segment.ID,trafficvol_melt$Roadway.Name,trafficvol_melt$From,trafficvol_melt$To, trafficvol_melt$Direction, trafficvol_melt$Date),]
trafficvol_melt2 <- subset(trafficvol_melt2, select = -1:4)
