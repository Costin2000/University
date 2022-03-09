clear all
close all
clc
load('CAR_TSA.mat');

sys = ss(A, B, C, D);

t = 0:1:100;

u = [100, 24];

for i=1:length(t)
    u(1, i) = 100;
    u(2, i) = 24;
end

% Iesirea sistemului pentru cazul in care pedala de acceleratie este
% apasata si mentinuta la viteza maxima, iar temperatura climatizarii este
% setata la 24 de grade C.
sys_output = lsim(sys, u, t);

% Graficul pentru pozitia masinii in SR inertial
figure;
plot(sys_output(:, 1));
title('Graficul pentru iesirea y1');
xlabel('Timp (s)');
ylabel('Pozitia masinii in SR inertial (Km)');

% Conform graficului de mai sus, dupa 25 de secunde masina se afla la 611
% de metri fata de punctul initial de referinta de unde au inceput
% masuratorile.

% Graficul pentru viteza masinii in SR inertial
figure;
plot(sys_output(:, 2));
title('Graficul pentru iesirea y2');
xlabel('Timp (s)');
ylabel('Viteza masinii in SR inertial (Km/h)');

% Graficul pentru temperatura din habitaclul masinii 
figure;
plot(sys_output(:, 3));
title('Graficul pentru iesirea y3');
xlabel('Timp (s)');
ylabel('Temperatura din habitaclul masinii (C)');

% Conform graficului de mai sus, temperatura de referinta din habitaclu, de
% 24 de grade C se atinge dupa 27 de secunde.

