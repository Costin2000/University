s = tf('s');

% Folosind functia bode sunt extrase magnitudinea si faza pentru
% raspunsul functiei de transfer pentru un interval de frecvente din
% wout.
H = s^2 / (s^2 + 62.83*s + 394800);

[mag, phase, wout] = bode(H);

% pulsatia
w = sqrt(394800);

% 2 * z * w = 62.83 ==> z = 62.83 / (2 * w)
z = 62.83 / (2 * w);

% preia vectorul de valori u si frecventa de esantionare (sampling)
[u, fs] = play_file('./bass_test.wav', false);

% Zeta ul initial din functia de transfer oferita este mult prea mic pentru
% a evidentia calitatea bass-ului, asa ca el trebuie marit la o valoare mai
% mare ca 1, pentru ca raspunsul sa fie amortizat.
new_z = 1.5; % Noul coeficient de amortizare, de 30 de ori mai mare
new_coeficient = 2 * new_z * w;

% Noua functie de transfer
new_H = s^2 / (s^2 + new_coeficient*s + 394800);


% y este semnalul audio rezultat in urma aplicarii filtrului
y = apply_filter(new_H, u, fs);

%play_signal(y, fs);


