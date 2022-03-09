clear all
close all
clc

% Matricea de stare
A = [-51, 15, 8; 12, 10, 2; -8, 12, -80];

% Matricea care pondereaza intrarile
B = [0.2, 0; 0.4, 1; 0, 0];

% Matricea care pondereza iesirile
C = [1, 4, 0; 0, 15, 0];

% Matricea de transfer direct
D = [0, 0; 0, 0];

% 1

% Conform dimensiunilor matricei A, sistemul are 3 stari, conform matricei
% B are 2 intrari, si conform matricei C are 2 iesiri

sys = ss(A, B, C, D);

% 2

% Conform functiei isstable, se observa ca sistemul nu este stabil
isstable(sys)

% Deoarece sistemul nu este stabil, nu se poate determina timpul
% tranzitoriu, deoarece nu avem regim stationar

% 3

% Matricea de controlabilitate
R = ctrb(A, B);

% Rangul matricei de controlabilitate este 3 si este egal cu numarul de 
% stari, deci sistemul este controlabil
rank(R)

% Matricea de observabilitate
Q = obsv(A, C);

% Rangul matricei de observabilitate este 3 si este egal cu numarul de 
% stari, deci sistemul este observabil
rank(Q)



