close all;
clc;
clear;
%% 1-Creating the mapset

mapset = create_mapset();
%% Part3 Coding the message

fs = 100;
message = 'signal';
coded_signal = cell(1,3);
figure
for i=1:3
    coded_signal{i} = coding_amp(message,i);
    t = 0:(1/fs):(length(coded_signal{i})/fs)-(1/fs);
    subplot(1,3,i);
    plot(t,coded_signal{i})
end
%% Part4 Decoding the signal
decoded_signal = cell(1,3);
for i=1:3
    decoded_signal{i} = decoding_amp(coded_signal{i},i);
    fprintf("bitrate = %d message = %s \n", i, decoded_signal{i});
end
%% Part5 Adding noise
% 5- Noise
noise=randn(1,3000);
figure
histogram(noise)
Mean=mean(noise)
variance=var(noise)
%% Part6 Controlling the noise
m = 0.01;

noisy_signal = cell(1,3);
for i=1:3
    noise = m * randn(1, length(coded_signal{i}));
    noisy_signal{i} = coded_signal{i} + noise;
    t = 0:(1/fs):(length(noisy_signal{i})/fs)-(1/fs);
    subplot(1,3,i);
    plot(t,noisy_signal{i})
    decoded = decoding_amp(noisy_signal{i},i);
    fprintf("bitrate = %d message = %s \n", i, decoded);
end
%% Part7 Trying different noises
M = [0.05, 0.5, 5];
figure
for j = 1:3
    m = M(j);
    fprintf('----- standard deviation = %d -----\n', m);
    for i=1:3
        noise = m * randn(1, length(coded_signal{i}));
        noisy_signal{i} = coded_signal{i} + noise;
        t = 0:(1/fs):(length(noisy_signal{i})/fs)-(1/fs);
        subplot(3,3,3*(j-1) + i);
        plot(t,noisy_signal{i})
        decoded = decoding_amp(noisy_signal{i},i);
        fprintf("bitrate = %d message = %s \n", i, decoded);
    end
end
%% Part8 Trying different noises
M = [2, 0.5, 0.3];
figure
for i=1:3
    m = M(i);
    noise = m * randn(1, length(coded_signal{i}));
    noisy_signal{i} = coded_signal{i} + noise;
    t = 0:(1/fs):(length(noisy_signal{i})/fs)-(1/fs);
    subplot(1, 3, i);
    plot(t,noisy_signal{i})
    decoded = decoding_amp(noisy_signal{i},i);
    fprintf("bitrate = %d message = %s \n", i, decoded);
end


