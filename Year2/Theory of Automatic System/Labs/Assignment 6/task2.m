clear all
close all
clc
load('CAR_TSA.mat');

% Matricea de controlabilitate
R = ctrb(A, B)

% Rangul matricei de controlabilitate este 3 si este egal cu numarul de 
% stari, deci sistemul este controlabil
rank(R)

% Matricea de observabilitate
Q = obsv(A, C)

% Rangul matricei de observabilitate este 3 si este egal cu numarul de 
% stari, deci sistemul este observabil
rank(Q)