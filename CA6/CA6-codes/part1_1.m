clc;
clear;

% Creating sent signal
fc = 5;
fs = 100;
tstart = 0;
tend = 1;

ts = 1/fs;
t = tstart:ts:tend-ts;

x = cos(2*pi*fc*t);
figure
plot(t,x)
title('Sent Signal')