%% ** Task 1 **

clc;
clear all;
close all;

s = tf('s'); % variabila s

% first order
k = 100;
T = 2;
H1 = k / (T * s + 1);

figure;
pzmap(H1);

disp("Polul este:");
disp(pole(H1));

if(pole(H1) < 0)
    disp("Deci sistemul este stabil.");
    
else
    disp("Deci sistemul nu este stabil.");

end

% Se observa ca in urma apelarii functii pole, dar si din graficul generat,
% ca polul functiei de transfer este -1/2. Deci putem spune ca sistemul
% este stabil.


% ** Task 2 **

s = tf('s'); % variabila s

% first order
k = 100;
T = 2;
H2 = k / (T * s - 1);

figure;
pzmap(H2);

disp("Polul este:");
disp(pole(H2));

if(pole(H2) < 0)
    disp("Deci sistemul este stabil.");

else
    disp("Deci sistemul nu este stabil.");

end

% Este suficient sa modificam semnul de la numitorul functiei de transfer
% pentru a obtine un pol pozitiv ( 1/2 ), ceea ce duce la un sistem care nu
% mai e stabil.


% ** Task 3 **

figure;
step(H1);

figure;
step(H2);

% ** Task 4 **

figure;
impulse(H1);

% ** Task 5 **

t = [0:0.01:10];
u = zeros(1, length(t));

for i=1:length(t)
    if((t(i) >= 0 && t(i) <= 1) || (t(i) >= 2 && t(i) <= 3) || (t(i) >= 4 && t(i) <= 5))
        u(i) = 1;
    end
end

figure;
lsim(u, H1, t);
