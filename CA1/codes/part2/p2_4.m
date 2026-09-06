function [alpha, beta] = p2_4(x, y)
    x = x(:);  
    y = y(:);  
    N = length(x);
    A = [x ones(N,1)];
    theta = (A' * A) \ (A' * y);
    alpha = theta(1);
    beta = theta(2);
end
