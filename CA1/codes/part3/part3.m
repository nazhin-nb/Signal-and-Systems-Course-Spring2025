%% part3
clc;
clearvars;
close all;
%% 3-1
ts= 1e-9;
T= 1e-5;
tau= 1e-6;
t= 0:ts:T;
x=zeros(size(t));
x(1:(tau/ts))=1;
figure;
plot(t,x);
xlim([0,T]);
ylim([-0.2 1.2]);
xlabel('t');
ylabel('x1(t)');
title('Transmission Signal');
%% 3-2
R=450;
c=3e8;
td=(2*R)/c;
Received_Signal=zeros(size(t));
alpha=0.5;
Received_Signal((td/ts):((td+tau)/ts))=alpha;
figure;
plot(t,Received_Signal);
xlim([0,T]);
ylim([-0.2 1.2]);
xlabel('t');
ylabel('x2(t)');
title('Received Signal');
%% 3-3
ts= 1e-9;
T= 1e-5;
tau= 1e-6;
t= 0:ts:T;
ro = p3_corfunc(t, tau, ts, Received_Signal);
figure;S
plot(t,ro,'LineWidth',2);
[a, max_corr] = max(ro);
td = t(max_corr);
estimated_R = td * c / 2;
fprintf('Actual Distance: %.2f meters\n', R);
fprintf('Estimated Distance: %.2f meters\n', estimated_R);
%% 3-4
noise = 0;
k = 100;
R = 450;
noise_raise =0.1;
errors = zeros(1,k);
Rs = zeros(1,k);
last_err = 0;
i = 1;
while(last_err < 10)
sum_err = 0;
sum_R = 0;
for j=1:100
ro = p3_corfunc(t, tau, ts, Received_Signal + noise * randn(size(Received_Signal)));
[a, max_corr] = max(ro);
estimated_R = t(max_corr) * c / 2;
sum_err = sum_err + abs(R - estimated_R);
sum_R = sum_R + estimated_R;
end
errors(i) = sum_err / 100;
Rs(i) = sum_R / 100;
last_err = errors(i);
i = i + 1;
noise = noise + noise_raise;
end
last = i - 1;
noise_signal= (0 : noise_raise : noise_raise * (last - 1));
figure;
subplot(1, 2, 1);
plot(noise_signal, errors(1:last), 'LineWidth', 2);
title('Error');
xlabel('noise');
ylabel('error');
subplot(1, 2, 2);
plot(noise_signal, Rs(1:last), 'LineWidth', 2);
title('Estimated Distance(R)');
xlabel('noise');
ylabel('R');
