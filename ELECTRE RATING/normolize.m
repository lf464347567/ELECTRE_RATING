% 向量归一化
n_ugc = zeros(15,5);
for i = 1 : 5
    n_ugc(:,i) = ugc(:,i)/sqrt(sum(ugc(:,i).^2));
end

% 线性归一化
n2_ugc= zeros(15,5);
for i = 1 : 5
    n2_ugc(:,i) = (ugc(:,i)-min(ugc(:,i)))/(max(ugc(:,i))-min(ugc(:,i)));
end
