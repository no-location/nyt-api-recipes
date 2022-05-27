# --- Computational Social Sciences FS 2022 --- 
# --- Claudine Brändle --- 
# --- claudine.braendle@uzh.ch ---

# --- NYT Recipe analysis --- 

# --- Dependencies & Packages --- 
# install.packages("jsonlite")
# install.packages("curl")
# install.packages("dplyr")    # alternative installation of the %>%
library(dplyr)
library(jsonlite)

# --- General Variables --- 
projectUrl <- '~/Documents/Code/NYT API Recipes/'
# writeLines("4tA8IzOEnGpJlyFBAFfMXr2p9NqN9zQT", con = paste0(projectUrl,"NYT_KEY.txt"))
NYT_KEY <- readLines(con = paste0(projectUrl,"NYT_KEY.txt"))

# --- Retrieve Recipes from NYT API ---


# Query Parameters


# build the base URL
baseurl <- paste0(
  "http://api.nytimes.com/svc/search/v2/articlesearch.json?",
  "&fq=type_of_material:Recipe",
  "&facet_filter=true", # restricts descriptives of the results to the search criteria
  "&api-key=",NYT_KEY,
  "&sort=oldest",
  sep="")

# first query to get total number of records found
initialQuery <- fromJSON(baseurl)
( maxPages <- ceiling((initialQuery$response$meta$hits[1] / 10)-1) )

# create an empty list fitting results
result_list <- vector("list",length=maxPages)

# cycle through the pages using offset
for(i in 0:maxPages){
  print(i)
  nytSearch <- 
    fromJSON(paste0(baseurl, "&page=", i), flatten = TRUE) %>% 
    data.frame(.,stringsAsFactors = FALSE) 
  result_list[[i+1]] <- nytSearch 
  Sys.sleep(6) #build in sleep to not upset the server / internet connection
}

# combine results
result <-
  rbind_pages(result_list)

# Tidy data management and data cleaning




# Clean/readable code (comment your code and make sure it is reproducible by us)




# Analyses of the collected data







# Reporting, i.e. handing in a PDF document that
# describes your project idea,
# steps of data-collection, data-tidying, difficulties, solutions 
# analyses / methods used, as well as 
# nicely comprehendable tables and figures and interpretation of your results