%% ��ʼ��

clc;
clear;
close;

%% ���ݴ���

data = xlsread('./data.xlsx');
m = size(data, 1); % ��������
x = [ones(m, 1) log(data(:, 2 : 5))];
y = log(data(:, 6)); % �Ա���ȡ����
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
e1 = e_omega(omega, p, x, y, m); % �������
e2 = entropy(omega); % ��
fun = @(omega) e_omega(omega, p, x, y, m) + entropy(omega); % Ŀ�꺯��
[omega min] = fmincon(fun, 1/n * ones(1, n), [], [], ones(1, n), 1, zeros(1, n), ones(1, n)); % ���Ż�Ȩ��
omega
min

%% �������

function e = e_omega(omega, p, x, y, m)
    e = sum((y - sum(omega * p .* x, 2)).^2) / m;
end