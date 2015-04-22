%% SYDE 531: Design Optimization Under Probabilistic Uncertainty
% Authors: Jonathan Johnston
%          Logan Money
%          Tom Terlecki
% Date:    2015/4/20
close all; clc; clear all;
%clearvars -except teams teamStats matchups matchupStats
%% Load NCAA statistical data
[teams, teamStats] = parseTeamStats('../data/generated/TeamStats.csv');
[matchups, matchupStats] = parseMatchupStats('../data/generated/MatchupStats.csv');

%% Define parameters
% Input variables and constraints
budget = 2000;

% Matches and teams
numMatches = 6; % number of matches in series
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
simulateGameSeries;

%% Optimization

% Select Method
% 1. Maximization of return for a given a risk target
% 2. Mean Markovitz
method = 1;

% Set Targets
% 1. Target Variances
targetVariances = 30.*ones(numMatches,1);
targetVariance = sum(targetVariances);

% 2. Mean Variance Parameters
o = zeros(1);

% Form Linear Inequality Constraints (budget and non-negativity)
[A,b] = getFeasibleRegion(numMatches,budget);

% Find Optimal Bets
x0 = zeros(2*numMatches,1); % set starting point to zero vector
[x,fval] = fmincon(@(x) objFun(x,method),x0,A,b,[],[],[],[],@(x) conFun(x,method));

% Collect Solution Statistics at Optimal x
if method == 1
    EZ = -fval;
    varZ = targetVariance/numMatches;
else
    EZ = 0;
    varZ = 0;
end

%% Test Betting Strategy (re-simulating game outcomes)
resims = 1000;
OFout = zeros(resims,1);
for r = 1:resims
    if method == 1
        simulateGameOutcomes;
        OFout(r,1) = objFun(x,0);
    end
end
OFmean = mean(OFout);
OFvar = var(OFout);

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

% x0 = [10;1;10;1;10;1;10;1;10;1;10;1];
% % R = rand(1,3);
% 
% %just randomly picking a team out of each pairing
% TeamPick = randi([1 2],1,6);
% %theta is picked arbitrarily, may need to ask apurva
% theta = 1;
% %fmincon using deterministic model
% deterministic = true;
% chanceconstrained = false;
% [x, fval] = fmincon(@(x) objectiveFunc(x,winProbs,expectations,variances,...
%     bettingPools,TeamPick,theta,deterministic,chanceconstrained),...
%     x0, [],[],[],[],[],[],@(x) constraintFunc(x,budget)) 
% 
% %fmincon using chance-constrained model/Markovitz
% chanceconstrained = true;
% deterministic = false;
% [x, fval] = fmincon(@(x) objectiveFunc(x,winProbs,expectations,variances,...
%     bettingPools,TeamPick,theta,deterministic,chanceconstrained),...
%     x0, [],[],[],[],[],[],@(x) constraintFunc(x,budget)) 
