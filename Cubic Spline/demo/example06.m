
clear, clc
%% example 06
%% order

%% Runge 
f = @(x) 1./(1+12*x.^2);
xx = linspace(-1,1,10000);
yy = f(xx);

% cubicspline
for k = 1:100
h(k) = 0.001+0.001*k;
x4 = -1:h(k):1;
x4 = x4';
y4 = f(x4);
yy4 = cubicSplineSimplySupported(x4, y4, xx);
temp = yy4'-yy;
err1(k) = max(abs(temp(2000:8000)));
end

log_err1 = log(err1);
log_h = log(h);

p = polyfit(log_h,log_err1,1);
y = polyval(p,log_h);

figure(1)
plot(h,err1,'LineWidth',2)
grid on

figure(2)
plot(log_h,log_err1,'LineWidth',2)
hold on
plot(log_h,y,'r:','LineWidth',2.5);
grid on