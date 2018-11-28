clear, clc

%% --------------- y = sin(x) ----------------------

% (x_k, y_k)
X = linspace(0,1,70);
Y = sin(X);
% x_new
x = linspace(0,1,1e+6);
% y_real
y_real = sin(x);
% y_new
tic
y_inter = fun_lagrangeInter(X,Y,x);
toc

% Visualization
figure
hold on
plot(x,y_real,'r','LineWidth', 4)
plot(x,y_inter,'b.','LineWidth', 1)
hold off
grid on

figure
hold on
xx = linspace(0,2*1e-4,1e+6);
yy = fun_lagrangeInter(X,Y,xx);
plot(xx, sin(xx), 'r','LineWidth', 4)
plot(xx, yy, 'b.','LineWidth', 1)
hold off
xlim([0 2*1e-4])
ylim([-100 100])
grid on


%% ---------- Functions --------------

% function y = fun_lagrangeInter(X, Y, x)
% n = length(X);
% w = zeros(n,1);
% up = 0;
% low = 0;
% for i = 1:n
%   w(i) = 1;
%   for j = 1:n
%     if j ~= i
%       w(i) = w(i)/(X(i)-X(j));
%     end
%   end
%   
%   up = up + w(i)*Y(i)./(x-X(i));
%   low = low + w(i)./(x-X(i));
% end
% y = up./low;
% end

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
