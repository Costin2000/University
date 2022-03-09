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

% Vectorul starilor cu o viteza in raport cu axa OX a SR atasat de 20 m/sec
% si o rata de tangaj de 2 grd/sec.
x = [2, 0, 20, 0]';

% Raspunsul total al dinamicii longitudinale a avionului
figure;
set(gcf, 'Position',  [100, 100, 800, 800])
lsim(sys, u, t, x);
title('Raspunsul total al dinamicii longitudinale a avionului');
ylabel('Viteza totala a aeronavei [m/sec]     Viteza pe axa OZ a SR atasat Pamantului [m/sec]     Rata de tangaj [grd/sec]');

% Pe baza graficelor de la subpunctele 2, 3 si 4 dar si conform breviarului
% pentru acest laborator, se observa ca raspunsul total este suma dintre 
% raspunsul fortat si raspunsul liber.
