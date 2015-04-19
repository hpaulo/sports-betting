function [teamPool, opponentPool] = generateBettingPool(matchupStats, poolSize)
% Summary:  Function for generating a betting pool based on matchup
%           statistics. Bettors are naive, and generally bet for the
%           expected winner proportionally based on past matchups,
%           but there is a small amount of wagers which are evenly spread 
%           to both teams.
% 
% @params
% matchupStats: statistics for one team (losses, wins, winProb, numMatches)
% poolSize:     total amount of money contributed by bettors
%
% @returns
% teamPool:     wager pool for team
% opponentPool: wager pool for opponent
    
    % Some amount of bets are placed evenly on both teams
    baseRatio = 0.15;
    % Probabilistically bet based on stats
    winnerRatio = 1 - baseRatio;
    winProb = matchupStats(3);
    teamPool = (winnerRatio*winProb + baseRatio/2.0) * poolSize;
    opponentPool = poolSize - teamPool;
    
    wagers = [teamPool opponentPool];
    
    if double(sum(wagers)) ~= double(poolSize)
        error('Wagers do not sum to specified pool size')
    end
    
    return;
end