clear all
close all
clc
load('RCAM_lon.mat');

% Sistemul detrminat de modelul logitudinal
sys = ss(A_lon, B_lon, C_lon, D_lon)

% Matricea de transfer a sistemului
H = tf(sys)

% Vectorul de timpi
t = 0:0.01:5;

% Vectorul intrarilor cu un unghi de deflectie de al elevatoarelor de 2 grd
% si unghiul mansei de acceleratie de 3 grd.
u = [2, 3];

for i=1:length(t)
    u(1, i) = 2;
    u(2, i) = 3;
end

% Raspunsul fortat al dinamicii longitudinale a avionului
figure;
set(gcf, 'Position',  [100, 100, 800, 800])
lsim(sys, u, t)
title('Raspunsul fortat al dinamicii longitudinale a avionului');
ylabel('Viteza totala a aeronavei [m/sec]     Viteza pe axa OZ a SR atasat Pamantului [m/sec]     Rata de tangaj [grd/sec]');
