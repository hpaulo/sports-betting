%% Simulate game series
teamIndices = randperm(length(teams), 2*numMatches); % indices of teams in series
for i = 1:numMatches
    % Build team matchup list
    teamName = teams(teamIndices(i), 1);
    oppName = teams(teamIndices(numMatches + i), 1);
    teamNames(i,:) = [teamName, oppName];
    [matchupExists, matchIdx(i)] = ismember(teamNames(i), matchups);
    
    % Fill the betting pools
    if ~matchupExists
        bettingPools(i,:) = [ceil(poolSize/2), floor(poolSize/2)];
    else
        [bettingPools(i,1), bettingPools(i,2)] = generateBettingPool( ...
                                                matchupStats(matchIdx(i),:), ...
                                                poolSize);
    end
    
    % Calculate EV and variance of win probabilities
    [expectations(i,:), variances(i,:)] = calcMatchupProbs( ...
                                              teamStats(teamIndices(i), :), ...
                                              teamStats(teamIndices(numMatches + i), :));
end