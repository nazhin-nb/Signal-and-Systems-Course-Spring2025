% Part 1
clc;
clearvars;
%% Problem 1: Scalar Variables
a = 10;
b = 2.5e23;
c = 2 + 3i; 
d = exp(2j * pi / 3);
%% Problem 2: Vector Variables
aVec = [3.14 15 9 26];         
bVec = [2.71; 8; 28; 182];        
cVec = 5:-0.2:-5;              
dVec = logspace(0, 1, 101);     
eVec = 'Hello';                
%% Problem 3: Matrix Variables
aMat = 2 * ones(9);            
bMat = diag([1 2 3 4 5 4 3 2 1]); 
cMat = reshape(1:100, 10, 10)';
dMat = nan(3, 4);
eMat = [13 -1 5; -22 10 -87];   
fMat = randi([-3, 3], 5, 3);
%% Problem 4: Scalar Equations
x = 1 / (1 + exp(-(a - sqrt(b))));
y = (sqrt(a) + nthroot(b, 21))^pi;
z = log(real((c + d) * (c - d))) * sin(a * pi / 3) / (c * conj(c)); 
%% Problem 5: Matrix Equations
xMat = (aVec * bVec) * aMat^2;
yMat = bVec * aVec;
zMat = det(cMat) * (aMat * bMat)';
%% Problem 6: Common Functions and Indexing
cSum = sum(cMat);
eMean = mean(eMat, 2);
eMat(1, :) = [1 1 1];
cSub = cMat(2:9, 2:9);
lin = 1:20;                
lin(2:2:end) = -lin(2:2:end);
r = rand(1, 5);            
r(find(r < 0.5)) = 0;