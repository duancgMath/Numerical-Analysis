
function [ynew, polycoef] = cubicSplineClamped(x, y, xnew, m0, mn)
% Cubic Spline of 2D-points
% Clamped Boundary Condition
%

if nargin == 3
  m0 = 0;
  mn = 0;
end
% formulate input data
if size(x,1)<size(x,2), x = x'; end
if size(y,1)<size(y,2), y = y'; end
if size(xnew,1)<size(xnew,2), xnew = xnew'; end

%% linear equation

% tridiagonal matrix
n = length(x)-1;
x0 = x(1);
x = x(2:end);
% d -- diagonal
d = zeros(n-1,1);
d(1) = x(2)-x0;
d(2:end) = x(3:end)-x(1:end-2);
d = 2*d;
% u -- upper diagonal
u = zeros(n-2,1);
u(1) = x(1)-x0;
u(2:end) = x(2:end-2)-x(1:end-3);
% l -- lower diagonal 
l = x(3:end)-x(2:end-1);

% right hand items
y0 = y(1);
y = y(2:end);
temp = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1));

rh = zeros(n-1,1);
rh(2:end) = 3*((x(2:end-1)-x(1:end-2)).*temp(2:end)+(x(3:end)-x(2:end-1)).*temp(1:end-1));
rh(1) = 3*(x(1)-x0)*(y(2)-y(1))/(x(2)-x(1))+3*(x(2)-x(1))*(y(1)-y0)/(x(1)-x0)-(x(2)-x(1))*m0;
rh(end) = rh(end)-(x(end-1)-x(end-2))*mn;

%% Solve 

m = thomas(d,u,l,rh);

%% Interpolation polynomial

poly = zeros(n,4);
m = [m; mn];
poly(1,1) = (m0+m(1))/(x(1)-x0)^2+2*(y0-y(1))/(x(1)-x0)^3;
poly(2:end,1) = (m(1:end-1)+m(2:end))./((x(2:end)-x(1:end-1)).^2)...
  +2*(y(1:end-1)-y(2:end))./((x(2:end)-x(1:end-1)).^3);
poly(1,2) = 3*(y0-y(1))/(x(1)-x0)^2+(m0+2*m(1))/(x(1)-x0);
poly(2:end,2) = 3*(y(1:end-1)-y(2:end))./(x(2:end)-x(1:end-1)).^2+(m(1:end-1)+2*m(2:end))./(x(2:end)-x(1:end-1));
poly(:,3) = m;
poly(:,4) = y;

polycoef = poly;
%% get new value

l = length(xnew);
ynew = zeros(l,1);
for k = 1:l
  for i = 1:n
    if xnew(k) < x(i)
      ynew(k) = polyval(poly(i,:), (xnew(k)-x(i)));
      break
    end
  end
end
