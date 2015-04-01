#Install rMaps not in CRAN need devtools for simple install
require(devtools)
install_github('ramnathv/rCharts@dev')
install_github('ramnathv/rMaps')


# Load required packages
library("sqldf")
library("foreign") #pull in date from non csv files
library("rCharts") #interactive charing used for rMaps
library("rMaps") #interfactive map creation

#set the working directory
setwd("~/Main/R/Data Visualization/rMaps Project")

# Download crime data if we don't have it
## From crimenmexico.diegovalle.net/en/csv
## All local crimes at the state level
if (!file.exists("fuero-comun-estados.csv.gz"))
{
  download.file("http://crimenmexico.diegovalle.net/en/csv/fuero-comun-estados.csv.gz", 
                "fuero-comun-estados.csv.gz")
}

#don't reread data is already loaded
if (!exists("crime"))
{
  crime <- read.csv("fuero-comun-estados.csv.gz")

}

#filter to homicides intentional
crime <- sqldf("select * from crime where crime == 'HOMICIDIOS' and type == 'DOLOSOS'")

#aggregate and filter
hom <- sqldf("Select state_code,year,type, sum(count) as total, avg(population) as population, sum(count) / (population * 100000) as rate from crime where year > 1997 and year < 2013  group by state_code,year,type order by state_code, year")

#file with code to state mappings
codes <- read.csv2("states.csv", header = TRUE, sep = ",", quote = "\"")

#remove col 1, convert types, rename column headers
codes <- codes[-1]
codes$NAME <- iconv(codes$NAME, "windows-1252", "utf-8")
codes$CODE <- as.numeric(codes$CODE)
names(codes) <- c("state_code", "name")

#join state code names with numbers
hom <- sqldf("select * from hom join codes on hom.state_code = codes.state_code")

## set date for the ichoropleth map
library("rMaps")
d1 <- ichoropleth(rate ~ name, data = hom, ncuts = 9, pal = 'YlOrRd', 
                  animate = 'year',  map = 'states'
)


#json file contains description of mexican states locations
d1$set(
  geographyConfig = list(
    dataUrl = "https://dl.dropboxusercontent.com/u/10794332/mx_states.json"
  ),
  scope = 'states',
  setProjection = '#! function( element, options ) {
  var projection, path;
  projection = d3.geo.mercator()
  .center([-89, 21]).scale(element.offsetWidth)
  .translate([element.offsetWidth / 2, element.offsetHeight / 2]);
  
  path = d3.geo.path().projection( projection );
  return {path: path, projection: projection};
  } !#'
)

#show in viewer and save html output
d1
d1$save('rMapsMexicoDataMap.html', cdn = TRUE)
