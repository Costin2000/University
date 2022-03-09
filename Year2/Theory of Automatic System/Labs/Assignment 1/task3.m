%% ** Task3 **

clear all
close all
clc

t = 0:0.01:40;
h = 100/3*exp((-t)/3);

% Pentru intrarea u1(t)=sin(100t)
u1 = sin(100*t);

ts_continous_conv(u1, h, t);
title('Raspunsul y1(t) la intrarea lui u1(t)');
xlabel('t (s)');
ylabel('y1(t)');
legend('y1(t) - raspunsul convolutiei dintre u1 si h');

pos1 = get(gcf,'Position'); 
set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0]);


% Pentru intrarea u2(t)=1(t)
% Masina atinge viteza finala dupa 26 de secunde.

% In cazul care acceleratia este apasata la 50% din cursa
% ei maxima, timpul in care masina atinge viteza maxima
% se dubleaza, adica timpul o sa devina 52 secunde.

u2 = zeros(1, length(t));
for i=1:length(t)
    if(t(i) >= 0)
        u2(i) = 1;
    end
end

ts_continous_conv(u2, h, t);
title('Raspunsul y2(t) la intrarea lui u2(t)');
xlabel('t (s)');
ylabel('y2(t) (m/s)');
legend('y2(t) - raspunsul convolutiei dintre u2 si h');

set(gcf,'Position', get(gcf,'Position') + [0,0,150,0]);
pos2 = get(gcf,'Position');  
set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0])
