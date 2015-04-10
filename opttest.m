close all; clear all;clc


A = [-1 -1];
b = [-100];
x0 = [-1;-1];

[x, fval] = fmincon(@objfun, x0, A,b) 