% p1
clc, clearvars, close all;
%% P1-1
% Creating a mapset
Nch=32;
mapset=cell(2,Nch);
Alphabet ='abcdefghijklmnopqrstuvwxyz .,!";';
for i=1:Nch
    mapset{1,i}=Alphabet(i);
    mapset{2,i}=dec2bin(i-1,5);
end
%% p1-2
% Get the picture and make it b&w
X=imread('flower.jpg');
X=rgb2gray(X);
message='signal;';
Y=coding(message, X, mapset);
%% p1-3
message='signal;';
Y=coding(message, X, mapset);
subplot(1,2,1)
imshow(X)
title('Original picture')
subplot(1,2,2)
imshow(Y)
title('Coded picture')
%% p1-4
threshold = 0.5;
block_size = 5;
decoded_message = decoding(Y, mapset, threshold, block_size);
disp(decoded_message)
