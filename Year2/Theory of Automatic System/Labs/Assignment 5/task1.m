clear all
close all
clc
load('RCAM_lon.mat');

% Sistemul detrminat de modelul logitudinal
sys = ss(A_lon, B_lon, C_lon, D_lon)

% Matricea de transfer a sistemului
H = tf(sys)

% Se poate observa ca atat polii matricei de transfer, cat si spectrul
% matricei de stare A, sau mai bine zis, valorile prorprii ale matricei A
% se afla in C_ (C minus), deci sistemul este stabil. Aceasta este si
% relatia dintre polii matricei de transfer si spectrul matricei A_lon, faptul
% ca polii lui H si valorile proprii ale lui A_lon se afla in C_ .

% Transformarea din model in functie de transfer se poate face doar daca A,
% B, C, D satisfac H(s) = C(sI - A)^(-1) * B + D .
P = pole(H)
eig(A_lon)
isstable(sys)