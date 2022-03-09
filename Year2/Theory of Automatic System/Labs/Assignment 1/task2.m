%% ** Task2 **

clear all
close all
clc


t = -5:0.01:5;
r = zeros(1, length(t));

for i = 1:length(t)
    if((t(i) >= -1) && (t(i) <= 1))
        r(i) = 1 - abs(t(i));
    end
end

figure;
plot(t, r);
title('Semnal de intrare triunghiular');
xlabel('t (s)');
ylabel('triangular(t)');
