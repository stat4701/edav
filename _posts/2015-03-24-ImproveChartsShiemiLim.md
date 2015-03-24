
<h1>Improving Chart Blog Post<h1>
<h2>Shiemi Lim<h2>

========================================================
The charts that I would like to improve on are from the National Priorities Project on the US Federal Reserve Spending and Revenue. In general, when googling ‘Federal Spending’, most of the image results come back as pie chart. 

I recall reading Tuft ‘s quote on pie charts:

“A table is nearly always better than a dumb pie chart; the   only worse design than a pie chart is several of them, for    then the viewer is asked to compare quantities located in    spatial disarray both within and between charts [...] Given    their low density and failure to order numbers along a        visual dimension, pie charts should never be used.”


Below are examples from this site:


<img src="https://media.nationalpriorities.org/uploads/publications/discretionary-spending-2015.png" alt="spending" height="400" width="500"> 



<img src="https://media.nationalpriorities.org/uploads/publications/mandatory-spending-2015.png" alt="spending" height="400" width="500"> 

<img src="https://www.cbo.gov/sites/default/files/cbofiles/images/pubs-images/49xxx/49892-land-table1.png" alt="revenue" height="400" width="500"> 


<img src="https://static.nationalpriorities.org/images/fb101/2014/projected-tax-revenue.png" alt="revenue2015" height="400" width="500"> 


<img src="https://www.nationalpriorities.org/media/uploads/revenue_-_revenue_pie_2014_big.png" alt="revenue2015" height="400" width="500"> 

<img src="https://www.nationalpriorities.org/media/uploads/federal_budget_101/Figure8.5.png" alt="revenue2015" height="400" width="500"> 
source:

These charts can confuse, especially if the viewer has to exert effort into thinking whether the chart is related to spending or revenue, whether the orange color in the pie chart means Veteran's benefit or Payroll Taxes. The viewer may have to look to all areas of the charts to absorb the percentage break down of the information. There is also no way to compare the charts by year.  

To improve on the visualizations of US Federal Spending and Revenue information, I would replace the pie charts with bar charts. Doing so can enable the viewer to compare the breakdown of expenditure across the years. I would organize the visualization so that it would have a flow, the most high level information comes first, as one summary chart, which leads into the expenditure chart, and finally the revenue chart so as to let the viewer digest small pieces of information at a time.  
I would use semantically resonant colors like blue and red to emphasize the dollars flowing in and out.  Federal Expenditure can be generally grouped into two buckets, Mandatory and Discretionary.  I would assign different shades of the same color to these so that the viewer would notice that these two are part of the spending bucket. 

<h3>Summary 2015</h3>
```{r error=FALSE, message=FALSE, warning=FALSE, echo=FALSE}
require(plotly)
py <- plotly(user="shemster", key="x57g8quka0")
```

```{r}
library("knitr")
library("devtools")
url<-"https://plot.ly/~shemster/286/revenue-vs-spending/.embed?width=200&height=300" 
plotly_iframe <- paste("<center><iframe scrolling='no' seamless='seamless' style='border:none' src='", url, 
    "/800/1200' width='700' height='800'></iframe><center>", sep = "")
```
`r I(plotly_iframe)`
```{r}
url<-"https://plot.ly/~shemster/253/_100-federal-reserve-expenditure-2015-3720-billion/.embed?width=200&height=300" 
plotly_iframe <- paste("<center><iframe scrolling='no' seamless='seamless' style='border:none' src='", url, 
    "/800/1200' width='700' height='400'></iframe><center>", sep = "")
```
`r I(plotly_iframe)`
```


```{r}
url<-"https://plot.ly/~shemster/293/_2015-breakdown-of-discretionary-expenditure/.embed?width=500&height=400" 
plotly_iframe <- paste("<center><iframe scrolling='no' seamless='seamless' style='border:none' src='", url, 
    "/800/1200' width='700' height='400'></iframe><center>", sep = "")
```
`r I(plotly_iframe)`
```


```{r}
url<-"https://plot.ly/~shemster/299/_2015-mandatory-expenditure-69-of-expenditure/.embed?width=500&height=400" 
plotly_iframe <- paste("<center><iframe scrolling='no' seamless='seamless' style='border:none' src='", url, 
    "/800/1200' width='700' height='400'></iframe><center>", sep = "")
```
`r I(plotly_iframe)`
```



```{r}
url<-"https://plot.ly/~shemster/309/revenue-as-a-percentage/.embed?width=500&height=400" 
plotly_iframe <- paste("<center><iframe scrolling='no' seamless='seamless' style='border:none' src='", url, 
    "/800/1200' width='700' height='400'></iframe><center>", sep = "")
```
`r I(plotly_iframe)`
```




