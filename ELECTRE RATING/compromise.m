function exp_d = compromise(d,p,quan)
%d概率语言术语决策矩阵m维的cell   %% 6个定性标准，3个定量标准
%根据准则类型选取最优值与最差值(n个准则) ,
n = length(d{1})+size(quan,2);
m = size(quan,1);
%% 设定最优最差值
% ex = zeros(15,6);
% va = zeros(15,6);
% for i = 1 : length(d)
%     for j = 1 : length(d{1})
%         ex(i,j) = expect(d{i}{j},p{i}{j});
%         va(i,j) = variance(d{i}{j},p{i}{j});
%     end
% end
% best = cell(1,9); best_p = cell(1,9);%最优值
% worst_p = cell(1,6);worst = cell(1,6);%最差值
% [~,index1] = min(ex);
% [~,index2] = max(ex);
% for i = 1:3
%     quan(:,i) = quan(:,i)./max(quan(:,i));
% end
% for i = 1 : 9
%     if i <= 6
%         best{i} = d{index2(i)}{i}; worst{i} = d{index1(i)}{i};
%         best_p{i} = p{index2(i)}{i}; worst_p{i} = p{index1(i)}{i};
%     else
%         best{i} = max(quan(:,i-6));
%         worst{i} = min(quan(:,i-6));
%     end
% end

best = zeros(1,n)+2;
worst = zeros(1,n)-2;
best(6:n) = max(quan(:,1:3));
worst(6:n) = min(quan(:,1:3));

a = 5; %定性标准个数
c = 0.5;%损失与收益权重
alpha = 0.4;
lamda = 0.5;
beta = 0.6;

%计算每个方案与最优最差的点的距离
dis_b = zeros(m,n);
dis_w = zeros(m,n);
exp_d = zeros(m,n);
for i = 1 : m
    for j = 1 : n
        if j<=a
%             dis_b(i,j) = dis(d{i}{j},p{i}{j},best{j},best_p{j});
%             dis_w(i,j) = dis(d{i}{j},p{i}{j},worst{j},worst_p{j});
            dis_b(i,j) = dis(d{i,j},p{i,j},best(j),1);
            dis_w(i,j) = dis(d{i,j},p{i,j},worst(j),1);
        else
%             dis_b(i,j) = best{j}-quan(i,j-6);
%             dis_w(i,j) = quan(i,j-6)-worst{j};
            dis_b(i,j) = best(j)-quan(i,j-5);
            dis_w(i,j) = quan(i,j-5)-worst(j);
        end
        exp_d(i,j) = c*(1-exp(-alpha*dis_b(i,j))) + (1-c)*(-lamda*(1-exp(beta*dis_w(i,j)))); %期望效用
    end
end


