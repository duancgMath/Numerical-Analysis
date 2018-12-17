
clear, clc
%% example 04
%% noise

%% Runge 
f = @(x) 1./(1+12*x.^2);
xx = linspace(-1,1,10000);
yy = f(xx);


% points set03: 25
% cubicspline
M0 = 0;
Mn = 0;
x4 = linspace(-1,1,15)';
y4 = f(x4);
yy4 = cubicSplineSimplySupported(x4, y4, xx, M0, Mn);
figure(3)
plot(xx,yy,'b:','LineWidth',2)
axis([-1.1 1.1 -2 2]) 
hold on
plot(x4,y4,'ko','LineWidth',1)
plot(xx,yy4,'r','LineWidth',1)
grid on

temp = yy4'-yy;
err = max(temp(2001:8000))























































