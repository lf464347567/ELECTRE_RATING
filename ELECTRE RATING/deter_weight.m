function [w,w1] = deter_weight(d)
%d:决策矩阵
%% 初始权重确定（熵权法）
[rows,cols]=size(d); % 输入矩阵的大小,rows为对象个数，cols为指标个数
k=1/log(rows);        % 求k
f=zeros(rows,cols);   % 初始化fij
p = zeros(rows,cols);
% sumBycols=sum(d,1);   % 输入矩阵的每一列之和(结果为一个1*cols的行向量)
% 计算fij(归一化)
for i=1:rows
  for j=1:cols
      f(i,j)=(d(i,j)-min(d(:,j)))./(max(d(:,j))-min(d(:,j)));
  end
  p(i,:) = f(i,:)./sum(f(i,:));
end

lnfij=zeros(rows,cols); % 初始化lnfij
% 
% 计算lnfij
for i=1:rows
  for j=1:cols
      if f(i,j)==0
          lnfij(i,j)=0;
      else
          lnfij(i,j)=log(p(i,j));
      end
  end
end
e = zeros(1,cols);
for i = 1 : cols
    e(i) = -k*(sum(p(i,:).*lnfij(i,:)));
end
w1 = (1-e)/sum(1-e);    
% Hj=-k*(sum(p.*lnfij,1)); % 计算熵值Hj
% w1=(1-Hj)/(cols-sum(Hj));

%% 白化
d = d - sum(sum(d))/(size(d,1)*size(d,2));
cov_d = cov(d);%协方差
% SD = sqrt(diag(cov_d));
% R = cov_d./(SD*SD');
% cov_d = cov_d - sum(sum(cov_d))/(size(cov_d,1)*size(cov_d,2));
[coeff,latent,explained] = pcacov(cov_d); %基于协方差的PCA
P = coeff*((diag(latent))^(-1/2))*coeff'; 
w = w1*P;
% w = abs(w1*P);
w = w./sum(w);
end
