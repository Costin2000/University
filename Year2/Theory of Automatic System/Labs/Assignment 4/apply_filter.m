function y = apply_filter(tf, u, fs)

    % Folosind functia bode sunt extrase magnitudinea si faza pentru
    % raspunsul functiei de transfer pentru un interval de frecvente din
    % wout.
    [mag, phase, wout] = bode(tf);
    %disp(wout)
    
    % frecventa Nyquist
    fn = fs / 2;
    
    % filtrul de banda pentru un filtru highpass
    passband = 512 / fn;
    
    % functia highpass preia vectorul cu valorile descompuse din sunet dupa
    % care sunt sample-uite la o frecventa de esantionare de fs Hz, intr-un
    % filtru de banda setat la o  frecventa de 512 / fn Hz
    [y, d] = highpass(u, passband, fs);
    
    figure;
    bode(tf, wout)
    
    figure;
    limits = [wout(1, 1), wout(length(wout), 1)];
    plot_fft(y, fs, limits)

end

