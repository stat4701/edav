---
layout: post
---

## rvest tutorial

*Justin Law and Jordan Rosenblum*

*April 2, 2015*

## What can you do using rvest? 

The list below is partially borrowed from Hadley Wickham (the creator of rvest) and we will go through some of them throughout this presentation.

- Create an html document from a url, a file on disk or a string containing html with html().

- Select parts of an html document using css selectors. Learn more about it using vignette("selectorgadget") after installing and loading rvest in R.

- Extract components with html_tag() (the name of the tag), html_text() (all text inside the tag), html_attr() (contents of a single attribute) and html_attrs() (all attributes).

- You can also use rvest with XML files: parse with xml(), then extract components using xml_node(), xml_attr(), xml_attrs(), xml_text() and xml_tag().

- Parse tables into data frames with html_table().

- Extract, modify and submit forms with html_form(), set_values() and submit_form().

- Detect and repair encoding problems with guess_encoding() and repair_encoding().

- Navigate around a website as if you're in a browser with html_session(), jump_to(), follow_link(), back(), forward(), submit_form() and so on. (This is still a work in progress).

- The package also supports using magrittr for commands.

Also have a look at the three links below for some more information:

<https://github.com/hadley/rvest>

<http://cran.r-project.org/web/packages/rvest/index.html>

<http://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/>

## Starting off simple: Scraping The Lego Movie on imdb


```r
#install.packages("rvest")

library(rvest)

# Store web url
lego_movie <- html("http://www.imdb.com/title/tt1490017/")

#Scrape the website for the movie rating
rating <- lego_movie %>% 
  html_nodes("strong span") %>%
  html_text() %>%
  as.numeric()
rating
```

```
## [1] 7.8
```

```r
# Scrape the website for the cast
cast <- lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()
cast
```

```
##  [1] "Will Arnett"     "Elizabeth Banks" "Craig Berry"    
##  [4] "Alison Brie"     "David Burrows"   "Anthony Daniels"
##  [7] "Charlie Day"     "Amanda Farinos"  "Keith Ferguson" 
## [10] "Will Ferrell"    "Will Forte"      "Dave Franco"    
## [13] "Morgan Freeman"  "Todd Hansen"     "Jonah Hill"
```

```r
#Scrape the website for the url of the movie poster
poster <- lego_movie %>%
  html_nodes("#img_primary img") %>%
  html_attr("src")
poster
```

```
## [1] "http://ia.media-imdb.com/images/M/MV5BMTg4MDk1ODExN15BMl5BanBnXkFtZTgwNzIyNjg3MDE@._V1_SX214_AL_.jpg"
```

```r
# Extract the first review
review <- lego_movie %>%
  html_nodes("#titleUserReviewsTeaser p") %>%
  html_text()
review
```

```
## [1] "The stand out feature of the Lego Movie for me would be the way the Lego Universe was created. The movie paid great attention to detail making everything appear as it would made from Lego, including the water and clouds, and the surfaces people walked on all had the circles sticking upwards a Lego piece would have. Combined with all the yellow faces, and Lego part during building, I was convinced action took place in the Lego Universe.A combination of adult and child friendly humour should entertain all, the movie has done well to ensure audiences of all ages are catered to. The voice cast were excellent, especially Liam Neeson's split personality police officer, making the 2 personalities sound distinctive, and giving his Bad Cop the usual Liam Neeson tough guy. The plot is about resisting an over-controlling ruler, highlighted by the name of the hero's \"resistance piece\". It is well thought through, well written, and revealing at the right times. Full of surprises, The Lego Movie won't let You see what's coming. Best animated film since Wreck it Ralph! Please let there be sequels."
```

## Scraping indeed.com for jobs


