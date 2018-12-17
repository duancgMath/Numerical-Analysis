
function [ynew, polycoef] = cubicSplinePeriod(x, y, xnew)
% Cubic Spline of 2D-points
% Periodic Boundary Condition
%

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
d = [d; x(n)-x(n-1)+x(1)-x0];
d = 2*d;
% u -- upper diagonal
u = x(2:end-1)-x(1:end-2);
u = [u; x(end)-x(end-1)];
% l -- lower diagonal -- l == u

% right hand items
y0 = y(1);
y = y(2:end);
temp = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1));
temp = [(y(1)-y0)/(x(1)-x0); temp];

rh = 6*(temp(2:end)-temp(1:end-1));
rh = [rh; (y(1)-y0)/(x(1)-x0)-(y(end)-y(end-1))/(x(end)-x(end-1))];

%% Solve 
% A = diag(d)+diag(u,1)+diag(u,-1);
% A(end,1) = x(1)-x0;
% A(1,end) = x(1)-x0;
% b = rh;
% M = A\b;

M = periodic(d,[u;x(1)-x0],[u;x(1)-x0],rh);

%% Interpolation polynomial

poly = zeros(n,4);
poly(1,1) = (1/6)*(M(1)-M(end))./(x(1)-x0);
poly(2:end,1) = (1/6)*(M(2:end)-M(1:end-1))./(x(2:end)-x(1:end-1));
poly(:,2) = (1/2)*M;
poly(1,3) = (y(1)-y0)/(x(1)-x0)+(x(1)-x0)*(2*M(1)+M(end))/6;
poly(2:end,3) = (y(2:end)-y(1:end-1))./(x(2:end)-...
  x(1:end-1))+(x(2:end)-x(1:end-1)).*(2*M(2:end)+M(1:end-1))/6;
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
