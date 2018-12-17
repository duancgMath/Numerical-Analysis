
clear, clc
%% example02

%% Runge 
f = @(x) 1./(1+12*x.^2);
xx = linspace(-1,1,100);
yy = f(xx);
figure(1)
plot(xx,yy)
axis([-1.1 1.1 -2 2]) 
grid on

% points set03: 25
% chebyshev
xtemp = linspace(0,pi,25)';
x3 = cos(xtemp);
y3 = f(x3);
yy3 = fun_lagrangeInter(x3, y3, xx);
figure(2)
plot(xx,yy,'b:','LineWidth',2)
axis([-1.1 1.1 -2 2]) 
hold on
plot(x3,y3,'ko','LineWidth',1)
plot(xx,yy3,'r','LineWidth',1)
grid on

% points set03: 25
% cubicspline
x4 = linspace(-1,1,25);
y4 = f(x4);
yy4 = cubicSplineSimplySupported(x4, y4, xx);
figure(3)
plot(xx,yy,'b:','LineWidth',2)
axis([-1.1 1.1 -2 2]) 
hold on
plot(x4,y4,'ko','LineWidth',1)
plot(xx,yy4,'r','LineWidth',1)
grid on


%% functions
function y = fun_lagrangeInter(X, Y, x)
n = length(X);
up = 0;
low = 0;
for i = 1:n
  w = 1;
  for j = 1:n
    if j ~= i
      w = w/(X(i)-X(j));
    end
  end
  up = up + w*Y(i)./(x-X(i));
  low = low + w./(x-X(i));
end
y = up./low;
end



























