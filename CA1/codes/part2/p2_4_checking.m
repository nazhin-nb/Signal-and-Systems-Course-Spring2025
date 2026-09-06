%% Part 2-4: Testing Alpha and Beta with and without Noise
clc; clear;

N = 100;
x = linspace(-10, 10, N)';
actual_alpha = 2.5;
actual_beta = -1.0;
y = actual_alpha * x + actual_beta;

[alpha_no_noise, beta_no_noise] = p2_4(x, y);

noise_level = 1.0;
y_noisy = y + noise_level * randn(size(y));

[alpha_with_noise, beta_with_noise] = p2_4(x, y_noisy);

fprintf('Actual Alpha: %.2f, Actual Beta: %.2f\n', actual_alpha, actual_beta);
fprintf('Estimated Alpha (No Noise): %.2f, Estimated Beta (No Noise): %.2f\n', alpha_no_noise, beta_no_noise);
fprintf('Estimated Alpha (With Noise): %.2f, Estimated Beta (With Noise): %.2f\n', alpha_with_noise, beta_with_noise);

figure;
plot(x, y, 'b-', 'LineWidth', 2);
hold on;
plot(x, y_noisy, 'r.');
plot(x, alpha_no_noise * x + beta_no_noise, 'g--', 'LineWidth', 2);
plot(x, alpha_with_noise * x + beta_with_noise, 'm--', 'LineWidth', 2);
legend('True Data', 'Noisy Data', 'Estimated Without Noise', 'Estimated With Noise');
title('Linear Regression with and without Noise');
xlabel('x');
ylabel('y');
grid on;
