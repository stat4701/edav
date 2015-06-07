---
Layout: blogpost

Title:  "Exploratory Data Analysis & Visualization course: Indeedoor 
Project blog"

Date:   2015-06-07
Categories: R, Shiny, API, Machine Learning
---
The Indeedoor app blog post================

by Team Tufte: Janet Prumachuk, Shruti Pandey, Christine Lee, Jade Bailey-Assam, Lucy Drotning  


---------------------

### A. Indeedoor at a glance

#### What we hope to accomplish for this project
The project objective for our Exploratory Data Analysis and Visualization class at Columbia University's Data Science Institute is to use data to enable insights with a strong visual component, relying on a myriad of data acquisition and graphics programming tools learned over the course of the semester. We wish to share our project experience in this blogpost. 
Our team name Tufte comes from inspiration by Edward Tufte, a statistician and pioneer in the field of data visualization, whose work and teachings on modern data graphics were introduced to us by our instructor Mike Malecki. 

#### Idea conceptualization and objective

Our team first started with an idea to work with jobs and employer data to build something that might be useful for job seekers or anyone hoping to learn more about job opportunities and hiring companies in a certain field. Since we are in a data science class, as a starter we decided to focus this app prototype on job openings and employers in the data science/analytics field. 

It appears to us that Indeed.com is one of the top job search engines that aggregates a pretty comprehensive list of job postings from a diverse range of sources, including many employer job listing web sites and not limited to job boards only. We hope to gather and present a list of job postings on our app that are as comprehensive as possible. On the other hand, we feel Glassdoors is one of the larger databases offering employer ratings by employees that provides job seekers valuable insights on a certain company's culture and internal operations. 
With the above in mind, we wished to build an app that allows us to gather and present both relevant job opportunities + hiring employers/industries, enabled by interactive graphics that deliver information and insights to the user in a dynamic and easier-to-comprehend way. We hope users of the app would be able to save time in their job search research process while also gain more insights on job openings and employers from the data analysis features of Indeedoor. 

#### Data carpentry tools for this project 
We relied on a combination of tools for different functions in creating this app:   
- API data querying with Python;

- MySQL database for data sharing, storage and retrieval;
- Data manipulation and many things graphics-related in R;
- App building and integration with Shiny (in R).   

