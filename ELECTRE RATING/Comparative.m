%% 对比实验
load data_com
exp_d = compromise(final_s,final_p,n_ugc); %通过妥协函数构建指数期望效用决策矩阵

% [w,w1] = deter_weight(exp_d);%w1初始权重 w白化后的权重
w = [0.1652 	0.2540 	0.1663 	0.0852 	0.1282 	0.0500 	0.1002 	0.0510 ];
% [results,rank] = topsis(exp_d,w); %（方法1）
[results,rank] = glds(exp_d,w); %（方法4）
% [results,rank] = todim(exp_d,w); %（方法2）

% [results,rank] = aggregate(exp_d,w);    %聚合排序（方法3）