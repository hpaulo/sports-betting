%% SYDE 531: Design Optimization Under Probabilistic Uncertainty
% Authors: Jonathan Johnston
%          Logan Money
%          Tom Terlecki
% Date:    2015/4/20
close all; clc; clear all;

%% Load NCAA statistical data
[teams, teamStats] = parseTeamStats('../data/generated/TeamStats.csv');
[matchups, matchupStats] = parseMatchupStats('../data/generated/MatchupStats.csv');

%% Define parameters
% Input variables and constraints
budget = 1000;

% Matches and teams
numMatches = 6; % number of matches in series
teamIndices = randperm(length(teams), 2*numMatches); % indices of teams in series
teamNames = cell(numMatches, 2); % names of the teams in the matchups
matchIdx = zeros(numMatches,1);

% Betting pools
bettingPools = zeros(numMatches, 2); % betting pool for each match
poolSize = 50000; % size of betting pool on each match

% Outcome probabilities and actual outcomes
expectations = zeros(numMatches, 2); % expected probability of a win
variances = zeros(numMatches, 2); % variance of win probability
winProbs = zeros(numMatches, 2); % actual outcomes

%% Simulate game series
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
    
    % Simulate the match's outcome
    winProbs(i,:) = simulateMatchup( ...
                        teamStats(teamIndices(i), :), ...
                        teamStats(teamIndices(numMatches + i), :));
end

%% Optimization
% INSTRUCTIONS
% ============
% Use the betting pool for match t and team i (1 or 2)
%bettingPools(t,i)

% Use the expected value of the probability of winning
% for match t and team i (1 or 2)
%expectations(t,i)

% Use the variance of the probability of winning for match t
% and team i (1 or 2)
%variances(t,i)

% Verify the outcome (for testing only now) for match t, team i (1 or 2)
%winProbs(t,i)

% x0 = [1;1;1;1];
x0 = [0;0;0;0;0;0;0;0;0;0;0;0];



%theta is picked arbitrarily, may need to ask apurva
theta = [3,2,1,0.1,0.01];%5 elements
%fmincon using deterministic model
deterministic = true;
markovitz = false;
[x, fval] = fmincon(@(x) objectiveFunc(x,winProbs,expectations,variances,...
    bettingPools,theta,deterministic,markovitz,numMatches),...
    x0, [],[],[],[],[],[],@(x) constraintFunc(x,budget)) 

%fmincon using chance-constrained model/Markovitz
    markovitz = true;
    deterministic = false;

for i = 1:length(theta)  
    [x, fval] = fmincon(@(x) objectiveFunc(x,winProbs,expectations,variances,...
        bettingPools,theta(i),deterministic,markovitz,numMatches),...
        x0, [],[],[],[],[],[],@(x) constraintFunc(x,budget))
    fval = -fval
    fvalmark(i) = fval;
    theta(i)
end
