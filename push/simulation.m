%% ��ʼ��

clc;
clear;
close;

%% ���ݲ���

x = [ones(10, 1), rand(10, 4)];
y = 1 * x(:, 1) + 2 * x(:, 2) + 3 * x(:, 3) + 2 * x(:, 4) - 1 * x(:, 5) + normrnd(0, 1);
m = size(x, 1); % ��������
n = 2^(size(x, 2) - 1) - 1; % ģ������
p = zeros(n, size(x, 2)); % ģ�͵�ϵ��

%% ���Իع�

p(1, :) = [1 1 0 0 0] .* x \ y;
p(2, :) = [1 0 1 0 0] .* x \ y;
p(3, :) = [1 0 0 1 0] .* x \ y;
p(4, :) = [1 0 0 0 1] .* x \ y;
p(5, :) = [1 1 1 0 0] .* x \ y;
p(6, :) = [1 1 0 1 0] .* x \ y;
p(7, :) = [1 1 0 0 1] .* x \ y;
p(8, :) = [1 0 1 1 0] .* x \ y;
p(9, :) = [1 0 1 0 1] .* x \ y;
p(10, :) = [1 0 0 1 1] .* x \ y;
p(11, :) = [1 1 1 1 0] .* x \ y;
p(12, :) = [1 1 1 0 1] .* x \ y;
p(13, :) = [1 1 0 1 1] .* x \ y;
p(14, :) = [1 0 1 1 1] .* x \ y;
p(15, :) = [1 1 1 1 1] .* x \ y;

%% ģ��ƽ��

omega = 1/n * ones(1, n); % Ȩ��
e1 = e_omega(omega, p, x, y); % �������
e2 = entropy(omega); % ��
c = var(x, y) / log(m); % ����
fun = @(omega) e_omega(omega, p, x, y) + c * entropy(omega); % Ŀ�꺯��
omega = fmincon(fun, 1/n * ones(1, n), [], [], ones(1, n), 1, zeros(1, n), ones(1, n)); % ���Ż�Ȩ��
p_omega = omega * p
[omega * p e_pomega(p_omega, x, y)]

%% �������

function e = e_pomega(p_omega, x, y)
    m = size(x, 1);
    e = sum((y - sum(p_omega .* x, 2)).^2) / m;
end

%% ��Ȩ�صľ������

function e = e_omega(omega, p, x, y)
    m = size(x, 1);
    e = sum((y - sum(omega * p .* x, 2)).^2) / m;
end

%% ����

function d = var(x, y)
    m = size(x, 1);
    p = x \ y;
    d = sum((y - x * p).^2) / m;
end

%% ��

function y = entropy(omega)
    n = size(omega, 2);
    y = 0;
    for i = 1 : n
        if 0 < omega(i)
            y = y - omega(i) * log(omega(i));
        end
    end
end