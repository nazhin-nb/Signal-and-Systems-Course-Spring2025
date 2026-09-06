%p3
clc, clearvars, close all;
%% p3 - 3
dataset = readtable('diabetes-training.csv');
labels = dataset(:, end);
features = dataset(:, 1 : end-1);
predictions = TrainedModel.predictFcn(features);
accuracy = mean(predictions == labels).*100;
disp(accuracy);
%% p3 - 4
dataset = readtable('diabetes-validation.csv');
labels = dataset(:, end);
features = dataset(:, 1 : end-1);
predictions = TrainedModel.predictFcn(features);
accuracy = mean(predictions == labels).*100;
disp(accuracy);