```r
# Submit the form on indeed.com for a job description and location using html_form() and set_values()
query = "data science"
loc = "New York"
session <- html_session("http://www.indeed.com")
form <- html_form(session)[[1]]
form <- set_values(form, q = query, l = loc)

# The rvest submit_form function is still under construction and does not work for web sites which build URLs (i.e. GET requests. It does seem to work for POST requests). 
#url <- submit_form(session, indeed)

# Version 1 of our submit_form function
library(httr)
# Appends element of a list to another without changing variable type of x
appendList <- function (x, val)
{
  stopifnot(is.list(x), is.list(val))
  xnames <- names(x)
  for (v in names(val)) {
    x[[v]] <- if (v %in% xnames && is.list(x[[v]]) && is.list(val[[v]]))
      appendList(x[[v]], val[[v]])
    else c(x[[v]], val[[v]])
  }
  x
}
 
# Simulating submit_form for GET requests
submit_geturl <- function (session, form)
{
  query <- rvest:::submit_request(form)
  query$method <- NULL
  query$encode <- NULL
  query$url <- NULL
  names(query) <- "query"
 
  relativeurl <- XML::getRelativeURL(form$url, session$url)
  basepath <- parse_url(relativeurl)
 
  fullpath <- appendList(basepath,query)
  fullpath <- build_url(fullpath)
  fullpath
}

# Version 2 of our submit_form function
submit_form2 <- function(session, form){
  library(XML)
  url <- XML::getRelativeURL(form$url, session$url)
  url <- paste(url,'?',sep='')
  values <- as.vector(rvest:::submit_request(form)$values)
  att <- names(values)
  if (tail(att, n=1) == "NULL"){
    values <- values[1:length(values)-1]
    att <- att[1:length(att)-1]
  }
  q <- paste(att,values,sep='=')
  q <- paste(q, collapse = '&')
  q <- gsub(" ", "+", q)
  url <- paste(url, q, sep = '')
  html_session(url)
}

# Submit form and get new url
session1 <- submit_form2(session, form)

# Get reviews of first company using follow_link()
session2 <- follow_link(session1, css = "#more_0 li:nth-child(3) a")
reviews <- session2 %>% html_nodes(".description") %>% html_text()
reviews
```

```
## [1] "Fair pay, decent people"                   
## [2] "Fast paced and aggressive"                 
## [3] "Great officers to work with and other AA's"
## [4] "good to learn sth"                         
## [5] "excellent company"
```

```r
# Get average salary for each job listing based on title and location
salary_links <- html_nodes(session1, css = "#resultsCol li:nth-child(2) a") %>% html_attr("href")
salary_links <- paste(session$url, salary_links, sep='')
salaries <- lapply(salary_links, . %>% html() %>% html_nodes("#salary_display_table .salary") %>% html_text())
salary <- unlist(salaries)

# Store web url
data_sci_indeed <- session1

# Get job titles
job_title <- data_sci_indeed %>% 
  html_nodes("[itemprop=title]") %>%
  html_text()

# Get companies
company <- data_sci_indeed %>%
  html_nodes("[itemprop=hiringOrganization]") %>%
  html_text()

# Get locations
location <- data_sci_indeed %>%
  html_nodes("[itemprop=addressLocality]") %>%
  html_text()

# Get descriptions
description <- data_sci_indeed %>%
  html_nodes("[itemprop=description]") %>%
  html_text()

# Get the links
link <- data_sci_indeed %>%
  html_nodes("[itemprop=title]") %>%
  html_attr("href")
link <- paste('https://www.indeed.com', link, sep='')

indeed_jobs <- data.frame(job_title,company,location,description,salary,link)
library(pander)
pander(indeed_jobs,split.cells = 10, split.tables=Inf)
```


----------------------------------------------------------------------------------------------------------------------------------
  job_title        company       location          description           salary                        link                       
------------- ----------------- ---------- ---------------------------- -------- -------------------------------------------------
    Data          JPMorgan      New York,           Experience          $109,000 https://www.indeed.com/rc/clk?jk=79b3ac9ca7865c94
  Scientist         Chase           NY               managing                                                                     
      -                                                and                                                                        
 Intelligent                                         growing                                                                      
  Solutions                                             a                                                                         
                                                       data                                                                       
                                                     science                                                                      
                                                    team. Data                                                                    
                                                    Scientist                                                                     
                                                        -                                                                         
                                                   Intelligent                                                                    
                                                    Solutions.                                                                    
                                                     Analyze                                                                      
                                                  communications                                                                  
                                                     data and                                                                     
                                                     Utilize                                                                      
                                                   statistical                                                                    
                                                    natural...                                                                    

  Research          Xerox        Webster,            Machine            $60,000  https://www.indeed.com/rc/clk?jk=681454be08e38c48
 Scientist:                      NY 14580            Learning                                                                     
   Machine                                           and Data                                                                     
  Learning                                          Science*.                                                                     
  and Data                                          Work with                                                                     
   Science                                          a diverse                                                                     
                                                      set of                                                                      
                                                       data                                                                       
                                                     sources,                                                                     
                                                     such as                                                                      
                                                       time                                                                       
                                                      series                                                                      
                                                      data,                                                                       
                                                     spatial,                                                                     
                                                      graph                                                                       
                                                      data,                                                                       
                                                 semi-structured                                                                  
                                                       and                                                                        
                                                 unstructured...                                                                  

    Data           Enstoa       New York,            2+ years           $210,000 https://www.indeed.com/rc/clk?jk=b3afc0c711916836
  Scientist                         NY             professional                                                                   
      &                                             experience                                                                    
