function [fs,rank] = aggregate(d,w)
%% 聚合决策矩阵并排序
m = size(d,1);
result1 = zeros(m,1);
result2 = zeros(m,1);
W1 = 0.5;
W2 = 0.5;
fi = 0.5;
% 归一化

n_d1 = l_normalize(d);%线性归一化
n_d = v_normalize(d);%向量归一化

for i = 1 : size(d,2)
    d(:,i) = n_d(:,i)./max(n_d(:,i));
    d1(:,i) = n_d1(:,i)./max(n_d1(:,i));
end

for i = 1 : m
    result1(i,1) = max(w.*(1-d1(i,:))); % un_compensatory model
    result2(i,1) = prod(d(i,:).^(w));  % incomplete compensatory model
end

[results1,rank1] = sort(result1,'ascend')
[results2,rank2] = sort(result2,'descend')

n_r1 = result1./sqrt(sum(result1.^2));
n_r2 = result2./sqrt(sum(result2.^2));

% rank1 = [6;11;3;2;9;14;4.5;4.5;8;11;11;7;14;14;1];

% FS = -W1*sqrt(fi*((n_r1./max(n_r1)).^2) + (1-fi)*(rank1/m).^2)  + W2*sqrt(fi*(n_r2./max(n_r2)).^2 + (1-fi)*((m-rank2+1)/m).^2);%聚合
Fs = zeros(1,15);
for i = 1 : m
    Fs(i) = -W1*sqrt(fi*((n_r1(i)./max(n_r1)).^2) + (1-fi)*((find(rank1==i)/m).^2))  + W2*sqrt(fi*(n_r2(i)./max(n_r2)).^2 + (1-fi)*((m-find(rank2==i)+1)/m).^2);%聚合
end
% [fs, rank] = sort(FS,'descend')%排序
[fs, rank] = sort(Fs,'descend')%排序
% rank = rank'; fs = fs';
end
 
        