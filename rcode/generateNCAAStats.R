##'
##' Workspace Setup
##' ===============
##'

##' Clean up workspace, just in case.
rm(list=ls())

##' Load the libraries and other options.
source('options.R')

##' Load up the dataset
load('../data/generated/cleanedData.RData')
names(df)

##'
##' Team Statistics
##' ===============
##'

##' Point stats per team (for and against)
teamPoints <- aggregate(formula=cbind(Team.Score, Opponent.Score) ~ Team, data=df, FUN=sum)
teamPointsMean <- setNames(aggregate(formula=cbind(Team.Score, Opponent.Score) ~ Team, data=df, FUN=mean),
                           c("Team","Team.Score.Mean","Opponent.Score.Mean"))
teamPointsVar <- setNames(aggregate(formula=cbind(Team.Score, Opponent.Score) ~ Team, data=df, FUN=var),
                          c("Team","Team.Score.Var","Opponent.Score.Var"))
##' Merge mean and variance into point stats
teamPoints <- merge(teamPoints, teamPointsMean, by="Team")
teamPoints <- merge(teamPoints, teamPointsVar, by="Team")
teamPoints[is.na(teamPoints)] <- 0 #get rid of NAs

##' Win and loss stats
teamResults <- tally(group_by(df, Team, Team.Result))
teamResults <- spread(data=teamResults, key=Team.Result, value=n) #'longify' the tally
teamResults[is.na(teamResults)] <- 0 #get rid of NAs
teamResults$WinProb <- teamResults$Win / (teamResults$Win + teamResults$Loss)
##' Count total matches for each team
teamResults$Matches <- teamResults$Win + teamResults$Loss

##' Merge all team stats and save
teamStats <- merge(teamPoints, teamResults, by="Team")
write.csv(teamStats, file = '../data/generated/TeamStats.csv')

##' Filter out teams with below average number of matches
avgMatches <- mean(teamStats$Matches)
teamStats <- teamStats[teamStats$Matches > avgMatches,]
##' Take a look at the best teams
head(teamStats[order(-teamStats$WinProb),],10)

##'
##' Matchup Statistics
##' ==================
##'

##' Count wins and losses for team matchups
matchupResults <- tally(group_by(df, Team, Opponent, Team.Result))
matchupResults <- spread(data=matchupResults, key=Team.Result, value=n) #'longify' the tally
matchupResults[is.na(matchupResults)] <- 0 #get rid of NAs
matchupResults$WinProb <- matchupResults$Win / (matchupResults$Win + matchupResults$Loss)
##' Count total matches per team matchup
matchupResults$Matches <- matchupResults$Win + matchupResults$Loss

##' Save matchup stats
write.csv(matchupResults, file = '../data/generated/MatchupStats.csv')