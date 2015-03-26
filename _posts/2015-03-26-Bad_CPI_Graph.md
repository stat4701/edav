Bad Graph Critique and Improvement
===========================================

I found a graph of CPI in US [here](http://data.bls.gov/pdq/SurveyOutputServlet?request_action=wh&graph_name=CU_cpibrief).

![alt text](pic.png)

### Some criticism of the graph
This graph represents the monthly change over the previous 10 years, but is confusing and misleading (as I have seen several times elsewhere).
It is misleading in several ways:

1. The title on the top of the page is "Consumer Price Index", but the title of the graph is "Comsumer Price Index for All Urban Comsumers: U.S. City Average, All Items and All Items Less Food and Energy". The two concepts indicate data measured by different scales. Readers will be confused at first glance of this webpage.

2. The title mismatches the vertical axis. The title talks about CPI while the y axis label is "12-month percent change".

3. The biggest misleading point of this graph is that what the graph really wants to show is the change of CPI (or inflation), not CPI itself. By looking at this graph careleesly, we may think that the price index has decreased over the past years. But actually it doesn't. Only negative values in the graph indicate decrease in CPI. If interpreted properly, this graph is saying that the 12-month change of CPI is mostly positive over past years.

4. The data used to make this plot is the 12-month percent change of CPI, that is, the changes are calculated on a year-on-year basis, not the more intuitive "changes" that divide CPI's by the CPI's of prior months. Therefore this graph does not make straightforward sense to readers.

5. The title of the graph is too long, and the two curves are not very clearly distinguishable in colors.

### Suggested improvements
To make the presentation of CPI data clearer, I'd suggest several improvements.(So long as I can get the data.)

1. I will shorten the title of graph, and address the difference of two curves by adding legend.

2. Make separate graphs on indecces: one for CPI, one for month-on-month changes in CPI, and one for year-on-year CPI. So the presentation of the CPI will be more informative.

### Implement the improvements
There is some [historical data of CPI](http://inflationdata.com/Inflation/Consumer_Price_Index/HistoricalCPI.aspx?reloaded=true). But I did not find good resource for "All items less food and energy". I will use the CPI data as well as data from the [previous webpage](http://data.bls.gov/pdq/SurveyOutputServlet?request_action=wh&graph_name=CU_cpibrief) to make my graphs.


```r
date <- seq(as.Date("2004/1/1"), as.Date("2015/2/1"), by = "month")
CPI <- c(185.200, 186.200, 187.400, 188.000, 189.100, 189.700, 189.400, 189.500, 189.900, 190.900, 191.000, 190.300,
        190.700, 191.800, 193.300, 194.600, 194.400, 194.500, 195.400, 196.400, 198.800, 	199.200, 197.600, 196.800,
        198.300, 198.700, 199.800, 201.500, 202.500, 202.900, 203.500, 203.900, 202.900, 201.800, 201.500, 201.800,
        202.416, 203.499, 205.352, 206.686, 207.949, 208.352, 208.299, 207.917, 208.490, 208.936, 210.177, 210.036,
        211.080, 211.693, 213.528, 214.823, 216.632, 218.815, 219.964, 219.086, 218.783, 216.573, 212.425, 210.228,
        211.143, 212.193, 212.709, 213.240, 213.856, 215.693, 215.351, 215.834, 215.969, 216.177, 216.330, 215.949,
        216.687, 216.741, 217.631, 218.009, 218.178, 217.965, 218.011, 218.312, 218.439, 218.711, 218.803, 219.179,
        220.223, 221.309, 223.467, 224.906, 225.964, 225.722, 225.922, 226.545, 226.889, 226.421, 226.230, 225.672,
        226.665, 227.663, 229.392, 230.085, 229.815, 229.478, 229.104, 230.379, 231.407, 231.317, 230.221, 229.601,
        230.280, 232.166, 232.773, 232.531, 232.945, 233.504, 233.596, 233.877, 234.149, 233.546, 233.069, 233.049,
        233.916, 234.781, 236.293, 237.072, 237.900, 238.343, 238.250, 237.852, 238.031, 237.433, 236.151, 234.812,
        233.707, 234.722)
```

First I make a plot of CPI over the previous years, so the real values of CPI is clear.

```r
oc <- data.frame(CPI =CPI, date = date)
library(ggplot2)
p1 <- ggplot(oc, aes(date, CPI)) + geom_ribbon(ymin = 0, ymax = CPI, fill = "coral") + ggtitle("Consumer Price Index for All Urban Consumers") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black"))
```

Unfortunately I did not find good resource for CPI of "All items less food and energy". If I have that data, I will add them to the above chart as another mass with a different color, so we can compare the two measures of CPI in a single graph.

Here is a CPI's monthly and 12-month percent change plot, so the inflation over time is clear. The monthly change makes more intuitive senses, while the yearly change avoids seasonal effects. 

```r
mc <- (CPI[13:134] / CPI[12:133] - 1) * 100
ybyc <- (CPI[13:134] / CPI[1:122] - 1) * 100
change <- data.frame(date = rep(date[13:134], 2), change = c(mc, ybyc), measure = c(rep("Monthly change", 122), rep("Yearly change", 122)))
p2 <- ggplot(change, aes(date, change, colour = measure)) + geom_line() + labs(y = "percent change of CPI") + ggtitle("Consumer Price Index Change for All Urban Consumers") + geom_hline(aes(yintercept = 0))
print(p2)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png) 

In fact the monthly change of CPI should be more volatile than the yearly change, but the above graph did not show the greater volatility of monthly change, because the scale of monthly percent change and yearly scale change are different. If I multiply the monthly change by 12, the difference in volatilitie is clear.

```r
changes <- data.frame(date = rep(date[13:134], 2), change = c(mc * 12, ybyc), measure = c(rep("Monthly change", 122), rep("Yearly change", 122)))
p3 <- ggplot(changes, aes(date, change, colour = measure)) + geom_line() + labs(y = "percent change of CPI") + ggtitle("Consumer Price Index Change for All Urban Consumers") + geom_hline(aes(yintercept = 0))
print(p3)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

And if I really want to address the original question, 12-month percent change of the CPI of all items and CPI of all items less food and energy, I will plot it as follows.

```r
lfe <- c(2.3, 2.4, 2.3, 2.2, 2.2, 2.0, 2.1, 2.1, 2.0, 2.1, 2.1, 2.2,
         2.1, 2.1, 2.1, 2.3, 2.4, 2.6, 2.7, 2.8, 2.9, 2.7, 2.6, 2.6,
         2.7, 2.7, 2.5, 2.3, 2.2, 2.2, 2.2, 2.1, 2.1, 2.2, 2.3, 2.4, 
         2.5, 2.3, 2.4, 2.3, 2.3, 2.4, 2.5, 2.5, 2.5, 2.2, 2.0, 1.8,
         1.7, 1.8, 1.8, 1.9, 1.8, 1.7, 1.5, 1.4, 1.5, 1.7, 1.7, 1.8,
         1.6, 1.3, 1.1, 0.9, 0.9, 0.9, 0.9, 0.9, 0.8, 0.6, 0.8, 0.8,
         1.0, 1.1, 1.2, 1.3, 1.5, 1.6, 1.8, 2.0, 2.0, 2.1, 2.2, 2.2,
         2.3, 2.2, 2.3, 2.3, 2.3, 2.2, 2.1, 1.9, 2.0, 2.0, 1.9, 1.9,
         1.9, 2.0, 1.9, 1.7, 1.7, 1.6, 1.7, 1.8, 1.7, 1.7, 1.7, 1.7,
         1.6, 1.6, 1.7, 1.8, 2.0, 1.9, 1.9, 1.7, 1.7, 1.8, 1.7, 1.6,
         1.6, 1.7)
d <- data.frame(date = rep(date[13:134], 2), cc = c(ybyc, lfe), type = c(rep("All_items", 122), rep("All_items_less_food_and_energy", 122)))
library(grid)
library(reshape2)
p <- ggplot(d, aes(date, cc, colour = type)) + geom_line() + labs(y = "12-month percent change") + ggtitle("Consumer Price Index Change for All Urban Consumers") + theme(plot.background=element_rect(fill="white"), plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm")) + scale_fill_continuous(guide = guide_legend()) + theme(legend.position="bottom") + geom_hline(aes(yintercept = 0))
print(p)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png) 

This is much more accurate than the original graph
![alt text](pic1.png)
