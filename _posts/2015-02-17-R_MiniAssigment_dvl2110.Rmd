### NYPD Motor Vehicle Collisions API

**Author:** Dennis Lyubyvy

**Email:** dvl2110@columbia.edu

**Columbia University Spring 2015**

**Course:** W4701 Exploratory Data Analysis and Visualization

**Instructor:** Michael J. Malecki

Feb 12, 2015

**Code:** https://github.com/denniskorablev/NYPD-Motor-Vehicle-Collisions-API-for-R 

**Data source:** http://dev.socrata.com/foundry/#/data.cityofnewyork.us/h9gi-nx95

Additional comment: the problem definition was 'Get an api key and write a script that makes a query'
However in order to get API key you have to setup web-address from which you will do the query
So I have made the solution the other way: by constructing URL to get JSON file

``` {r}
if (!'jsonlite' %in% installed.packages()) install.packages('jsonlite')
library('jsonlite')


NYPD_MVC_data <- function(...) {

# ### all columns from JSON:

    # - unique_key
    # - date
    # - time    
    # - borough
    # - zip_code
    # - latitude
    # - longitude
    # - location.needs_recoding
    # - location.longitude
    # - location.latitude
    # - vehicle_type_code1
    # - vehicle_type_code2
    # - vehicle_type_code_3
    # - vehicle_type_code_4
    # - contributing_factor_vehicle_1
    # - contributing_factor_vehicle_2
    # - contributing_factor_vehicle_3    
    # - contributing_factor_vehicle_4
    # - on_street_name
    # - cross_street_name
    # - off_street_name
    # - number_of_persons_injured
    # - number_of_persons_killed
    # - number_of_pedestrians_injured
    # - number_of_pedestrians_killed
    # - number_of_motorist_injured    
    # - number_of_motorist_killed
    # - number_of_cyclist_injured
    # - number_of_cyclist_killed
    
# extract arguments
arguments <- list(...)

if (length(arguments)==0) {print('By default you will get 1000 last recods')}

#combine URL
base_url <- 'https://data.cityofnewyork.us/resource/h9gi-nx95.json?'
fullargs <- paste(names(arguments),arguments,sep='=')
arguments_as_string <- paste(fullargs,collapse = '&')
final_url <- paste(base_url,arguments_as_string,sep = '')

#load data from JSON
data <- fromJSON(final_url)

return (data)
}
```
### Examples
``` {r}
#get queens data for May 17, 2014
data_queens_2014_May_17 <- NYPD_MVC_data(borough='QUEENS', date='2014-05-17T00:00:00')

#get last 1000 records
#data_1000 <- NYPD_MVC_data()

```
