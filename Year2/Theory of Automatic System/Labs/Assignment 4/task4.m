s = tf('s');

H = s^2 / (s^2 + 62.83*s + 394800);
% pulsatia
w = sqrt(394800);
% 2 * z * w = 62.83 ==> z = 62.83 / (2 * w)
z = 62.83 / (2 * w);
new_z = 1.5; % Noul coeficient de amortizare, de 30 de ori mai mare
new_coeficient = 2 * new_z * w;

% Noua functie de transfer
new_H = s^2 / (s^2 + new_coeficient*s + 394800);

% preia vectorul de valori u si frecventa de esantionare (sampling)
[u, fs] = play_file('./supernova.wav', false); 

% frecventa Nyquist
fn = fs / 10;
    
% filtrul de banda pentru un filtru highpass
passband = [250 512] / fn;

% Filtru de banda cu o amplficare de 2700 decibeli.
[y, d] = bandpass(u, passband, fs);

% Diagrama semnalului audio filtrat cu bandpass
figure;
bandpass(u, passband, fs)

[mag, phase, wout] = bode(new_H);

% Diagrama Bode a functiei de transfer
figure;
bode(new_H, wout)

% Spectrul semnalului audio inainte de aplicarea filtrului
figure;
limits = [wout(1, 1), wout(length(wout), 1)];
plot_fft(u, fs, limits)
    
% Spectrul semnalului audio dupa de aplicarea filtrului
figure;
limits = [wout(1, 1), wout(length(wout), 1)];
plot_fft(y, fs, limits)

%play_signal(y, fs);
    