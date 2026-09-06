clc;
clear;

% Creating Received signal
fc = 5;
fs = 100;
tstart = 0;
tend = 1;
B = 0.3;
C = 3e8;
p = 2/C;
ts = 1/fs;
t = tstart:ts:tend-ts;

v1 = (180*1000)/3600;
R1 = 250*1000;
a1 = 0.5;

v2 = (216*1000)/3600;
R2 = 200*1000;
a2 = 0.6;

fd1 = B*v1;
td1 = p*R1;
y1 = a1*cos(2*pi*(fc+fd1)*(t-td1));

fd2 = B*v2;
td2 = p*R2;
y2 = a2*cos(2*pi*(fc+fd2)*(t-td2));
y_double = y1+y2;

figure
plot(t,y_double)
title('Received Signal')
save('received2.mat',"y_double");