syms y(x)
syms x
uStep = heaviside(x);
Dy = diff(y);
ode = diff(y, x, 2) + 3 * diff(y, x) == -2 * y + 5 * uStep;
cond1 = y(0) == 1;
cond2 = Dy(0) == 1;
conds = [cond1, cond2];
ySol(x) = dsolve(ode, conds);
fplot(ySol, [0, 10])

t = 0:0.01:10;
calcAns = 5/2 - 2 * exp(-t) + (1/2) * exp(-2 * t);
figure
plot(calcAns)
