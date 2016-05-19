#Exploratory Data Analysis and Visualization Course

* [Course Website](http://stat4701.github.io/edav/)


* [Agenda](https://github.com/stat4701/edav/blob/gh-pages/agenda.md)

* [Syllabus/Intro](https://github.com/stat4701/edav/blob/gh-pages/intro.md)

* [Maleki Branches and GitHub](https://github.com/malecki/edav/)
* [Pre-Class Questionnaire](https://docs.google.com/forms/d/1HvALvwpH9VYkhxPkIAx3QpgKjG8JPIs0SJxMiwxXFf4/viewform)

* [Presentation Signup on Slottr](http://www.slottr.com/sheets/76533)

##20150122

##Creating a Branch, and Generating Graphs with RStudio (ggplot)

[R install.packages](http://math.usask.ca/~longhai/software/installrpkg.html)
	
[Google Docs Curl Headache](http://www.r-bloggers.com/a-tiny-rcurl-headache/)	
	
1. fork
2. clone
3. checkout -b <name>
4. mkdir
5. -> create field
6. add 
7. commit
8. push
9. read.csv()
10. merge upstream/gh-pages


Check out GitExtensions (the app). 
	
	
##The Code	
	
	library(RCurl)
	library(ggplot2)
	con <- getURL("https://docs.google.com/spreadsheets/d/19a0O6C14zButypjcnWictvKWeyPjPjQdrps-UXzPDf8/export?format=csv", ssl.verifypeer = FALSE)
	df <- read.csv(textConnection(con), stringsAsFactors=FALSE, check.names=FALSE)

	View(df)

	str(df)


	names(df)

	removeParentheses <- function(x){
	    gsub("\\(.*\\)$", "", x)
	}
	mrOptions <- strsplit("Excel, R, Stata, D3, Gephi, ggplot2, lattice, SQL, git / Github, SPSS, shell (terminal / command line), regular expressions (grep), Rstudio, JSON, Python, Sweave/knitr, Processing (language), C/C++, Leaflet, CartoDB, GeoJSON, node/npm, go language, ruby, LaTeX, Heroku, Make, Pandas, Julia, non-git version control, XML, Web: html css js, vagrant/virtualbox, amazon web services, dropbox, google drive (formerly docs), OpenRefine (formerly Google refine), Pair programming", ", ")[[1]]

	mrOptions <- removeParentheses(mrOptions)
	expandSelections <- function(selected, options){
	    selected <- removeParentheses(selected)
	    sapply(options, grepl, x=selected, fixed=TRUE)
	}
	gridLevels <- c("None", "A little", "Confident", "Expert")
	makeOrderedFactor <- function(col, levels){
	    return (factor(col, levels=levels, labels=levels, ordered=TRUE))
	}
	mrLogical <- t(sapply(df[['Baseline experience']], expandSelections, 
	                      options=mrOptions))

	View(mrLogical)
	sum(mrLogical)

	colSums(mrLogical)

	barplot(colSums(mrLogical))

	qplot(colSums(mrLogical))

	plotdf <- data.frame(count=colSums(mrLogical), item=factor(colnames(mrLogical)))

	plotdf$item <- with(plotdf, reorder(item,count))

	ggplot(plotdf, aes(y=count, x=item)) + geom_bar(stat="identity") + coord_flip()



Notes: Maybe hunt down the CartoDB error, why it doesn't show up in chart. OpenRegine and GeoJSON and Leaflet not showing up. 


##20150120

[Class slides](http://stat4701.github.io/edav/2015/01/20/intro/#/)