clc;
clear all;
t = 0:0.01:20;
x = 1+(-1.5*(exp(-t)))+(0.5*(exp(-3*t)));
figure
plot(t,x)