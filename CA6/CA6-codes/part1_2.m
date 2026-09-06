clc;
clear;

% Creating Received signal
fc = 5;
fs = 100;
tstart = 0;
tend = 1;
v = (180*1000)/3600;
R = 250*1000;
B = 0.3;
a = 0.5;
C = 3e8;

ts = 1/fs;
t = tstart:ts:tend-ts;
fd = B*v;
p = 2/C;
td = p*R;

y = a*cos(2*pi*(fc+fd)*(t-td));
figure
plot(t,y)
title('Received Signal')

save('received1.mat',"y");