![alt text](http://i.imgur.com/O27gUO9.png)


****

### B. On acquiring and preparing the data

Data preparation often requires a meaningful amount of time and effort in any data project. We would like to touch upon some highlights of our data preparation process. 

#### Acquiring data via APIs
Initially, we considered assessing LinkedIn's APIs for job postings and employer data but due to LinkedIn's recent announcement of increased restriction of its API use for third party developers and in consideration of how we would like to access our data from platforms with a comprehensive amount of data on job openings and employer reviews, we decided to source our data from [Indeed] and [Glassdoor]'s APIs instead. 
We find that using an API (in this case Indeed.com's) is an efficient way to acquire data on search parameters specified in the API query for each returned job. For instance we requested for parameters such as job title, company name, date the job was posted, job location by city and state, for jobs with the job title containing query terms "data" and "analytics". The API query furthermore provides data such as the latitude and longitude of the job location/corresponding employer that may have not been possible to easily gather via other methods such as web scraping.

Nevertheless, we still ran into certain limitations with the API query, such as inability to search for longer-dated jobs (beyond 60 days from the date of the query), or to see the full job description under the parameter "snippet" which shows a brief paragraph from the role description. 
#### Our data sources - Indeed and Glassdoor 
The following is a snapshot of sample job posting data acquired with Indeed's API: 

    city	state	latitude	longitude	date							job title		company
    New York	NY	40.71154	-74.00549	Mon, 27 Apr 2015 15:55:37 GMT	Data Scientist	The College Board
    New York	NY	40.71154	-74.00549	Mon, 27 Apr 2015 20:42:50 GMT	Data Scientist	Roku
    New York	NY	40.71154	-74.00549	Thu, 23 Apr 2015 13:28:08 GMT	Data Scientist	Capital One
    New York	NY	40.71154	-74.00549	Sat, 25 Apr 2015 12:14:00 GMT	Data Scientist	Knewton
    New York	NY	40.71154	-74.00549	Thu, 23 Apr 2015 22:13:05 GMT	Data Scientist, Lead	Smart Host
    New York	NY	40.71154	-74.00549	Tue, 14 Apr 2015 21:10:37 GMT	Merchant Data Scientist	American Express
    New York	NY	40.71154	-74.00549	Thu, 16 Apr 2015 18:31:30 GMT	Data Scientist/Mathematical Modeler, Display Advertising	Netmining
    New York	NY	40.71154	-74.00549	Fri, 24 Apr 2015 15:31:18 GMT	Education Data Scientist	Public Consulting Group
    New York	NY	40.71154	-74.00549	Tue, 21 Apr 2015 06:26:12 GMT	Senior Data Scientist	iHeartMedia, Inc.
    New York	NY	40.71154	-74.00549	Thu, 23 Apr 2015 14:58:53 GMT		The Hagan-Ricci Group
    New York	NY	40.71154	-74.00549	Mon, 20 Apr 2015 08:19:18 GMT	Data Scientist	KPMG
    New York	NY	40.71154	-74.00549	Sun, 12 Apr 2015 22:09:08 GMT	Data Scientist - Machine Learning (New York)	Twitter
    New York	NY	40.71154	-74.00549	Mon, 27 Apr 2015 05:50:10 GMT	Data Scientist	Elevate Recruiting Group
    New York	NY	40.71154	-74.00549	Sat, 18 Apr 2015 05:46:51 GMT	Data Scientist	JW Player
    New York	NY	40.71154	-74.00549	Thu, 23 Apr 2015 22:05:00 GMT		Magnetic
    New York	NY	40.71154	-74.00549	Mon, 27 Apr 2015 10:33:22 GMT	Data Scientist	Willard Powell
    New York	NY	40.71154	-74.00549	Wed, 22 Apr 2015 08:13:00 GMT	Advanced Analytics - Products Industry Team - Consultant	Accenture
    New York	NY	40.71154	-74.00549	Mon, 27 Apr 2015 19:44:35 GMT	Data Scientist	CBS Corporate
    New York	NY	40.71154	-74.00549	Tue, 21 Apr 2015 02:15:49 GMT	Data Scientist	Analytic Partners

    snippet
    Experience with descriptive statistics and data visualization in R and Tableau. Create insights from existing data, and drive the collection of new data through...
    Experience creating data visualizations and communicating data insights. 4-6 years of experience in user data analytics....
    Using Hadoop and related tools (Pig, Hive, Impala) to manage the analysis of billions of customer transaction records -Writing software to clean and investigate...
    We're looking for engineers or applied scientists with experience implementing data mining and machine learning systems to help build an innovative online...
    Expertise in data mining, machine learning, natural language processing, and information retrieval. Build and validate a data model for comparing residential...
    Design and implementation of advanced data matching and arbitration algorithms, including (but limited to) machine learning, text mining, etc....
    Data Scientist with background in mathematical modeling and/or machine learning needed in the Display Ad Technology space....
    The Education Data Scientist is responsible for guiding and monitoring the technical implementation of new data collections, visualizations and reports in...
    D degree in a quantitative discipline (e.g., Computer Science, Math, Statistics, Physics, Electrical Engineering) or strong experience in a relevant role....
    Reference RQ74-GIF, Data Scientist on subject line. Data scientists/developers with Machine Learning and Data Mining expertise for New York and Chicago to mine...
    Machine learning, data visualization, statistical modeling, data mining, or information retrieval. We are currently seeking a Data Scientist, to join our Data &amp;...
    As a Twitter Data Scientist specializing in Machine Learning, you will use machine learning and data mining techniques to better understand how users engage...    
    Design, develop, and optimize our data and analytics system. Our family of products also include video management, ads and analytics data;...
    Expertise in machine learning, data mining and predictive analytics. As a Senior Data Scientist, you will help us scrub, organize, and interpret our data to...
    Use techniques in statistics and machine learning to analyze our data. Experience working with large data sets....
    Risk analytics, Operations analytics, Big Data Analytics etc). Analytics enables our clients to achieve high performance through insights from data - insights...
    This Data Scientist role requires experience in predictive and exploratory analytics, querying data systems, performing research and data manipulation....
    Lead/assist in methodology research and solution deployment across marketing analytics, scientific attribution, predictive modeling, segmentation, simulation,...

Another snapshot of a data set on employers acquired with Glassdoor's API:
    employers.id	employers.name	employers.website	employers.industry	employers.numberOfRatings	employers.overallRating
    354		IBM			www.ibm.com						Consulting				13878					3
    145		J.P. Morgan	www.jpmorganchase.com		Investment Banking & Asset Management		5260		3.4
    8843	Citi	www.citigroup.com	Investment Banking & Asset Management			3251	3.3
    1079	Macy's	www.macysjobs.com	Department, Clothing, & Shoe Stores	6164	3
    2282	Morgan Stanley	www.morganstanley.com	Investment Banking & Asset Management	2092	3.6
    8450	PwC		www.pwc.com		Accounting	6085	3.7
    2800	Goldman Sachs	www.goldmansachs.com	Investment Banking & Asset Management	2079	3.8
    3096	Bloomberg L.P.	www.bloomberg.com	Computer Hardware & Software	1387	3.5
    2763	Deloitte	www.deloitte.com		Accounting		7798	3.6
    2784	EY		www.ey.com	Consulting	5539	3.7
    35		American Express	www.americanexpress.com	Financial Transaction Processing	2311	3.6
    8874	Bank of America	www.bankofamerica.com	Banks & Credit Unions	8238	3.3
    2748	Columbia University	www.columbia.edu	Colleges & Universities	679	3.9
    3141	Credit Suisse	www.credit-suisse.com	Investment Banking & Asset Management	1553	3.5
    100303	Thomson Reuters	www.thomsonreuters.com	Enterprise Software & Network Solutions	2970	3.4
    
#### Data preparation challenges
One of the challenges in preparing our data on job postings from Indeed relate to filtering out a number of job results that appear irrelevant to our search query of "data scientist" job opportunities. 
1) We attempted to filter out a few frequently occurring job titles that should not show up in our API query results by identifying job results containing certain keywords such as "developer" in our job results data frame. However, some irrelevant positions that have term “data scientist” in the job snippet description still show up in our search results; Meanwhile, we also should not simply eliminate seemingly “irrelevant” job titles as some of these jobs are actually data science-oriented positions with a different job title. In fact, there is quite a long list of data science-relevant job titles shown by this [article][Data science Central] from Data Science Central. 
2) We eventually improved job post relevancy by filtering on "data" and "analytics" in the job title, helping mitigate the above search irrelevance issue. 

