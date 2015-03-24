---
title: "Robert Piccone's Graph Critique and Improvement: The Genographic Project"
author: "Robert Piccone"
output: html_document
layout: post
description: Graph Critique and Improvement blog post
tags: assignments
---

I recently submitted a DNA sample to National Geographic's <a href="https://genographic.nationalgeographic.com/about/">Genographic Project</a>. 
The project mission is certainly a worthy one, but the results provided back to participants could use a little more detail and polish.

One of the charts The Genographic Project provides is your hominin ancestry - that is, the percentages of your DNA purported to be of Neanderthal and Denisovan origin respectively.

Here's how they depicted my non-Homo-Sapien-ness:

![Your Hominin Ancestry]({{ site.url }}/edav/assets/rap2186/piccone-bp1.png)
<cite>Source: https://genographic.nationalgeographic.com/results/dashboard (must be logged in to view actual results)</cite>

Where to begin on this?..

I find the series of blue-grey hues to be distractingly similar to each other, and to make matters worse, the hue of the stated percentage does not match its corresponding arc. 

The 3rd and outermost arc along with the text at the bottom would seem to depict 2.1% as the average amount of both Neanderthal and Denisovan DNA for all humans born outside of Africa.
The only problem is that those details are contradicted in the following "Explore Your Results" page (more on that to follow).

The use of a circle and arcs doesn't seem like the best way to convey this information, as it implies that the circle represents a maximum or total amount that holds some significance.
The surrounding arcs representing the percentages appear to be sized in relative proportion to each other, and they visually seem to make up about 75% of the circle. This would imply that the full circle represents a combined non-Homo-Sapien ancestry of around 7.6%.
After browsing the entire site, I did find some explanatory details on <a href="https://genographic.nationalgeographic.com/v/#Hominin">this page</a>:  which states "you may find you have a small percentage (between 0 to 8 percent) of Neanderthal or Denisovan ancestry".
This at least explains the choice and the significance of the circle, but even if they were to include that detail on the same page as the graph (or at the very least link directly to it) I still don't think this is an effective data visualization. I have serious doubts that the purported upper limit of 8% is in any way meaningful, because
there is no information provided on the the standard deviation, sample size, or methodology used to come up with that figure. My assumption is that the 8% upper limit is a proverbial "black swan" - i.e. it is believed no living human would have a total above 8% because thus far, no human observed has come close to surpassing this amount.
It states explicitly in the linked "Explore Your Results" page that the science on this is very new, and that your results may change in the future as discoveries are made. This affirms my belief that displaying hominid percentages in the context of a circle representing 8% of the human genome is at worst misleading and at best irrelevant.

Moving on to the "Explore Your Results" page...

![Explore Your Results]({{ site.url }}/edav/assets/rap2186/piccone-bp2.png)
<cite>Source: https://genographic.nationalgeographic.com/results/dashboard (must be logged in to view actual results)</cite>

The text is interesting enough, but it states clearly that "Most non-Africans are about 2 percent Neanderthal and slightly less than 2 percent Denisovan". 
So why was the 2.1% arc double labelled as the average for both Neanderthal and Denisovan in the results chart? Is this supposed to be an "average of averages" or was it a flat-out error?

And once again, we see data being presented with circles that do not appear to convey any meaningful information. Why is the 1.9% circle larger than the 3.6% circle?

Following is an alternative data visualization I have come up with to address the issues I found to be problematic:

![Your Hominin Ancestry]({{ site.url }}/edav/assets/rap2186/hominin_dna_dv.png)

The outermost circle represents all of the participant's DNA, and it encompasses 2 inner circles representing their percentages of Denisovan and Neanderthal DNA. 
Both are labelled with their respective percentage values and sized so that their respective areas are proportional to each other and to the area of the outermost circle.
In other words, the circle representing 1.9% has an area equal to 1.9% of the outermost circle. The 2 inner circles will be enveloped within the outer circle up to a value of about 21%, which should be sufficient for everyone born in the last 20,000 years or so.
The average observed percentages for Neanderthal and Denisovan DNA are depicted with dotted outlines of circles centered over the circles representing their respective actual results for the participant, and are sized to the same scale, making the comparison of actual to average results visually accurate and obvious.
Finally, green and blue are used to contrast the Denisovan data from the Neanderthal data, with light blue/light green used for the result value circles and dark blue/dark green used for the average value circles.
This allows the dotted circle outlines to be always be visible, while keeping the blue/green contrast between Neanderthal and Denisovan consistent.

I created this graphic with ggplot2 in R markdown with this code:
<pre>
library(ggplot2)
makeCircle <- function(center = c(0,0),area = 100, npoints = 100){
	r <- sqrt(area/pi)
    tt <- seq(0,2*pi,length.out = npoints)
    xx <- center[1] + r * cos(tt)
    yy <- center[2] + r * sin(tt)
    return(data.frame(x = xx, y = yy))
}

neanderthalPct = 1.9
denisovanPct = 3.6

totalDNA <- makeCircle()
neanderthalDNA <- makeCircle(c(3,0),neanderthalPct)
denisovanDNA <- makeCircle(c(-3,0),denisovanPct)
avgNeanderthalDNA <- makeCircle(c(3,0),2.1)
avgDenisovanDNA <- makeCircle(c(-3,0),2.1)

thePlot = ggplot(totalDNA,aes(x,y)) + geom_polygon(fill="white") 
thePlot = thePlot + geom_polygon(aes(x=neanderthalDNA$x, y=neanderthalDNA$y,color="Your Neanderthal %"), fill="light blue") 
thePlot = thePlot + geom_polygon(aes(x=denisovanDNA$x, y=denisovanDNA$y, color="Your Denisovan %"), fill="light green")
thePlot = thePlot + geom_path(aes(x=avgNeanderthalDNA$x, y=avgNeanderthalDNA$y, color="Avg Observed Neanderthal (2.1%)"),linetype=3) 
thePlot = thePlot + geom_path(aes(x=avgDenisovanDNA$x, y=avgDenisovanDNA$y, color="Avg Observed Denisovan (2.1%)"),linetype=3)
thePlot = thePlot + scale_color_manual(name='', values=c("Your Denisovan %"="light green", "Your Neanderthal %"="light blue","Avg Observed Denisovan (2.1%)"="dark green", "Avg Observed Neanderthal (2.1%)"="dark blue" ), guide="legend")
thePlot = thePlot + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.ticks = element_blank(), axis.text = element_blank())
thePlot = thePlot + labs(title = "Your Hominin Ancestry", x="",y="", axis.text="")
thePlot = thePlot + annotate("text", x = 3, y = 0, label = paste(neanderthalPct,"%"))
thePlot = thePlot + annotate("text", x = -3, y = 0, label = paste(denisovanPct,"%"))
thePlot = thePlot + guides(color = guide_legend(override.aes = list(linetype=c(3,3,0,0), fill=c("white", "white", "light green", "light blue"))))
thePlot
</pre>

The code could plot different results simply by replacing the values of the neanderthalPct and denisovanPct variables in lines 10 and 11. 
