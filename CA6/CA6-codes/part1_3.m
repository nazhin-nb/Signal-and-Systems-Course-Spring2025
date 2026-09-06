clc;
clear;

fc = 5;
fs = 100;
B = 0.3;
C = 3e8;
p = 2/C;

% Analyzing Recieved signal
y = load("received1.mat");
y = struct2cell(y);
y = cell2mat(y);
fourier = fftshift(fft(y));
phase = angle(fourier);
fabs = abs(fourier);
[row,col] = find(fabs==max(fabs));
phase = abs(phase(col(2)));
fnew = (col(2)-(length(y)/2)-1)*(fs/(length(y)));

fd = fnew-fc;
td = phase/(fnew*2*pi);
v = (fd/B)*(3600/1000);
R = (td/p)/1000;
disp(['R:',num2str(R)]);
disp(['v:',num2str(v)]);