---
title: "Crossfilter and Dimensional Charting (with Cameo Appearances by GeoJson and RawGit)"
author: "Robert Piccone"
output: html_document
layout: post
description: Crossfilter / Dimensional Charting Demo 
tags: assignments
---

<a href="http://dc-js.github.io/dc.js/">Dimensional Charting</a> is a javascript graphing library that leverages 
<a href="http://d3js.org">D3's</a> ability to bind data to a manipulatable <a href="http://en.wikipedia.org/wiki/Document_Object_Model">Document Object Model (DOM)</a>
and <a href="http://square.github.io/crossfilter/">Crossfilter's</a> ability to slice and dice data along multiple dimensions.

The website of the <a href="http://www.bls.gov">Bureau of Labor and Statistics (BLS) </a> contains a vast library 
of the economic data they collect and publish. While the site provides an API to pull targeted subsets of data,
their comprehensive tab-delimited datasets are particularly good candidates for showcasing Crossfilter and DC's
ability to visually interact with a dimensionable dataset.

 <a href="../../../../assets/rap2186/blscrossfiltermap.html">Linked here</a> is a set of cross-linked interactive charts based on National Compensation Survey data.
The code is written exclusively in HTML and Javascript, using <a href="https://rawgit.com">RawGit</a> to directly fetch the crossfilter.js, dc.js and d3.js javascript libraries directly from GitHub.
It is referencing 3 source files:
 - the <a href="http://download.bls.gov/pub/time.series/nc/nc.data.1.AllData">primary data source file</a>, a 19.2 MB tab delimited file from the BLS containing survey results on compensation by month and by state
 - a <a href="http://download.bls.gov/pub/time.series/nc/nc.state">tab delimited file</a> from the BLS mapping the state numeric codes in the data file to state names (used to tie 
 - a 2.5 MB <a href='http://geojson.org'>GeoJSON</a> file used to power the D3 choropleth map of the U.S.
 	- the GeoJson file used, along with data files at the state and county level, and at varying resolutions, were thoughtfully created and shared by <a href="http://eric.clst.org/Stuff/USGeoJSON"> Eric Celeste</a> using cartographic data collected by the U.S. Census Bureau
 
The first field of the primary source data consists of a series ID which itself encodes multiple data points as follows:
<pre>
	Series ID   NCU5306633300003
	Positions       Value           Field Name
	1-2             NC              Prefix
	3               U               Seasonal Adjustment Code 
	4-5             53              State Code
	6-9             0663            Area Code
	10-14           33000           Occupation Code
	15-16           03              Level Code
</pre>

In the example code, D3 parses the series ID into multiple dimensions that crossfilter and DC can access.
The list of state code values contain not only each state, but also a group of regions and a single code representing all states. Therefore, the first task in enabling the visualization was using crossfilter's ability to filter the data - in this case, filtering out the regional and national codes, so that our totals are not tripling the true total value upon aggregation.

The data visualization consists of a bar graph listing the total compensation reported nationally for each year covered in this survey data, which is cross-linked to a choropleth U.S. map with a heat index by state from pink to red for each currently selected state, and a ring chart depicting the proportion of the actively selected totals by state.
Each of the 3 chart objects has a selector that will dynamically update the other 2 chart objects, so that all 3 are representing the current active selection.
Specifically, the bar chart has a slider to select across one or many years, the map and ring charts are clickable to activate one, some, or all of the U.S. states.

The immediate discovery I made upon successfully enabling a working implementation of the visualization is that not every state is represented in every month of the compensation survey, and a handful of states rarely, or never are represented.
While this makes the data represented of limited interest as a self-contained dataset, it is still an excellent demonstration of Crossfilter and DC's ability to visually explore and assess large datasets.

Another obvious shortcoming of this particular data visualization is that the heat mapped totals of compensation by state is really a representation of each state's population.
With an additional dataset of U.S. Population by state and by year pulled into this page, the script could be enhanced to add population by state and year as another dimension, and DC could then use that additional dimension to index the heat map to show total compensation by state per person.
 
Following is the HTML/Javascript code for the example interactive visualizations of the National Compensation Survey:

{% highlight html %}
<meta http-equiv="content-type" content="text/html; charset=UTF8"> 

<script type="text/javascript" src="https://cdn.rawgit.com/square/crossfilter/master/crossfilter.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/mbostock/d3/master/d3.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/dc-js/dc.js/master/dc.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/dc-js/dc.js/master/dc.css" media="screen" /> 


<div align=center id="chart-bar-ymvals"> <h1>Annual National Compensation Survey</h1> </div>

<div align=center id="us-chart"><h2>Totals By State</h2> </div>

<div float=left align=center id="chart-ring-state"><h2>Proportion By State</h2></div>
<script>

d3.json("./gz_2010_us_040_00_500k.json", function(error, statesJson){
d3.tsv("./nc.state", function(stateData) {
d3.tsv("./nc.data.1.AllData", function(data) {

  // Run the data through crossfilter 
	var states = crossfilter(stateData);
	var stCodeDim = states.dimension(function(d) {return d.state_code;});
	var facts = crossfilter(data);
	var parseDate = d3.time.format("%Y").parse;
	
  // Parse the series id field into its respective dimensions, 
  // and assign a state name dim using the mapped state code value
	data.forEach(function(d) {
		d.seasonal_ac= d.series_id.substr(2,1);
		d.state_cd= +d.series_id.substr(3,2);
		stCodeDim.filter(d.series_id.substr(3,2));
		d.stateName=stCodeDim.top(1)[0].state_name;
		stCodeDim.filterAll();
		d.area_cd= d.series_id.substr(5,4);		
		d.occupational_cd= d.series_id.substr(9,5);		
		d.level_cd= d.series_id.substr(14,2);		
		d.year= parseDate(d.year);
		d.value= +d.value.trim().substr(1);
	});

	var stateDim  = facts.dimension(function(d) {return d.state_cd;});
	stateDim.filter(0); 
	facts.remove();
	stateDim.filterAll();
	stateDim.filter([56,80]);
	facts.remove();
	stateDim.filterAll();
	
	var sacDim = facts.dimension(function(d) {return d.seasonal_ac;});
	sacDim.filter("S");
	facts.remove();
	sacDim.filterAll();

 // Create  dimensions
	var stNameDim  = facts.dimension(function(d) {return d.stateName;});
	var stName_total = stNameDim.group().reduceSum(function(d) {return d.value;});
	var state_total = stateDim.group().reduceSum(function(d) {return d.value;});
	var stNameDim2  = facts.dimension(function(d) {return d.stateName;});
	var stName_total2 = stNameDim2.group().reduceSum(function(d) {return d.value;});
			  
  	var dateDim = facts.dimension(function (d) {return d.year;});
	var ymtotal = dateDim.group().reduceSum(function(d) {return d.value;}); 
	var minDate = dateDim.bottom(1)[0].year;
	var maxDate = dateDim.top(1)[0].year;

 // Setup the charts
var ymValsChart  = dc.barChart("#chart-bar-ymvals"); 
ymValsChart
	.width(800).height(300)
	.dimension(dateDim)
	.group(ymtotal)
	.x(d3.time.scale().domain([minDate,maxDate])) 
	.elasticX(true)
	.elasticY(true)
	.centerBar(true)
	.margins({top: 10, right: 50, bottom: 30, left: 40})
	.renderTitle(false)
	.yAxisLabel("", 100)
	.xUnits(function(){return 10;});
	
var stateRingChart   = dc.pieChart("#chart-ring-state");
stateRingChart
    .width(250).height(250)
    .dimension(stNameDim2)
    .group(stName_total2)
    .innerRadius(30); 

var mapChart = dc.geoChoroplethChart("#us-chart");
mapChart
	.width(1000).height(500)
    .dimension(stNameDim)
	.group(stName_total)
	.colors(d3.scale.linear().domain([0,330000]).range(["pink","red"]))
	.overlayGeoJson(statesJson.features, "state", function(d) {
    return d.properties.NAME;});

dc.renderAll(); 
});
});
});
</script>
{% endhighlight %}
