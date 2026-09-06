clc;
clear;

fc = 5;
fs = 100;
B = 0.3;
C = 3e8;
p = 2/C;

% Analyzing Recieved signal
y = load("received2.mat");
y = struct2cell(y);
y = cell2mat(y);
fourier = fftshift(fft(y));
phase = angle(fourier);
fabs = abs(fourier);
[row,col] = maxk(fabs,4);

phase1 = abs(phase(col(4)));
fnew1 = (col(4)-(length(y)/2)-1)*(fs/(length(y)));
fd1 = fnew1-fc;
td1 = phase1/(fnew1*2*pi);
v1 = (fd1/B)*(3600/1000);
R1 = (td1/p)/1000;

phase2 = abs(phase(col(2)));
fnew2 = (col(2)-(length(y)/2)-1)*(fs/(length(y)));
fd2 = fnew2-fc;
td2 = phase2/(fnew2*2*pi);
v2 = (fd2/B)*(3600/1000);
R2 = (td2/p)/1000;
disp(['v1:',num2str(v1)]);
disp(['R1:',num2str(R1)]);
disp(['v2:',num2str(v2)]);
disp(['R2:',num2str(R2)]);