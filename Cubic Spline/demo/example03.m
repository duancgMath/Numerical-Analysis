
clear, clc
%% example03

%% Runge 
f = @(x) sin(x);
xx = linspace(-1,-0.95,10000);
yy = f(xx);
figure(1)
plot(xx,yy)
axis([-1.1 1.1 -2 2]) 
grid on

% points set04: 60
% chebyshev
xtemp = linspace(0,pi,25)';
x3 = cos(xtemp);
y3 = f(x3);
yy3 = fun_lagrangeInter(x3, y3, xx);
figure(2)
plot(xx,yy,'b:','LineWidth',2)
axis([-1 -0.97 -1 -0.7]) 
hold on
% plot(x3,y3,'ko','LineWidth',1)
plot(xx,yy3,'r','LineWidth',1)
grid on

% points set03: 60
% cubicspline
x4 = linspace(-1,1,25);
y4 = f(x4);
yy4 = cubicSplineSimplySupported(x4, y4, xx);
figure(3)
plot(xx,yy,'b:','LineWidth',2)
axis([-1 -0.97 -1 -0.7]) 
hold on
% plot(x4,y4,'ko','LineWidth',1)
plot(xx,yy4,'r','LineWidth',1)
grid on


% points set01: 25
x1 = linspace(-1,1,60);
y1 = f(x1);
yy1 = fun_lagrangeInter(x1, y1, xx);
figure(4)
plot(xx,yy,'b:','LineWidth',2)
axis([-1 -0.97 -1 -0.7]) 
hold on
% plot(x1,y1,'ko','LineWidth',1)
plot(xx,yy1,'r','LineWidth',1)
grid on

% points set03: 25
xx = linspace(-1,1,10000);
yy = f(xx);
x3 = linspace(-1,1,60);
y3 = f(x3);
yy3 = fun_lagrangeInter(x3, y3, xx);
figure(5)
plot(xx,yy,'b:','LineWidth',2)
axis([-1.1 1.1 -2 2]) 
hold on
plot(x3,y3,'ko','LineWidth',1)
plot(xx,yy3,'r','LineWidth',1)
grid on
% visualization


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



