3) After obtaining multiple data sets from Indeed and Glassdoor, we realized that CSV files were slowing down data sharing and our app. We set up a MySQL server and loaded the data in a relational database which makes searches and other operations faster by decoupling them from our analysis work in R.  



****

### C. Introducing the app
We highlight some of Indeedoor's key features below:

###App part I: Top industries by employee ratings
When you are searching for a job, choosing the right industry can be just as important as choosing the right company.   We use the small multiples visualization pattern to show the top industries by each of Glassdoor's ratings categories.  We also provide an option to limit the results to companies that have an open data science job posting no more than 30 days old. This feature could be enhanced to limit the results based on a user-entered search term.
![alt text](http://i.imgur.com/KRBxWJX.png)

****

###App part II:Jobs + employers map by location
Have you ever wanted to see where job openings and employers of interest are located (either near you or across the country), or what kinds of jobs are available near where you are based? Have you ever wondered how job opportunities for certain fields are clustered around some cities? 
In creating this dynamic jobs map (by clicking the second tab on the left menu), we wish to enable a visual mapping of the locations of data science-relevant job postings, a quick summary of the job opening plus the corresponding employer rating from Glassdoor, gathered and presented in one view in the app.  
This map was enabled by a package called [leaflet][leaflet], a library in R for creating dynamic maps that support panning and zooming, with various annotations like markers, polygons, and popups.

#### Click for pop-up on job info/link + employer rating
Job postings are represented by circular markers, which upon clicking will show a pop-up that lists the job's city, company, job title, industry per Glassdoor, as well as the number of employee reviews and the firm's overall rating from Glassdoor. The upper left hand button on the map allows for panning and zooming, which can offer a quick glance at where the job results might be clustered or whether there are any jobs appearing near a certain location of interest. What may be quite helpful to the user is the ability to click on and get directed to the job posting's url directly from the pop-up. 

![alt text](http://i.imgur.com/IZdJDO0.png)
![alt text](http://i.imgur.com/jWWau9W.png)
#### Sortable list of job postings
Below the above dynamic map is a tabular list of the map's search results on data science jobs from Indeed.com, along with highlights for the corresponding firm's Glassdoor reviews. This is an interactive list that can be sorted by company name, job title, posting date, Glassdoor overall rating. 
![alt text](http://i.imgur.com/8mfSxNy.png)
****

###App part III: Sought-after skills based on word frequencies in job postings

#### Skills by Geography
We highlight that location makes a big difference in the skills sought after for similar job postings. Depending on the city selected and the predominant industries in that city there are variation in the job postings. Eg. For a Data Scientist posting in Boston we often see skill relating to the health care industry highlighted but for New York there is emphasis in banking and finance. This is presented visually using a word cloud where the terms are extracted from the requirements for Data Scientist jobs by city.  
![alt text](http://i.imgur.com/XjqPbB7.png)

****

###App part IV: What makes people recommend companies? 


#### Cluster Analysis
We conduct cluster analysis based on two criteria: 
1.	Overall Rating 
2. 	Recommendation to Friends

We present an analysis of what influences these two factors as a function of the ratings provided on Glassdoor. For instance we create a linear regression model by industry of Overall rating as a function of factors like Compensations and benefits, CEO Approval, Work life balance, etc. and identify the dominant factors that influence the overall rating. We observe that the dominant factors vary from industry to industry and we create (a configurable set of) clusters based on similarities of the regression model. The importance of each parameter is presented as a scatter plot using (a configurable) pair of factors at a time. Below this scatter plot we present a table listing out the clusters and the top two dominant factor for each industry. A similar analysis is also presented for the "Recommend to Friends" rating and now we move Overall rating to be an input parameter.

![alt text](http://i.imgur.com/CgWL2k1.png)

****

### App part V: Resume help, aka SEO your resumeThe tab titled "Resume help" is intended to help you optimize your resume to ensure you have the keywords that appear in data science job listings. This was created because data science is a burgeoning field; as such, people are entering it from different fields and with different experience. For example, a marketer, programmer and IT project manager might all be studying data science. Their resumes would all be slightly different due to their varied experiences. Utilizing our Indeedoor tool will help unify keywords (and phrases) listed on data science job listings so your resume has more impact on the recruiter reading it. With a difficult job market, it's important to make your resume "speak the same language" as the job listings. Also, if a company uses machine learning for initial screening and your resume is optimized for the job, you'll likely have a better chance of getting past the initial screen and thus getting your foot in the door.Example of skills keywords from a job listing:![alt text](http://i.imgur.com/QBSelf6.png)The results shown are based on a random sampling of data science job postings in the New York Ciry area on a given day in April 2015.The keywords have been grouped into 5 main categories: skills, coursework, expertise, at work, and buzzwords.Skills are technical skills you have a proficiency in such as Python, SQL and Hadoop. Coursework is courses you've taken that are relevant to data science. Examples include statistics, mathematics, and machine learning. Expertise includes areas you have prior experience in such as modeling, building tools, and working with large-scale data sets. The at work category is intended to show keywords about a work environment. This can include keywords such as communication and collaborate as well as consulting and project. Words like communication and collaborate are important to show you have experience working in teams, something that is common in the workplace and not always so common in school. Buzzwords shows a list of "trendy" keywords such as analytics, digital and big data.


![alt text](http://i.imgur.com/xAa2mEq.png)

****

###FAQ for app users
##### What is Indeedoor and why should I use it?Indeedoor is an amalgamation of career-related data from Indeed and Glassdoor.  What began as a group project for W4701 (Exploratory Data Analysis and Visualization) in Columbia's Data Science Institute, is now evolving into a real product that adds value (we hope!) by presenting job data in a different, meaningful way.Our goal is to give a job seeker more information as part of their overall search process. We feel Indeed and Glassdoor individually contain valuable, but under-leveraged data. We saw an opportunity Indeed, knock on the glass door.
##### Why did you build Indeedoor in Shiny? Shiny lets you build interactive apps while allowing you to write complex algorithms in R in the backend. Anyone with a web browser can access our data. The power is in the interactivity - Shiny makes it easy.Shiny also also uses Twitter Bootstrap, which renders your application properly on mobile phones and in any browser.  
##### How to contact us for queries or suggestions? 
We welcome any thoughts, questions or suggestions. Reach us at info@indeedoor.com!
****
###Project links
[The Indeedoor project was featured in a news article][DSI] at Columbia's Data Science Institute.  
Our final app and documentation can be found at the following links:
- [indeedoor.com] [Indeedoor] 
- [Our project github] [github]
- [http://rpubs.com/jadeemily/textmining] [Jade]
Original data sources for the app:

- [Indeed.com][Indeed]
- [Glassdoor.com] [Glassdoor]


[Indeedoor]: www.indeedoor.com 
[github]: https://github.com/jcp1016/edav-team-project
[Indeed]: www.indeed.com
[Glassdoor]: www.glassdoor.com
[Jade]: http://rpubs.com/jadeemily/textmining
[Data science Central]: http://www.datasciencecentral.com/profiles/blogs/job-titles-for-data-scientists
[leaflet]: http://rstudio.github.io/leaflet/

[DSI]: http://datascience.columbia.edu/job-search-tool-by-data-scientists-for-data-scientists