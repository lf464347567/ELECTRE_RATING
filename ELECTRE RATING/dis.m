function d = dis(a,pa,b,pb)
%计算两个概率语言术语集之间的距离(基于语言标度函数的广义距离测度)见概率语言多属性决策方法及应用42页
% d = zeros(1,length(a));
d1 = zeros(1,length(a));
[a,pa,b] = pro_adjust(a,pa,b,pb);%概率法调整PLTS
if pa(end) ==0
    b(length(a)) = 0;
end
lamda = 2;%2为欧式距离 1为汉明距离
for i = 1 : length(a)%准则%每个准则下的概率语言术语数量
    d1(i) = pa(i).*(abs(fun(a(i))-fun(b(i))))^(lamda);
end
d = (sum(d1))^(1/lamda);
    
