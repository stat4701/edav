#Install rMaps
require(devtools)
install_github('ramnathv/rCharts@dev')
install_github('ramnathv/rMaps')

#libraries to load
library(rMaps)
library(Quandl)
library(reshape2)
library(knitr)
library(plyr)
library(dplyr)
library(rcharts)

###############################
#Violent Crime Rate heatmap Cholorpleths for US
##############################

#load US Violent Crimerate data from Quandl
vcData = Quandl("FBI_UCR/USCRIME_TYPE_VIOLENTCRIMERATE")

#format Dataframe with html
kable(head(vcData[,1:9]), format = 'html', table.attr = "class=nofluid")

#reshape data to year, state and crime and subset
datm <- melt(vcData, 'Year', 
             variable.name = 'State',
             value.name = 'Crime'
)
datm <- subset(na.omit(datm), 
               !(State %in% c("United States", "District of Columbia"))
)

#format new Dataframe with html
kable(head(datm), format = 'html', table.attr = "class=nofluid")

#transform the data
datm2 <- transform(datm,
                   State = state.abb[match(as.character(State), state.name)],
                   fillKey = cut(Crime, quantile(Crime, seq(0, 1, 1/5)), labels = LETTERS[1:5]),
                   Year = as.numeric(substr(Year, 1, 4))
)
kable(head(datm2), format = 'html', table.attr = "class=nofluid")


#format fill for map
fills = setNames(
  c(RColorBrewer::brewer.pal(5, 'YlOrRd'), 'white'),
  c(LETTERS[1:5], 'defaultFill')
)


#use dply to create LargeList format of data for map
dat2 <- dlply(na.omit(datm2), "Year", function(x)
{
  y = toJSONArray2(x, json = F)
  names(y) = lapply(y, '[[', 'State')
  return(y)
})


#### End data munging section

#Siplest R Chart example static map could have used GGMaps

options(rcharts.cdn = TRUE)
map <- Datamaps$new()
map$set(
  dom = 'chart_1',
  scope = 'usa',
  fills = fills,
  data = dat2[[1]],
  legend = TRUE,
  labels = TRUE
)
map

map2 = map$copy()
map2$set(
  bodyattrs = "ng-app ng-controller='rChartsCtrl'"
)
map2$addAssets(
  jshead = "http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.2.1/angular.min.js"
)

map2$setTemplate(chartDiv = "
  <div class='container'>
    <input id='slider' type='range' min=1960 max=2010 ng-model='year' width=200>
    <span ng-bind='year'></span>
    <div id='' class='rChart datamaps'></div>  
  </div>
  <script>
    function rChartsCtrl($scope){
      $scope.year = 1960;
      $scope.$watch('year', function(newYear){
        map.updateChoropleth(chartParams.newData[newYear]);
      })
    }
  </script>"
)

map2$set(newData = dat2, scope = 'usa')
map2



map3 = map2$copy()
map3$setTemplate(chartDiv = "
  <div class='container'>
    <button ng-click='animateMap()'>Play</button>
    <div id='chart_1' class='rChart datamaps'></div>  
  </div>
  <script>
    function rChartsCtrl($scope, $timeout){
      $scope.year = 1960;
      $scope.animateMap = function(){
        if ($scope.year > 2010){
          return;
        }
        mapchart_1.updateChoropleth(chartParams.newData[$scope.year]);
        $scope.year += 1
        $timeout($scope.animateMap, 1000)
      }
    }
  </script>"
)
map3


map$set(dom = 'chart_1', newData = dat2, scope = 'usa', fills = fills, legend = TRUE, labels = TRUE)
map



#shows the 1 line of code needed to create 

source('ichoropleth.R')
ichoropleth(Crime ~ State,
            data = datm2[,1:3],
            pal = 'PuRd',
            ncuts = 5,
            animate = 'Year'
)


#R Code #2



###############################
#call a Leaflet map and apply a heatmap on top of it
##############################


library(rMaps)
L2 <- Leaflet$new()
L2$setView(c(29.7632836,  -95.3632715), 10)
L2$tileLayer(provider = "MapQuestOpen.OSM")
L2
#get the data
data(crime, package = 'ggmap')
library(plyr)
crime_dat = ddply(crime, .(lat, lon), summarise, count = length(address))
crime_dat = toJSONArray2(na.omit(crime_dat), json = F, names = F)
cat(rjson::toJSON(crime_dat[1:2]))
#heatmap it
# Add leaflet-heat plugin. Thanks to Vladimir Agafonkin
L2$addAssets(jshead = c(
  "http://leaflet.github.io/Leaflet.heat/dist/leaflet-heat.js"
))

# Add javascript to modify underlying chart
L2$setTemplate(afterScript = sprintf("
<script>
  var addressPoints = %s
  var heat = L.heatLayer(addressPoints).addTo(map)           
</script>
", rjson::toJSON(crime_dat)
))
L2

