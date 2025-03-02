#This script will create a long list of rental agencies in Rome. 
#We can use this list to advertise our product. 

###############
## CONFIGURE ##
###############

library(rvest)
library(dplyr)
library(data.table)

#mark time start script for saving datasets
time = gsub("(-|:| )", "\\.", Sys.time())

#set wd
if(Sys.info()[4] == "JOSH_LAPTOP"){
  workingDir = "C:/Users/rockc_000/Documents/GitHub/romeHousePrices/"
} else if(Sys.info()[4] == "joshua-Ubuntu-Linux"){
  workingDir = "~/Documents/Github/romeHousePrices"
} else if(Sys.info()[4] =="Michaels-MacBook-Pro-2.local"||
          Sys.info()[4] == "Michaels-MBP-2.lan"){
  workingDir = "~/Dropbox/romeHousePrices/"        #for michael's mac yo
} else {
  stop("No directory for current user!")
}

setwd(workingDir)
files = dir(path = paste0(workingDir, "/R"), full.names = TRUE)
sapply(files, source)

###############################################################


## SCRAPE LIST FROM IMMOBLIARE.IT 
url = "http://www.immobiliare.it/Roma/agenzie_immobiliari_provincia-Roma.html?pag=1"
numPages <- getAgenzieNumImmobiliare(url)

agencies <- getAgenzieDetailsImmobiliare(numPages)

tab <- agencies %>% 
      group_by(cap) %>% 
      summarize(length(unique(names)))
tab <- as.data.frame(tab)
sum(tab[,2])
#you can see that some caps aren't in rome, and some are NAs. One way
#to narrow the list would be to filter for roman caps. i have a list
#in the old codes for scraping data by cap.