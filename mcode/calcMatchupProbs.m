function [expectation, variance] = calcMatchupProbs(teamStats, oppStats)
% Summary:  Function for calculating the expected value and variance of
%           the winning probabilities for a team matchup.
% 
% @params
% teamStats:      statistics for one team
% opponentStats:  statistics for opponent team
%
% @returns
% expectation:  expectation of win probs for each team (team ev, opp ev)
% variance:     variance of win probs for each team (team var, opp var)
    
    % Input statistics
    means = [teamStats(3) oppStats(3)];
    variances = [teamStats(5) oppStats(5)];
    
    % Expected value of win probability
    teamExpVal = 1 - normcdf(0, -diff(means), sqrt(sum(variances)));
    oppExpVal = 1 - teamExpVal;
    expectation = [teamExpVal oppExpVal];
    
    % Variance of win probability
    teamVar = teamExpVal - teamExpVal^2;
    oppVar = oppExpVal - oppExpVal^2;
    variance = [teamVar oppVar];
    
    return;
end