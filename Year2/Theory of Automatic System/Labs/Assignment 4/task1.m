%% This is a test for task 1 %%

s = tf('s');

% functie de transfer
H = 10*s / (1 + 10*s); 

% preia vectorul de valori u si frecventa de esantionare (sampling)
[u, fs] = play_file('./supernova.wav', false); 

% y este semnalul audio rezultat in urma aplicarii filtrului
y = apply_filter(H, u, fs);
%play_signal(y, fs);

