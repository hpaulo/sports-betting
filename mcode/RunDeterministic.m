close all; clear all;clc


% A = [-1 -1 -2;1 2 2];
% b = [0 72];
% x0 = [10;10;10];
x0 = [10;1;10;1;10;1];

%simulated probability
R = rand(1,3);


[x, fval] = fmincon(@(x) objectiveFunc(x,R), x0, [],[],[],[],[],[],@(x) constraintFunc(x,R)) 