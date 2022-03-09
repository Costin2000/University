clear all
close all
clc
load('RCAM_lon.mat');

% Sistemul detrminat de modelul logitudinal
sys = ss(A_lon, B_lon, C_lon, D_lon)

% Matricea de transfer a sistemului
H = tf(sys)

% Vectorul starilor cu o viteza in raport cu axa OX a SR atasat de 20 m/sec
% si o rata de tangaj de 2 grd/sec.
x = [2, 0, 20, 0]';

% Raspunsul liber al dinamicii longitudinale a avionului
figure;
set(gcf, 'Position',  [100, 100, 800, 800])
% Timpul final este setat la 5 secunde pentru a corespunde cu timpul luat
% la taskurile viitoare si pentru a demonstra ca raspunsul total este suma
% dintre raspunsul liber si cel fortat.
initial(sys, x, 5)
title('Raspunsul liber al dinamicii longitudinale a avionului');
ylabel('Viteza totala a aeronavei [m/sec]     Viteza pe axa OZ a SR atasat Pamantului [m/sec]     Rata de tangaj [grd/sec]');

