clc;
clear;

fc = 5;
fs = 100;
B = 0.3;
C = 3e8;
p = 2/C;

y = load("received1.mat");
y = struct2cell(y);
y = cell2mat(y);

% Adding noise to the received signal and analyzing
for i=1:100
    sigma = 0.01*i;
    noise = sigma*randn(1,length(y));
    y = y + noise;


    fourier = fftshift(fft(y));
    phase = angle(fourier);
    fabs = abs(fourier);
    [row,col] = find(fabs==max(fabs));
    phase = abs(phase(col(2)));
    fnew = (col(2)-(length(y)/2)-1)*(fs/(length(y)));
    disp(['sigma:',num2str(sigma)]);
    fd = fnew-fc;
    td = phase/(fnew*2*pi);
    v = (fd/B)*(3600/1000);
    R = (td/p)/1000;
    disp(['v:',num2str(v)]);
    disp(['R:',num2str(R)]);
end