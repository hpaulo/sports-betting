# sports-betting

## Historical Game Data

The data used in this project are regular season men's NCAA matchup histories for 2013, 2014, and 2015. It was retrieved from [Spreadsheet Sports](https://www.spreadsheet-sports.com/blog/ncaa-basketball/) in April 2015.

First, it was converted into CSV files, then only select columns were kept:

```
$ cat 2013GameResultsData.csv | cut -d , -f 1-5,8 > 2013-ncaa-mens.csv
$ head -1 2013-ncaa-mens.csv
Date,Team,Opponent,Team Score,Opponent Score,Team Result
```

## Team and Matchup Statistics

We run some R manipulation on the trimmed data sets, which includes joining each season's results and calculating statistics for each team and for each team matchup. Included in the team statistics are total wins and losses, win probability, total points, and team and opponent point distributions. Included in the matchup statistics are wins, losses, win probability, and total matches with respect to one of the two teams.

```
$ head -1 TeamStats.csv
"","Team","Team.Score","Opponent.Score","Team.Score.Mean","Opponent.Score.Mean","Team.Score.Var","Opponent.Score.Var","Loss","Win","WinProb","Matches"
$ head -1 MatchupStats.csv
"","Team","Opponent","Loss","Win","WinProb","Matches"
```

## Using the Data

Parse the matchup data sets using the Matlab function parseMatchupStats:

```
[matchup stats] = parseMatchupStats('../data/generated/MatchupStats.csv');
```

Create a betting pool for and against a team for a given matchup by using generateBettingPool. It is a naive betting pool which bets almost entirely (proportionally) for the expected winner based on past matchups of the two teams, but there is a small percent of bets that are spread evenly over the two teams.

```
[teamPool opponentPool] = generateBettingPool(stats(2,:), 100)
```

Parse the team statistics which include, among other things, the point distributions for each team as well as their overall win probabilities based on wins over total matches played by the team.

```
[teams stats] = parseTeamStats('../data/generated/TeamStats.csv');
```

Calculate the expected values and variances of winning probabilities for a matchup of two teams using the parsed data from TeamStats.csv. In the deterministic case, the probabilities of each team winning is either 0 or 1. In the stochastic case, the expected value of the probability of a win is simply the probability of one team scoring more points than another team.

```
[expectation variance] = calcMatchupProbs(stats(2,:),stats(7,:));
```
