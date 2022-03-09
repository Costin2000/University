s = tf('s');

% frecventa de cut-off
fc = 100;

% Formula dedusa pentru RC
RC = 1 / 2*pi*fc;
% O pereche RC care satisface conditia este R = 3, C = 52.35

% Functia de transfer
H = RC*s / (1 + RC*s);

% preia vectorul de valori u si frecventa de esantionare (sampling)
[u, fs] = play_file('./bass_test.wav', false);

% y este semnalul audio rezultat in urma aplicarii filtrului
y = apply_filter(H, u, fs);

%play_signal(y, fs);

% Formula frecventei de cut-off
% fc = 1 / 2piRC ==> RC = 1 / 2pifc