
clear, clc

% Control Point
xc = [1,1,2,1;
      4,4,4,4;
      7,6,7,8;
      10,9,10,9];
yc = [1,3,6,9;
      0,3,6,10;
      0,3,6,9;
      1,4,7,10];
zc = [3,5,5,2;
      4,6,7,4;
      4,7,6,5;
      2,4,5,4];

% 
N = 100;
u = linspace(0,1,N);
v = linspace(0,1,N);
X = zeros(N,N);
Y = zeros(N,N);
Z = zeros(N,N);
for i = 1:N
  for j = 1:N
    X(i,j) = fun_deCast3(xc, u(i), v(j));
    Y(i,j) = fun_deCast3(yc, u(i), v(j));
    Z(i,j) = fun_deCast3(zc, u(i), v(j));
  end
end

% Visualizaton
figure
Cm = ones(4,4);
mesh(xc,yc,zc,Cm,'LineWidth',2);
hidden;
hold on;
Cs = gradient(Z);
surf(X,Y,Z,Cs);
% plot3(X,Y,Z,'m.');

%% ------------- Functions -------------------

function result = fun_deCast3(A, u, v)
n = size(A, 1);
for k = 1:n-1
  for i = 1:n-k
    for j = 1:n-k
      A(i,j) = fun_iter(A(i:i+1,j:j+1),u,v);
    end
  end
end
result = A(1,1);
end

function Val = fun_iter(A, u, v)
Val = (1-u)*(1-v)*A(1,1)+(1-u)*v*A(1,2)+u*(1-v)*A(2,1)+u*v*A(2,2);
end
