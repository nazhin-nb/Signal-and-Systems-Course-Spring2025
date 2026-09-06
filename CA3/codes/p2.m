%% p4
clc,clear,close all;
%% p4-1 loading x & y data
load DataFit.mat
%% p4-2
tic
min_error= inf;

a0= 0; w0= 0; phi0= 0;

for a=0.01:0.01:1
    for w=0:pi/10:10*pi
        for phi=0:pi/100:2*pi
            error= sum((y-a*sin(w*x+phi)).^2);
            if error < min_error
            min_error= error;
            a0= a; w0= w; phi0= phi;
            end
        end
    end 
end
toc
disp(a0);
disp(w0);
disp(phi0);
%% p2-3
tic
min_error= inf;

a0= 0; w0= 0; phi0= 0;

for a=0.1:0.1:1
    for w=0:pi:10*pi
        for phi=0:pi/10:2*pi
            error= sum((y-a*sin(w*x+phi)).^2);
            if error < min_error
            min_error= error;
            a0= a; w0= w; phi0= phi;
            end
        end
    end 
end
toc
min_error= inf;
a0_range= max(a0-0.005,0.01):0.01:min(a0+0.005,1);
w0_range= max(w0-pi/20,0):pi/10:min(w0+pi/20,10*pi);
phi0_range= max(phi0-pi/200,0):pi/100:min(phi0-pi/200,2*pi)
a0= 0; w0= 0; phi0= 0;

for a=a0_range
    for w=w0_range
        for phi=phi0_range
            error= sum((y-a*sin(w*x+phi)).^2);
            if error < min_error
            min_error= error;
            a0= a; w0= w; phi0= phi;
            end
        end
    end 
end

disp(a0);
disp(w0);
disp(phi0);
%% p2-4
tic
mu= 0.000001;
tol= 0.00001;
z= [0.5;6;0.5];
z_new = [inf,inf,inf];
grad = [inf,inf,inf];
for i= 1:100000
    a= z(1); w= z(2); phi= z(3);
    grad= [-2*sum((y-a.*sin(w.*x+phi)).*sin(w.*x+phi));
        -2*sum((y-a.*sin(w.*x+phi)).*a.*x.*cos(w.*x+phi));
        -2*sum((y-a.*sin(w.*x+phi)).*a.*cos(w.*x+phi))];
    z_new= z-mu*grad;
    if norm(z_new-z) < tol || norm(grad) < tol
        break
    end
    z = z_new;
end
toc
disp(z);