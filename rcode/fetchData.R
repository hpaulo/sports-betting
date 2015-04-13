##'
##' Fetch datasets
##' ==============
##' 
##' Import csv datafiles
source('options.R')

ncaaHist2013 <- read.csv("data/2013-ncaa-mens.csv") %>% tbl_df()
ncaaHist2014 <- read.csv("data/2014-ncaa-mens.csv") %>% tbl_df()
ncaaHist2015 <- read.csv("data/2015-ncaa-mens.csv") %>% tbl_df()

##' Check datasets
ncaaHist2013
ncaaHist2014
ncaaHist2015

##' Check names
names(ncaaHist2013)
names(ncaaHist2014)
names(ncaaHist2015)

##'
##' Clean datasets
##' ==============
##' 
df <- rbind(ncaaHist2013, ncaaHist2014, ncaaHist2015)

##' Output the cleaned data into a single RData file.
save(df, file = 'data/cleanedData.RData')