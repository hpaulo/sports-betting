# sports-betting

## Historical Game Data

The data used in this project are regular season men's NCAA matchup histories for 2013, 2014, and 2015. It was retrieved from [Spreadsheet Sports](https://www.spreadsheet-sports.com/blog/ncaa-basketball/) in April 2015.

First, it was converted into CSV files, then only select columns were kept:

```
$ cat 2013GameResultsData.csv | cut -d , -f 1-5,8 > 2013-ncaa-mens.csv
$ head -1 2013-ncaa-mens.csv
Date,Team,Opponent,Team Score,Opponent Score,Team Result
```


