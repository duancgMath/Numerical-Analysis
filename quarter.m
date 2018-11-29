clear, clc
% Points from 1/4 circle
q = zeros(4,1);
for k = 0:3
  q(k+1) = exp(1i*pi*k/6);
end
qx = real(q);
qy = imag(q);

% Control points
[px, py] = fun_point2control(qx, qy);

% Bezier
X = []; Y = [];
for t = 0:0.01:1
  [x, y] = fun_deCast(px,py,t);
  Y = [Y, y];
  X = [X, x];
end

% check -- real circle
M = 1e+2;
c = zeros(M,1);
for k = 0:M-1
  c(k+1) = exp(1i*pi*k/(2*M-2));
end
cx = real(c);
cy = imag(c);

% Visualization
figure
hold on
plot(qx, qy, 'ro-')
plot(px, py, 'r*-')
plot(cx, cy, 'g:', 'LineWidth', 5)
plot(X, Y, 'b', 'LineWidth', 1.5)
hold off
grid on
axis equal
axis([0 1.1 0 1.1])
legend('Points from circle', 'Control points', 'Actual circle', 'Bezier')
%% ------------- Functions -----------------

function [px, py] = fun_point2control(qx, qy)
n = length(qx);
B = zeros(n);
for i = 0:n-1
  for j = 0:n-1
    B(i+1,j+1) = nchoosek(n-1,j)*i^j*(n-1-i)^(n-1-j)/(n-1)^(n-1);
  end
end
px = B\qx;
py = B\qy;
end

function [x, y] = fun_deCast(px,py,t)
N = length(px);
for k = 1:N-1
  px = fun_iter(px, t);
  py = fun_iter(py, t);
end
x = px;
y = py;
end

function v = fun_iter(v, t)
n = length(v);
v_forward = v(1:n-1);
v_backword = v(2:end);
v = (1-t)*v_forward+t*v_backword;
end