Visualization                                       analyzing                                                                     
  Engineer                                           complex                                                                      
                                                    data sets,                                                                    
                                                    modeling,                                                                     
                                                     machine                                                                      
                                                    learning,                                                                     
                                                      and/or                                                                      
                                                   large-scale                                                                    
                                                       data                                                                       
                                                    mining....                                                                    

    Data             The        New York,           As a Data           $109,000 https://www.indeed.com/rc/clk?jk=8bfb40468f28c10c
  Scientist        Nielsen          NY              Scientist                                                                     
                   Company                            in the                                                                      
                                                       Data                                                                       
                                                   Integration                                                                    
                                                    group, you                                                                    
                                                     will be                                                                      
                                                     involved                                                                     
                                                      in the                                                                      
                                                    process of                                                                    
                                                   integrating                                                                    
                                                     data to                                                                      
                                                      enable                                                                      
                                                     analyses                                                                     
                                                        of                                                                        
                                                     patterns                                                                     
                                                       and                                                                        
                                                 relationships...                                                                 

  Managing        Navigant      New York,            Gathers            $119,000 https://www.indeed.com/rc/clk?jk=46f5e894d9366775
 Consultant,     Consulting     NY 10017            analyzes,                                                                     
  Delivery           Inc         (Midtown              and                                                                        
 Innovation                       area)              presents                                                                     
  Analytics                                           data,                                                                       
   (#4894)                                          including                                                                     
                                                     document                                                                     
                                                    review and                                                                    
                                                     quality                                                                      
                                                    control of                                                                    
                                                    data entry                                                                    
                                                   activities.                                                                    
                                                    Providers,                                                                    
                                                    payers and                                                                    
                                                       life                                                                       
                                                     sciences                                                                     
                                                  companies....                                                                   

    Data           Custora      New York,            2+ years           $109,000 https://www.indeed.com/rc/clk?jk=e527e2f9498dbf6b
  Scientist                         NY                  of                                                                        
                                                   professional                                                                   
                                                    experience                                                                    
                                                     in data                                                                      
                                                     science                                                                      
                                                     and/or a                                                                     
                                                     Ph.D in                                                                      
                                                     computer                                                                     
                                                     science,                                                                     
                                                   mathematics,                                                                   
                                                    economics,                                                                    
                                                    sciences,                                                                     
                                                     or other                                                                     
                                                   quantitative                                                                   
                                                    field....                                                                     

    Data      SterlingBackcheck New York,            Hands on           $44,000  https://www.indeed.com/rc/clk?jk=025244e71e61bff5
   Science                          NY              experience                                                                    
   Intern                                            working                                                                      
                                                    with very                                                                     
                                                    large data                                                                    
                                                      sets,                                                                       
                                                    including                                                                     
                                                   statistical                                                                    
                                                    analyses,                                                                     
                                                       data                                                                       
                                                  visualization,                                                                  
                                                       data                                                                       
                                                     mining,                                                                      
                                                     and data                                                                     
                                           cleansing/transformation....                                                           

    Data          Rent the      New York,           Experience          $122,000 https://www.indeed.com/rc/clk?jk=1ea61aae7d1de5d0
  Engineer         Runway           NY                  in                                                                        
                                                     merging                                                                      
                                                    disparate                                                                     
                                                       data                                                                       
                                                      forms.                                                                      
                                                    Extensive                                                                     
                                                     practice                                                                     
                                                    using SQL                                                                     
                                                       for                                                                        
                                                    analytics                                                                     
                                                     research                                                                     
                                                     and data                                                                     
                                                  cleansing....                                                                   

   Summer            IBM         Yorktown              The              $36,000  https://www.indeed.com/rc/clk?jk=d20c6a677eda7671
  Intern -                       Heights,            Network                                                                      
   Network                          NY               Science                                                                      
   Science                                           and Big                                                                      
   and Big                                             Data                                                                       
    Data                                            Analytics                                                                     
  Analytics                                         department                                                                    
                                                    at the IBM                                                                    
                                                    T. Our lab                                                                    
                                                    has access                                                                    
                                                     to large                                                                     
                                                    computing                                                                     
                                                    resources                                                                     
                                                       and                                                                        
                                                    data....                                                                      

    Data         Refinery29     New York,           Refinery29          $44,000  https://www.indeed.com/rc/clk?jk=d41c6799f7cccace
   Science                          NY                  is                                                                        
   Intern                                            looking                                                                      
                                                    for a Data                                                                    
                                                     Science                                                                      
                                                    Intern to                                                                     
                                                     join our                                                                     
                                                     growing                                                                      
                                                     team in                                                                      
                                                    the Summer                                                                    
                                                     2015 in                                                                      
                                                     our New                                                                      
                                                    York City                                                                     
                                                    office....                                                                    
----------------------------------------------------------------------------------------------------------------------------------

## More examples with LinkedIn


```r
# Attempt to crawl LinkedIn, requires useragent to access Linkedin Sites
uastring <- "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
session <- html_session("https://www.linkedin.com/job/", user_agent(uastring))
form <- html_form(session)[[1]]
form <- set_values(form, keywords = "Data Science", location="New York")
 
new_url <- submit_geturl(session,form)
new_session <- html_session(new_url, user_agent(uastring))
jobtitle <- new_session %>% html_nodes(".job [itemprop=title]") %>% html_text
company <- new_session %>% html_nodes(".job [itemprop=name]") %>% html_text
location <- new_session %>% html_nodes(".job [itemprop=addressLocality]") %>% html_text
description <- new_session %>% html_nodes(".job [itemprop=description]") %>% html_text
url <- new_session %>% html_nodes(".job [itemprop=title]") %>% html_attr("href")
df <- data.frame(jobtitle, company, location, url)
pander(df,split.cells = 10, split.tables=Inf)
```


----------------------------------------------------------------------------------------------------------------------
  jobtitle          company          location                                    url                                  
------------ ---------------------- ---------- -----------------------------------------------------------------------
    Data             Kaplan          New York  https://www.linkedin.com/jobs2/view/51429397?trk=jserp_job_details_text
  Science                           City, NY,                                                                         
   Lead:                                US                                                                            
   Metis                                                                                                              

    Data             Kaplan         New York,  https://www.linkedin.com/jobs2/view/38695388?trk=jserp_job_details_text
  Science          Test Prep            NY                                                                            
   Lead:                                                                                                              
   Metis                                                                                                              

 Think Big         Think Big,       US-NY-New  https://www.linkedin.com/jobs2/view/32056808?trk=jserp_job_details_text
   Senior          A Teradata          York                                                                           
    Data            Company                                                                                           
 Scientist                                                                                                            

 Think Big         Think Big,       US-NY-New  https://www.linkedin.com/jobs2/view/32057641?trk=jserp_job_details_text
 Principal         A Teradata          York                                                                           
    Data            Company                                                                                           
 Scientist                                                                                                            

    Data              MapR           Greater   https://www.linkedin.com/jobs2/view/35995187?trk=jserp_job_details_text
 Scientist        Technologies       New York                                                                         
     -                              City Area                                                                         
Professional                                                                                                          
  Services                                                                                                            
 Consultant                                                                                                           
 (East ...                                                                                                            

 Think Big          Teradata         New York  https://www.linkedin.com/jobs2/view/51068145?trk=jserp_job_details_text
   Senior                           City, NY,                                                                         
    Data                                US                                                                            
 Scientist                                                                                                            

 Think Big          Teradata         New York  https://www.linkedin.com/jobs2/view/51068162?trk=jserp_job_details_text
 Principal                          City, NY,                                                                         
    Data                                US                                                                            
 Scientist                                                                                                            

    Sr.            HookLogic,        New York  https://www.linkedin.com/jobs2/view/49975389?trk=jserp_job_details_text
  Software            Inc.          City, NY,                                                                         
 Engineer -                             US                                                                            
    Data                                                                                                              
 Science -                                                                                                            
 HookLogic                                                                                                            

 Think Big         Think Big,       US-NY-New  https://www.linkedin.com/jobs2/view/32057645?trk=jserp_job_details_text
    Data           A Teradata          York                                                                           
 Scientist          Company                                                                                           

  Director          DataKind         New York  https://www.linkedin.com/jobs2/view/35605329?trk=jserp_job_details_text
  of Data                           City, NY,                                                                         
  Science                               US                                                                            
  Programs                                                                                                            

 Lead Data          JPMorgan        US-NY-New  https://www.linkedin.com/jobs2/view/40828814?trk=jserp_job_details_text
 Scientist          Chase &            York                                                                           
   - VP -             Co.                                                                                             
Intelligent                                                                                                           
 Solutions                                                                                                            

   Senior          GQR Global        Greater   https://www.linkedin.com/jobs2/view/38602287?trk=jserp_job_details_text
    Data            Markets          New York                                                                         
 Scientist                          City Area                                                                         
   for US                                                                                                             
Quantitative                                                                                                          
 Fund, NYC                                                                                                            

   Google    PricewaterhouseCoopers  New York  https://www.linkedin.com/jobs2/view/53729956?trk=jserp_job_details_text
   Cloud                            City, NY,                                                                         
 Solutions                              US                                                                            
 Practice,                                                                                                            
   Google                                                                                                             
    Data                                                                                                              
  Solution                                                                                                            
    ...                                                                                                               

   Senior           Dun and           Short    https://www.linkedin.com/jobs2/view/53796892?trk=jserp_job_details_text
    Data           Bradstreet       Hills, NJ,                                                                        
 Scientist                              US                                                                            

   Senior           Mezzobit         New York  https://www.linkedin.com/jobs2/view/38019145?trk=jserp_job_details_text
    data                            City, NY,                                                                         
 scientist                              US                                                                            

    New             JPMorgan         New York  https://www.linkedin.com/jobs2/view/53410566?trk=jserp_job_details_text
  Product            Chase          City, NY,                                                                         
Development                             US                                                                            
   – Data                                                                                                             
  Science                                                                                                             
    and                                                                                                               
 Analytics                                                                                                            
   – ...                                                                                                              

 Think Big          Teradata         New York  https://www.linkedin.com/jobs2/view/51066835?trk=jserp_job_details_text
    Data                            City, NY,                                                                         
 Scientist                              US                                                                            

    Data            JPMorgan        US-NY-New  https://www.linkedin.com/jobs2/view/40855034?trk=jserp_job_details_text
 Scientist          Chase &            York                                                                           
     -                Co.                                                                                             
Intelligent                                                                                                           
 Solutions                                                                                                            

 Technical          Datameer         New York  https://www.linkedin.com/jobs2/view/41600114?trk=jserp_job_details_text
  Trainer                                                                                                             
    EMEA                                                                                                              

 Elementary         Success          Greater   https://www.linkedin.com/jobs2/view/38634099?trk=jserp_job_details_text
   School           Academy          New York                                                                         
  Science           Charter         City Area                                                                         
  Teacher           Schools                                                                                           

   Middle           Success          Greater   https://www.linkedin.com/jobs2/view/38633208?trk=jserp_job_details_text
   School           Academy          New York                                                                         
  Science           Charter         City Area                                                                         
  Teacher           Schools                                                                                           

  Sr. Data          Magnetic        New York,  https://www.linkedin.com/jobs2/view/33977941?trk=jserp_job_details_text
 Scientist                              NY                                                                            
   – Big                                                                                                              
   Data,                                                                                                              
   Online                                                                                                             
Advertising,                                                                                                          
   Search                                                                                                             

    Sr.            HookLogic,       New York,  https://www.linkedin.com/jobs2/view/33984252?trk=jserp_job_details_text
  Software            Inc.              NY                                                                            
 Engineer -                                                                                                           
    Data                                                                                                              
  Science                                                                                                             

  Sr. Big             ADP           New York,  https://www.linkedin.com/jobs2/view/18708583?trk=jserp_job_details_text
    Data                                NY                                                                            
  Engineer                                                                                                            
 FlexGraph                                                                                                            

    Data          CyberCoders        New York  https://www.linkedin.com/jobs2/view/40896475?trk=jserp_job_details_text
  Science                            City, NY                                                                         
    Lead                                                                                                              
 Instructor                                                                                                           
   - Data                                                                                                             
  Science,                                                                                                            
  Teaching                                                                                                            
----------------------------------------------------------------------------------------------------------------------

## Attemping to scrape Columbia LionShare


```r
# Attempt to crawl Columbia Lionshare for jobs
session <- html_session("http://www.careereducation.columbia.edu/lionshare")
form <- html_form(session)[[1]]
form <- set_values(form, username = "uni")
#Below code commented out in Markdown

#pw <- .rs.askForPassword("Password?")
#form <- set_values(form, password = pw)
#rm(pw)
#session2 <- submit_form(session, form)
#session2 <- follow_link(session2, "Job")
#form2 <- html_form(session2)[[1]]
#form2 <- set_values(form2, PositionTypes = 7, Keyword = "Data")
#session3 <- submit_form(session2, form2)

# unable to load javascript content in a page, need to use Selenium? according to stackoverflow
```
