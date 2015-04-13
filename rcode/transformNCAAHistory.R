##' Clean up workspace, just in case.
rm(list=ls())

##' Load the libraries and other options.
source('options.R')

##' Load up the dataset
load('data/cleanedData.RData')
names(df)

points <- aggregate(formula=cbind(Team.Score, Opponent.Score) ~ Team, data=df, FUN=sum)
