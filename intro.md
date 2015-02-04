---
layout: page
title: "Intro"
description: "Goals and Objectives"
---
{% include JB/setup %}
    
# Overview
This class is about two things, right there in the title: iteratively drawing pictures with quantitative data, building models with the data, and drawing pictures of both the models and the data. Our goal is to master contemporary software that will enable you to explore data to generate hypotheses, and convey features and relationships to others. The two dead-tree textbooks speak to both of these goals. Along the way we will read a lot of other prose and a fair amount of code, and you will be able to evaluate graphical decisions of all kinds that relate to what Edward Tufte termed "the visual display of quantitative information."

>Data Scientist (n.): Person who is better at statistics than any software engineer and better at software engineering than any statistician.
> —[Josh Wills](https://twitter.com/josh_wills/status/198093512149958656)

I’d like to be largely programming-language-agnostic with respect to your assignments. One of the fundamental texts (Wilkinson) was written in conjunction with a pretty dated technology (SYSTAT), later acquired by SPSS (itself eventually acquired by IBM), and if that’s your language of choice, by all means try and do the assignments in it (I suspect this will be hard to do well). It is fair to say that the reference implementation of Wilkinson’s ideas is Hadley Wickham’s R version, called [ggplot2](http://ggplot2.org). The other paradigm is the functional one of Trellis/[Lattice](http://lmdvr.r-forge.r-project.org/figures/figures.html), and Deepayan Sarkar’s R implementation is standard. If you are an accomplished Pythonista and adept in [Matplotlib](http://matplotlib.org) (and probably [Pandas](http://pandas.pydata.org)), by all means do your assignments in Python. Finally, on the cutting edge, many things are moving toward the browser, and [D3.js](http://d3js.org) (Data-Driven Documents) is the lingua franca. Making your graphs with it will probably be the most challenging, but if you choose to study it in depth, I would expect that it will be the most rewarding in terms of the tricks and techniques you develop in this class.

# Objectives #

1. Learn enough to be dangerous about the modern high- and low-level languages and libraries
1. Master the everyday, mundane but indispensible tools of the trade: text editors, version control, and the command line
1. Practice iterative and collaborative (yes, even Agile) development of your projects
1. Initiate and participate in code and project reviews
1. Fail early, learn from it, and ask for help

We are here to do what we can to prevent this grim future:

![xkcd infographics](http://imgs.xkcd.com/comics/tall_infographics.png)

# Goals #

1. Think like a data scientist about data visualization
1. Code like a data scientist
1. Do a data science project with a strong visual component

## Think like a data scientist ##

This means approaching data, especially graphs, with an especially critical eye, informed by theory, and being able to say things like:

- This is misleading
- This would be clearer if
- This overëncodes data
- Why can’t I hover over this and see that

There are two related projects throughout the semester. The first will be a series of “blog posts” in the style of Kaiser Fung’s [junkcharts](http://junkcharts.typepad.com) blog — that is, not just to critique, but to replicate and improve, visual presentations of data “in the wild.” Although it is a  Sisyphean task, help purge the world of bad graphs! These assignments are meant to be equal parts theoretic and practical: you will have to identify problems or bad decisions someone else made along the way, make and justify better ones, acquire (or approximate) the input data, and use all the software tools at your disposal to help fix the scourge of misleading graphics.

## Code like a data scientist ##

Coming up with constructive criticism is one thing. Implementing your ideas is another. 

### Produce something new and cool yourself ###

>Working with data is hard. Data is -- or are -- ugly.

This goal means: you have to choose some dataset(s) and figure out what you're modeling in them, and how. The readings, links, code reviews, and your fellow classmates are your resources to achieve this goal. You will enumerate the objectives for your final project, and in teams with your peers, assess your progress. Your final project should be something you intend to share with a wider audience than just your classmates. 

You will get out of the class benefit in proportion to the effort you expend. 

# Requirements

### Bad Graph Critique and Improvement blog post (30%)

  This is an individual effort styled after Kaiser Fung’s [Junk Charts](http://junkcharts.com), with a heavy, tedious technical component.

  1. Think about the graph(s) and write about it critically using the theoretical framework underpinning data visualization (marks, scales, transformations, statistics, etc; the Grammar of Graphics; visual semantics). This part doesn’t involve any code.
  1. In light of your own criticism, design an improvement. You might want to sketch on paper, a napkin, or a board, and include a picture.
  1. Attempt to implement your improvement.
  1. Document your implementation.
  1. Make your discussion, design, implementation, and documentation publicly available on your fork of the repository. This involves fighting with github, Jekyll, and gh-pages.
  1. Prepare and submit your blog post from your fork as a pull request to the class repository. This means that it merges cleanly, includes only the files it should, and is rebased onto `upstream/gh-pages`.

  Submitted as pull requests of markdown or html on github, examining published graphs and improving them. Entries should include:
     - source of original with link
     - discussion of what was wrong with the graph in the first place
     - theoretical improvements — if the problem is a color scale, what are you replacing a rainbow with?

  Either in your post or in a link (such as to Plunker or a Gist / bl.ocks rendering): 
     - methods (preferably code; inline, included, or linked to a branch on your fork of the repo) for retrieving and extracting the data used.
     - if the data in ‘raw’ form was not suitable for plotting, code to reshape / ‘clean’ the data
     - if applicable, a link to the clean data file you used
     - code (inline, markdown) to create your replacement graphic(s)


### A project in your area of specialization using statistical graphics, executed as a team of 4 or 5 (30%)

   - Iteration/sprint plans, progress assessments (10%)
   - The actual project including a presentation (similar in form to another blog post), explaining code / tools / libraries you learned doing the project (20%)

### In-class Topic Presentations (20%)

Each class two pairs of people will ‘own’ a different portion of the assigned external resources (readings, libraries, tutorials). Ownership means you will be the class's expert on the thing you own and present. Non-owners (the rest of the class) are expected to familiarize themselves enough to follow the presentation and engage with questions and suggestions, but not necessarily to have worked examples (though it is encouraged).

Some earlier topics involve ramping up with some basic tools: python, R, git, github, html, javascript, etc. Later topics involve specific libraries and techniques.

You can use whatever tool you want for your presentation, but you will be responsible for providing notes either on the class wiki or as a section to the class page on gh-pages or both. (In other words, no one is going to look at your powerpoint. If you do it right, your blogpost will spread through twitter as a resource for data scientists everywhere.)

### Participation in class — follow along and ask questions during presentations; share your struggles and your triumphs. Use Piazza and stackoverflow to ask and answer questions. (20%)
