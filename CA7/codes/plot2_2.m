clc;
clear all;
t = 0:0.01:20;
x = (2*exp(-t))-(t.*exp(-t));
figure
plot(t,x)

