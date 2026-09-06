clc;
clearvars;
load('p2.mat');
%% 2-1
figure;
plot(t,x);
xlabel('t');
ylabel('x');
title('Input Signal x(t)');
%% 2-2
figure;
plot(t,y);
xlabel('t');
ylabel('y');
title('Input Signal y(t)');
%% 2-3
figure;
plot(x,y,'.');
xlabel('x');
ylabel('y'); 
title('Input x & Output y');
%% 2-4
[alpha, beta] = p2_4(x, y)
figure;
plot(x,y,'.');
xlabel('x');
ylabel('y'); 
hold on;
time=-1:0.001:1;
plot(time,alpha*time+beta,LineWidth=2);
title('Input x & Output y');