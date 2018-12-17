
clear, clc
%% test

%% Runge 
f = @(x) 1./(1+12*x.^2);
xx = linspace(-1,1,100);
yy = f(xx);
figure(1)
plot(xx,yy)
axis([-1.1 1.1 -2 2]) 
grid on
% points set01: 5
x1 = linspace(-1,1,5);
y1 = f(x1);
yy1 = fun_lagrangeInter(x1, y1, xx);
figure(2)
plot(xx,yy,'b:','LineWidth',2)
axis([-1.1 1.1 -2 2]) 
hold on
plot(x1,y1,'ko','LineWidth',1)
plot(xx,yy1,'r','LineWidth',1)
grid on
% points set02: 15
x2 = linspace(-1,1,15);
y2 = f(x2);
yy2 = fun_lagrangeInter(x2, y2, xx);
figure(3)
plot(xx,yy,'b:','LineWidth',2)
axis([-1.1 1.1 -2 2]) 
hold on
plot(x2,y2,'ko','LineWidth',1)
plot(xx,yy2,'r','LineWidth',1)
grid on
% points set03: 25
x3 = linspace(-1,1,25);
y3 = f(x3);
yy3 = fun_lagrangeInter(x3, y3, xx);
figure(4)
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
