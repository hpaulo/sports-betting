function [winProbs] = simulateMatchup(teamStats, oppStats)
% Summary:  Function for simulating a matchup between teams,
%           which samples from each teams point distribution
%           to determine a winner.
% 
% @params
% teamStats:      statistics for one team
% opponentStats:  statistics for opponent team
%
% @returns
% winProb:  probabilities of winning for each team (either zero or one)
    
    % PDFs
    teamPdf = makedist('Normal', teamStats(3), sqrt(teamStats(5)));
    oppPdf = makedist('Normal', oppStats(3), sqrt(oppStats(5)));
    
    % Generate team and opponent scores
    teamPoints = random(teamPdf);
    oppPoints = random(oppPdf);
    
    if teamPoints > oppPoints
        winProbs = [1 0];
    else % ties go to team 2
        winProbs = [0 1];
    end
    
    return;
end

