---
layout: post
category : EDAV


---


<script type='text/javascript' src='http://public.tableau.com/javascripts/api/viz_v1.js'></script><div class='tableauPlaceholder' style='width: 940px; height: 739px;'><noscript><a href='#'><img alt='U.S. Population Trends ' src='http:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Po&#47;Population-Pyramid_3&#47;PopulationDashboard&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz' width='940' height='739' style='display:none;'><param name='host_url' value='http%3A%2F%2Fpublic.tableau.com%2F' /> <param name='site_root' value='' /><param name='name' value='Population-Pyramid_3&#47;PopulationDashboard' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='http:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Po&#47;Population-Pyramid_3&#47;PopulationDashboard&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='showVizHome' value='no' /><param name='showVizHome' value='no' /><param name='showTabs' value='y' /></object></div>




### The Visualization

The chart above is featured in Tableau's Visual Gallery. (A collection of charts intended to show off the software's capabilities).  The chart's description is below: 
 
    ---
    This “Population Pyramid” (a type of chart commonly used in demographics) clearly tilts right – demonstrating that females live longer than males and make up a dominant percentage of older age groups. Note that this visual example uses bins on the age field and a simple calculation to split the male population to negative numbers and females to positive. A parameter is used to allow you to select which year of Census data to display. From Census data.  
    ---


### Some Positives


*	It's easier to judge proportions than a bunch of pie charts would be.  
*	The author took the time to change the colours to something more semantically relevant than the Tableau defaults. (Since females are first in the dataset. the chart would default to blue = female, and orange = male.)  
*	Initially, I didn't think the scrollbar at the top was a good way to show different survey years because it's really hard to see change over time.  After [confirming that there really isn't any YoY difference in the estimates]({{ site.baseurl }}/assets/maura_blogpost/genderbycensusyear.png), I changed my mind.  Since there aren't really any differences it doesn't say much or really need to be there.  It's not terrible to have multiple years to show consistency.

### Less Positives

*	It's kind of a weird shape, so I have a hard time telling both how large the total population is in each category and how much it shifts over time.  
*	The regional charts would be fine to have around if they were easier to read, but because of the shape, I really can't judge the regional differences very well if there are any.
*	I don't like seeing population represented in negative numbers.  12MM (Male) - 0 - 12MM (Female) would be much better than the current X-axis.

### Can I do Better (in Tableau)

Since this is an example, the data is easy to download.

![US Population by Age and gender]({{ site.baseurl }}/assets/maura_blogpost/gendervage.png)

Here I'm showing the difference in population (from the 2000 census data) on top and underneath it, the total population by year.  I think it's striking that the gap increases for the older age categories despite how much the overall population shrinks.  (We could show the percentage of the population which is female instead which should be equally impactful.)

(The x-axis label is at the top because I am not a Tableau Expert and it isn't obvious how to move it to the bottom of the chart.  Even though I'm saving as an image to avoid dealing with serving the Tableau workbook, editing the picture feels like cheating)
  
Maura Fitzgerald, mlf2169

