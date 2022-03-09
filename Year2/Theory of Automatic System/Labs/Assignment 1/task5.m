%% ** Task5 **

clear all
close all
clc

t = 0:0.01:40;
h = 100/3*exp((-t)/3);

u2 = zeros(1, length(t));

for i=1:length(t)
    if(t(i) >= 0)
        u2(i) = 1;
    end
end


u4 = zeros(1, length(t));

for i=1:length(t)
    if(t(i) >= 3)
        u4(i) = 1;
    end
end

% Iesirea cauzata de treatpa fara intarziere
ts_continous_conv(u2, h, t);
title('Raspunsul la intrarea lui u2(t)');
xlabel('t (s)');
ylabel('y2(t)');
legend('y2(t) - raspunsul convolutiei dintre u2 si h');

pos1 = get(gcf,'Position'); 
set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0]); 

% Iesirea cauzata de treatpa cu intarziere
ts_continous_conv(u4, h, t);
title('Raspunsul y4(t) la intrarea lui u4(t)');
xlabel('t (s)');
ylabel('y4(t)');
legend('y4(t) - raspunsul convolutiei dintre u4 si h');

set(gcf,'Position', get(gcf,'Position') + [0,0,150,0]);
pos2 = get(gcf,'Position');  
set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0]);

% Analizand graficele iesirilor lui u2(t) si u4(t), putem observa
% ca este aplicat acelasi semnal, dar la alt moment de timp, deci 
% semnalul y4(t) va determina acelasi semanal ca y2(t), decalat cu 3
% secunde. 

% Putem spune ca modelul automobilului respecta caracterul de sistem
% invariant in timp.
