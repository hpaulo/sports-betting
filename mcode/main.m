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


%%
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

