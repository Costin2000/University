clear all
close all
clc

s = tf('s');

H = 1 / (0.7 * s^2 + 0.1 * s + 0.3);

% Se observa in urma afisarii polilor ca avem de a face cu un sistem de
% ordin II cu poli complecsi.
pole(H)

% 1

[wn, zeta] = damp(H);

disp(wn)
disp(zeta)

% 2

% Se observa ca sistemul este stabil
isstable(H)

% Determinarea suprareglajului pentru sistemul dat
overshoot = exp(-pi*zeta(1, 1) / sqrt(1 - zeta(1, 1)^2));

disp(overshoot)

% Parametrul functiei de transfer care influenteaza acest indicator de
% performanta (suprareglajul), este coeficientul de amortizare, deoarece, 
% deoarece pentru sisteme de ordinul II suprareglajul este o functie a 
% coeficientului de amortizare

% 3


% 4

% Avand in vedere graficul obtinut din bode, dar si prin faptul ca
% numaratorul functiei de transfer este o functie de ordinul 0, putem spune
% ca sistemul este un filtru de tipul trece-jos.
figure;
bode(H)

