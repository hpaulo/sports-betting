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

We run some R manipulation on the trimmed data sets, which includes joining each season's results and calculating statistics for each team and for each team matchup. Included in the team statistics are total wins and losses, win ratio, total points, and team and opponent point distributions. Included in the matchup statistics are wins, losses, win ratio, and total matches with respect to one of the two teams.

```
$ head -1 TeamStats.csv
"","Team","Team.Score","Opponent.Score","Team.Score.Mean","Opponent.Score.Mean","Team.Score.Var","Opponent.Score.Var","Loss","Win","WinRatio"
$ head -1 MatchupStats.csv
"","Team","Opponent","Loss","Win","WinRatio","Matches"
```
