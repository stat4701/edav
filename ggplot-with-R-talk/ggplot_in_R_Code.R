require("foreign")
childiq.dat <- read.dta("/Users/kedarpatil/Documents/St-4701 - Data Visualization/gelman/ex3.9.4/child.iq.dta")

require("ggplot2")


#BAR PLOTS
library(MASS)
library(plyr)

#Mom's Education
(bartbl.dat <- ddply(childiq.dat, c("educ_cat"), summarise, FreqCnt=length(educ_cat)))
bartbl.dat

(bp1 <- ggplot(bartbl.dat, aes(x=factor(educ_cat), y=FreqCnt)) + geom_bar(stat="identity"))
(bp2 <- bp1 + geom_text(aes(label=FreqCnt), vjust=-1, size=6))
(bp3 <- bp2 + ggtitle("Distribution of Mom's education"))
(bp4 <- bp3 + theme(plot.title=element_text(size=rel(2), face="bold")))
(bp5 <- bp4 + theme(axis.title=element_text(size=25)))
bp5

#Mom's Age
(bp1 <- ggplot(childiq.dat, aes(x=factor(momage))) + geom_bar(binwidth=0.5) + ggtitle("Distribution of Mom's age"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) + theme(axis.title=element_text(size=25)))
bp2

#Child IQ
(bp1 <- ggplot(childiq.dat, aes(x=factor(ppvt))) + geom_histogram(binwidth=0.5) + ggtitle("Distribution of Child IQ"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) + theme(axis.title=element_text(size=25)))
bp2


#SCATTER PLOTS

#Mom's age vs Child IQ
(bp1 <- ggplot(childiq.dat, aes(x=momage, y=ppvt)) + geom_point(size=2) + ggtitle("Scatter plot Mom's age vs Child IQ"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) + theme(axis.title=element_text(size=25)))
bp2

#Mom's education vs Child IQ  
(bp1 <- ggplot(childiq.dat, aes(x=educ_cat, y=ppvt)) + geom_point() + ggtitle("Scatter plot Mom's education vs Child IQ"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) + theme(axis.title=element_text(size=25)))
bp2

#MATRIX SCATTER PLOT
pairs(childiq.dat[1:3])


#BOX PLOTS

#Mom's education vs Child IQ  
(bp1 <- ggplot(childiq.dat, aes(x=factor(educ_cat), y=ppvt)) + geom_boxplot() + ggtitle("Box plot Mom's education vs Child IQ"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) + theme(axis.title=element_text(size=25)))
bp2

#Mom's education vs Mom's age
(bp1 <- ggplot(childiq.dat, aes(x=factor(educ_cat), y=momage)) + geom_boxplot() + ggtitle("Box plot Mom's education vs Mom's age"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) + theme(axis.title=element_text(size=25)))
bp2

#Mom's age vs Child IQ
(bp1 <- ggplot(childiq.dat, aes(x=factor(momage), y=ppvt)) + geom_boxplot() + ggtitle("Box plot Mom's age vs Child IQ"))
(bp2 <- bp1 + theme(plot.title=element_text(size=rel(2), face="bold")) + theme(axis.title=element_text(size=25)))
bp2



# Spinning 3D scatterplot
# Install X11/XQuartz for Mac
# Install and load rgl package
install.packages("rgl")
require("rgl")
require("RColorBrewer")
plot3d(childiq.dat$momage,  # x variable
       childiq.dat$educ_cat,  # y variable
       childiq.dat$ppvt,   # z variable
       xlab = "Mom age",
       ylab = "Mom education",
       zlab = "ChildIQ",
       col  = "red", 
       size = 3)

