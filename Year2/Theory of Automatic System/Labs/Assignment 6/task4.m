clear all
close all
clc
load('CAR_TSA.mat');

% Avand in vedere matricea modificata, elementul de pe linia 3 si coloana 3
% nu mai este 1, deci senzorul de temperatura nu mai functioneaza cum
% trebuie, lucru ce modifica temperatura din habitaclul masinii. Mai mult
% din graficul pentru temperatura din habitaclul masinii, putem observa ca
% defectinea senzorului de temperatura a dus la o temperatura constanta de
% 0 grade C.
Cf = [1, 0, 0; 0, 1, 0; 0, 0, 0];

damaged_sys = ss(A, B, Cf, D);

t = 0:1:100;

u = [100, 24];

for i=1:length(t)
    u(1, i) = 100;
    u(2, i) = 24;
end

damaged_out = lsim(damaged_sys, u, t);

% Graficul pentru pozitia masinii in SR inertial
figure;
plot(damaged_out(:, 1));
title('Graficul pentru iesirea y1');
xlabel('Timp (s)');
ylabel('Pozitia masinii in SR inertial (Km)');

% Graficul pentru viteza masinii in SR inertial
figure;
plot(damaged_out(:, 2));
title('Graficul pentru iesirea y2');
xlabel('Timp (s)');
ylabel('Viteza masinii in SR inertial (Km/h)');

% Graficul pentru temperatura din habitaclul masinii 
figure;
plot(damaged_out(:, 3));
title('Graficul pentru iesirea y3');
xlabel('Timp (s)');
ylabel('Temperatura din habitaclul masinii (C)');

% Matricea de controlabilitate a sistemului
R = ctrb(A, B)

% Rangul matricei de controlabilitate ramane nemodificat, dceci sistemul
% este controlabil
rank(R)

% Matricea de observabilitate, modificata
Q = obsv(A, Cf)

% Rangul matricei de observabilitate este 2, diferit de numarul total de
% stari (3), deci sistemul nu mai este observabil in totalitate.
rank(Q)