library(foreign)

#========= San Francisco crime data with ggmap package ========
library(ggmap)

# 3 ways to define location
# address
sf1 = 'San Francisco'
# longitude/latitude pair
sf2 <- c(lon = -122.4194, lat = 37.77493)
# bounding box lowerleftlon, lowerleftlat, upperrightlon, upperrightlat
sf3 <- c(-122.46, 37.75, -122.36, 37.825)

# convert between address and lon/lat
geocode("San Francisco")

##### Define base layer map source, type, etc in ggmap #####
# a=get_map
# ggmap(a)
# equiv.wrapper for get_map and ggmap: qmap

sf = get_map(location = sf1,
             zoom = 13, 
             maptype = "hybrid",
             source = "google")
    # source: google / type: roadmap, terrain, hybrid, satellite
    # source: steman / type: terrain, toner, watercolor
    # source: osm
sfbase1 = ggmap(sf, extent = "panel", legend = "topleft")

sfbase2 = qmap(location= sf1,
               zoom = 13,
               maptype = "hybrid",
               souce = "google",
               color = 'color',
               legend = 'topleft')

##### Adding layer onto basemap by San Francisco crime data Jul-Dec 2012 #####

# Read data, add tags and combine (4 types of crime)
sf_car=read.dbf("Downloads/sf_cartheft.dbf")
sf_car$crime <- 'car theft'
sf_drug=read.dbf("Downloads/sf_drugs.dbf")
sf_drug$crime <- 'drugs'
sf_rob=read.dbf("Downloads/sf_robbery.dbf")
sf_rob$crime <- 'robbery'
sf_vandal=read.dbf("Downloads/sf_vandalism.dbf")
sf_vandal$crime <- 'vandalism'
sf_crime=rbind(sf_car,sf_drug, sf_rob, sf_vandal)

# add points on map
# geom_point
sfbase2 + geom_point(aes(x = X, y = Y, color=crime), data = sf_crime ) 
# too much, zoom in to union square
# zoom: integer 2~21, 3 = continent, 10 = city, 21 = building
sfbase2 = qmap(location= "union square, san francisco",
               zoom = 15,
               maptype = "roadmap",
               souce = "google",
               color = 'color',
               legend = 'topleft')


# add density map
# stat_density2d
sfbase2 + 
  stat_density2d(data = sf_crime,
                 aes(x = X, y = Y, fill = ..level.., alpha = ..level..),
                 size = 10, bins = 10, geom = "polygon") + 
  scale_alpha(range = c(0.1, 0.4), guide = FALSE) +
  scale_fill_gradient(low = "beige", high = "blue")
# narrow down to robbery with a gun on street
library(sqldf)
rob_street_gun=sqldf("select x, y 
                     from sf_rob 
                     where Descript='ROBBERY ON THE STREET WITH A GUN'")
sfbase2 + 
  stat_density2d(data = rob_street_gun, 
                 aes(x=X, y=Y, alpha=..level.., fill=..level..),
                 size=10, bins=10, geom="polygon") + 
  scale_fill_gradient(low = "yellow", high = "red") +
  scale_alpha(range = c(0.1, 0.4), guide = FALSE)


# add bins on map
# stat_bin2d
sfbase2 + 
  stat_bin2d(data = rob_street_gun,
             aes(x=X, y=Y, fill=cut(..count.., c(0,1,2,3,4,5,6,8,10,Inf)), bins = 20),
             alpha = 0.4)+
  scale_fill_hue("count")

# add contour map
# geom_density2d
sfbase2+
  stat_density2d(data = sf_rob, 
                 aes(x=X, y=Y, alpha=..level.., fill=..level..),
                 size=0.5, bins=10, geom="polygon") + 
  scale_fill_gradient(low = "yellow", high = "red", name = "Level") +
  scale_alpha(range = c(0.00, 0.4), guide = FALSE) +
  geom_density2d(data = sf_rob, aes(x=X, y=Y), 
                 colour="black", bins=10, show_guide=FALSE)

# Interesting functions in ggmap to check distance
mapdist('Columbia University', 'Time Square, New York', mode = 'driving')
mapdist('Columbia University', 'Time Square, New York', mode = 'walking')

#=============== Homicide data with package mapes =================
library(maps)
# basic intro to maps()
map("usa")
map("county")
map("world", "China")
map.cities(country = "China", capitals = 2, label=TRUE)

# read data
homicidedata=read.dbf("Downloads/ncovr/NAT.dbf")
# county.fips is a dataset included in maps
data(county.fips)

# use 6 colors to color the counties according to their homicide rate in 1990
colors = c("#F1EEF6", "#D4B9DA", "#C994C7", "#DF65B0", "#DD1C77", "#980043")
homicidedata$colorBuckets_HR90 = as.numeric(cut(homicidedata$HR90, c(0, 2, 4, 6, 8, 10, 100)))
colorsmatched = homicidedata$colorBuckets[match(county.fips$fips, homicidedata$FIPSNO)]
map("county", col = colors[colorsmatched], 
    fill = TRUE, resolution = 0, 
    lty = 0, projection = "polyconic")

library(mapproj)
# Add border around each State
map("state", col = "white", fill = FALSE, add = TRUE, lty = 1, lwd = 1.0, projection = "polyconic")
title("Homicide Rate per 100k, 1990")
leg.txt <- c("<2%", "2-4%", "4-6%", "6-8%", "8-10%", ">10%")
legend("top", leg.txt, horiz = TRUE, fill = colors, cex=0.5)

#============ other trials ===============

