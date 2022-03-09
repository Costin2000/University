clear all
close all
clc
load('CAR_TSA.mat');

%Avand in vedere matricea modificata, elementul de pe linia 2 si coloana 1
%nu mai este 0.5, ceea ce a dus la o defectiune a intrarii 1, mai exact a
%cursei pedalei de acceleratie, iar acest lucru a modificat si viteza
%masinii in SR inertial. Mai mult, din graficul pentru viteza masinii se
%poate observa ca viteza masinii este constanta, la 0 Km/h, deci in urma
%defectiunii masina sta pe loc.
Bf = [0, 0; 0, 0; 0, 0.33];

damaged_sys = ss(A, Bf, C, D);

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


% Matricea de controlabilitate, dupa defectiune
R = ctrb(A, Bf)

% Rangul matricei este 1, diferit de numarul de stari (3), deci sistemul nu
% este controlabil. Mai exact, o singura stare este controlabila.
rank(R)

% Matricea de observabilitate a sistemului
Q = obsv(A, C)

% Rangul matricei de observabilitate ramane nemodificat, deci sistemul este
% observail pentru toate starile sistemului.
rank(Q)