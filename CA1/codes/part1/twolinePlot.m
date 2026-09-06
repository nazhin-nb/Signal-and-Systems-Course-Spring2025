%%  Part1-Problem 7: Plotting
figure;
t = 0:0.01:2*pi;
plot(t, sin(t),'Color','blue');
hold on;
plot(t, cos(t),'Color','red','LineStyle','--');
xlabel('t');
ylabel('Value');
title('Sine and Cosine Waves');
legend('Sin', 'Cos');
xlim([0 2*pi]);
ylim([-1.4 1.4]);
