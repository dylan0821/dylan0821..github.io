%% ��ʼ��

clc;
clear;
close;

%% ������Ԥ����

r = [0 3 3 5 7 5; 
    3 0 5 5 5 13; 
    3 5 0 3 3 5
    5 5 3 0 7 7
    7 5 3 7 0 7
    5 13 5 7 7 0]; % ����
n = size(r, 1); % ������
r = (r - 3) ./ (19 - 3); % ��׼��
for i = 1 : n
    r(i, i) = 1; % �Խ�����Ϊ1
end

%% ƽ�����ϳɴ��ݱհ�

newr = zeros(n, n);
for k = 1 : log2(n) + 1 % ������Ҫ����log2(n) + 1��
    for i = 1 : n
        for j = 1 : n
            newr(i, j) = max(min(r(i, :), r(:, j)')); % ģ����ϵ����ĳ˷�
        end
    end
    r = newr; % ���¹�ϵ����
end

%% ��lambda-�ؾ���

list = unique(sort(r)); % ��ͬ��lambda��ȡֵ
lambda = list(2); % ���Ե���lambdaֵ
R = zeros(n, n);
for i = 1 : n
    for j = 1 : n
        if r(i, j) >= lambda
            R(i, j) = 1;
        else
            R(i, j) = 0;
        end
    end
end

%% �������Ͻ������
    
g = graph(R, 'omitselfloops');
plot(g);