%% Question 0
close all;
clc;
clear;
f=-10:1:9;
fs=20;
ts=1/fs;
t=0:ts:1-ts;
x1=exp(1j*2*pi*5*t)+exp(1j*2*pi*8*t);
x2=exp(1j*2*pi*5*t)+exp(1j*2*pi*5.1*t);
y1=fftshift(fft(x1));
y2=fftshift(fft(x2));
y1=y1/max(abs(y1));
y2=y2/max(abs(y2));
figure;
subplot(1,2,1);
plot(f,abs(y1));
subplot(1,2,2);
plot(f,abs(y2));
%% Question 1
close all;
clc;
clear;
%% Part 1
fs=50;
ts=1/fs;
t=-1:ts:1-ts;
N=length(t);
f=-fs/2:fs/N:(fs/2)-(fs/N);
x1=cos(10*pi*t);
figure;
subplot(1,2,1)
plot(t,x1);
y1=fftshift(fft(x1));
y1=y1/max(abs(y1));
subplot(1,2,2)
plot(f,abs(y1));
%% Part 2
clear
fs=100;
ts=1/fs;
t=0:ts:1-ts;
N=length(t);
f=-fs/2:fs/N:(fs/2)-(fs/N);
x2=cos(30*pi*t+pi/4);
figure;
subplot(1,3,1)
plot(t,x2);
y2=fftshift(fft(x2));
y2=y2/max(abs(y2));
subplot(1,3,2)
plot(f,abs(y2));
tol=1e-6;
y2(abs(y2)<tol)=0;
theta=angle(y2);
subplot(1,3,3)
plot(f,theta/pi);
xlabel 'Frequency (Hz)';
ylabel 'Phase /\pi'
%% Question 2
close all;
clc;
clear;
%% 1-Creating the mapset
mapset = create_mapset();
%% 2- Coding the message
fs = 100;
message = 'signal';
bit_rate=[1,5];
coded_signal = cell(1,2);
figure
for i=1:2
    coded_signal{i} = coding_freq(message,bit_rate(i));
    % 3- Plotting the result
    t = 0:(1/fs):(length(coded_signal{i})/fs)-(1/fs);
    subplot(1,2,i)
    plot(t,coded_signal{i})
end
%% Part4 Decoding the signal
decoded_signal = cell(1,2);
for i=1:2
    decoded_signal{i} = decoding_freq(coded_signal{i},bit_rate(i));
    fprintf("bitrate = %d message = %s \n", bit_rate(i), decoded_signal{i});
end
%% Part5 Controlling the noise
m = 0.01;
noisy_signal = cell(1,2);
for i=1:2
    noise = m * randn(1, length(coded_signal{i}));
    noisy_signal{i} = coded_signal{i} + noise;
    t = 0:(1/fs):(length(noisy_signal{i})/fs)-(1/fs);
    subplot(1,2,i);
    plot(t,noisy_signal{i})
    decoded = decoding_freq(noisy_signal{i},bit_rate(i));
    fprintf("bitrate = %d message = %s \n", bit_rate(i), decoded);
end
%% Part6 Trying different noises
M = [0.05, 1, 5];
figure
for j = 1:3
    m = M(j);
    fprintf('----- standard deviation = %f -----\n', m);
    for i=1:2
        noise = m * randn(1, length(coded_signal{i}));
        noisy_signal{i} = coded_signal{i} + noise;
        t = 0:(1/fs):(length(noisy_signal{i})/fs)-(1/fs);
        subplot(3,2,2*(j-1) + i);
        plot(t,noisy_signal{i})
        decoded = decoding_freq(noisy_signal{i},bit_rate(i));
        fprintf("bitrate = %d message = %s \n", bit_rate(i), decoded);
    end
end
%% Part7 Trying different noises
M = [1.4, 1.5];
figure
for i=1:2
    m = M(i);
    noise = m * randn(1, length(coded_signal{i}));
    noisy_signal{i} = coded_signal{i} + noise;
    t = 0:(1/fs):(length(noisy_signal{i})/fs)-(1/fs);
    subplot(1, 2, i);
    plot(t,noisy_signal{i})
    decoded = decoding_freq(noisy_signal{i},bit_rate(i));
    fprintf("bitrate = %d message = %s \n", bit_rate(i), decoded);
end

