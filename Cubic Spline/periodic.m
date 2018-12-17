function x = periodic(b,c,a,d)
% b = diag  
% c = upper + A(end,1)
% a = lower + A(1,end)
% d = b
n = length(a);
x = zeros(n,1);

%% ��ֵ�ƽ��������ʺ� P240 ���γ�{q(k)}��{u(k)}
q = zeros(1,n+1);
p = q;
u = q;
for k = 2 : n+1
    p(k) = a(k-1)*q(k-1)+b(k-1);
    q(k) = -c(k-1)/p(k);
    u(k) = (d(k-1)-a(k-1)*u(k-1))/p(k);
end

% ��֤�������
% x(n) = u(n+1);
% for k = n-1 : -1 : 1
%     x(k) = q(k+1) * x(k+1) + u(k+1);
% end
    



%% ���γ�{t(k)}��{v(k)}
t = zeros(1,n+1);
s = t;
v = t;
s(1) = 1;
t(n+1) = 1;

for k = 2 : n+1
    s(k) = -(a(k-1)*s(k-1))/p(k);
end

for k = n : -1 : 2
    t(k) = q(k)*t(k+1) + s(k);
    v(k) = q(k)*v(k+1) + u(k);
end

%% ��{x(k)}
x(n) =(d(n)-c(n)*v(2)-a(n)*v(n))/(c(n)*t(2)+a(n)*t(n)+b(n));

for k = 1 : n-1
    x(k) = t(k+1)*x(n) + v(k+1);
end




 


