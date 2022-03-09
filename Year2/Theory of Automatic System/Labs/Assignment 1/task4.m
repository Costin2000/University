%% ** Task4 **

clear all
close all
clc

t = 0:0.01:40
h = 100/3*exp((-t)/3);

u1 = sin(100*t);
u2 = zeros(1, length(t));

for i=1:length(t)
    if(t(i) >= 0)
        u2(i) = 1;
    end
end

% Pentru intrarea u3(t)=u2(t) + u1(t)
u3 = u1 + u2;
plot(t, u3);
xlabel('t (s)');
ylabel('u3(t)');
title('Graficul intrarii u3(t)');

pos1 = get(gcf,'Position'); 
set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0]);

% Raspunsul y3(t) la intrarea lui u3(t)
ts_continous_conv(u3, h, t);
title('Raspunsul y3(t) la intrarea lui u3(t)');
xlabel('t (s)');
ylabel('y3(t)');
legend('y3(t) - raspunsul convolutiei dintre u3 si h');

set(gcf,'Position', get(gcf,'Position') + [0,0,150,0]);
pos2 = get(gcf,'Position');  
set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0])

% Putem observa analizand graficul functiei u3, dar si al
% functiei y3, ca proprietatile semnalului raman
% neschimbate comparativ cu functiile u1, u2, y1 si y2.

% Acest lucru se datoreaza pricipiului superpozitiei, care ne 
% asigura ca pentru orice sistem liniar raspunsul generat de 
% mai multe semnale/stimuli este egal cu suma raspunsurilor generate
% de fiecare semnal in parte.

