#Exploratory Data Analysis and Visualization Course

* [Course Website](http://stat4701.github.io/edav/)


* [Agenda](https://github.com/stat4701/edav/blob/gh-pages/agenda.md)

* [Syllabus/Intro](https://github.com/stat4701/edav/blob/gh-pages/intro.md)

* [Maleki Branches and GitHub](https://github.com/malecki/edav/)


##20150122

##Creating a Branch
	
	
1. fork

2. clone

3. checkout -b <name>

4. mkdir

5. -> create fiel

6. add 

7. commit

8. push

9. read.csv()

10. merge upstream/gh-pages

11. 


Check out GitExtensions (the app). 
	
	
##The Code	
	library(RCurl)
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

[Class slides](http://stat4701.github.io/edav/2015/01/20/intro/#/)

##20150120

[Class slides](http://stat4701.github.io/edav/2015/01/20/intro/#/)