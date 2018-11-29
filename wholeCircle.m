clear, clc
% Points from 4 * 1/4 circle
R = 1;

q1 = zeros(4,1);
for k = 0:3
  q1(k+1) = R * exp(1i*pi*k/6);
end
qx1 = real(q1);
qy1 = imag(q1);

q2 = zeros(4,1);
for k = 0:3
  q2(k+1) = R * exp(1i*pi/2 + 1i*pi*k/6);
end
qx2 = real(q2);
qy2 = imag(q2);

q3 = zeros(4,1);
for k = 0:3
  q3(k+1) = R * exp(1i*pi + 1i*pi*k/6);
end
qx3 = real(q3);
qy3 = imag(q3);

q4 = zeros(4,1);
for k = 0:3
  q4(k+1) = R * exp(1i*3*pi/2 + 1i*pi*k/6);
end
qx4 = real(q4);
qy4 = imag(q4);

qx = [qx1,qx2,qx3,qx4];
qy = [qy1,qy2,qy3,qy4];

% Control points
[px1, py1] = fun_point2control(qx1, qy1);
[px2, py2] = fun_point2control(qx2, qy2);
[px3, py3] = fun_point2control(qx3, qy3);
[px4, py4] = fun_point2control(qx4, qy4);

px = [px1,px2,px3,px4];
py = [py1,py2,py3,py4];

% Bezier
X1 = []; Y1 = [];
X2 = []; Y2 = [];
X3 = []; Y3 = [];
X4 = []; Y4 = [];
for t = 0:0.01:1
  [x1, y1] = fun_deCast(px1,py1,t);
  [x2, y2] = fun_deCast(px2,py2,t);
  [x3, y3] = fun_deCast(px3,py3,t);
  [x4, y4] = fun_deCast(px4,py4,t);
  Y1 = [Y1, y1]; X1 = [X1, x1];
  Y2 = [Y2, y2]; X2 = [X2, x2];
  Y3 = [Y3, y3]; X3 = [X3, x3];
  Y4 = [Y4, y4]; X4 = [X4, x4];
end

X = [X1,X2,X3,X4];
Y = [Y1,Y2,Y3,Y4];

% check -- real circle
M = 1e+3;
c = zeros(M,1);
for k = 0:M-1
  c(k+1) = R * exp(1i*2*pi*k/(M-1));
end
cx = real(c);
cy = imag(c);

% Visualization
figure
hold on
plot(qx1, qy1, 'ro-')
plot(px1, py1, 'r*-')
plot(cx, cy, 'g:', 'LineWidth', 4)
plot(X1, Y1, 'b', 'LineWidth', 1.5)
plot(qx, qy, 'ro-')
plot(px, py, 'r*-')
plot(X, Y, 'b', 'LineWidth', 1.5)
plot([-1.2*R 1.2*R],[0 0],'k',[0 0],[-1.2*R 1.2*R],'k')
hold off
grid on
axis equal
axis([-1.2*R 1.2*R -1.2*R 1.2*R])
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

