%% ** Task1 **

clear all
close all
clc

t = 0:0.01:200;
r = zeros(1, length(t));
a = 80;
b = 100;
for i = 1:length(t)
    if((t(i) >= a) && (t(i) <= b))
        r(i) = 1;
    end
end

figure;
plot(t, r);
title('Semnal de intrare dreptunghiular');
xlabel('t (s)');
ylabel('rectangular(t)');
