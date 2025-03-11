%PLTS标准化调整与相加
function [rs,prs] = integrate_PTLS(s1,p1,s2,p2,t,tao,mu)

[s1,p1,s2,p2] = pro_adjust(s1,p1,s2,p2); %调整概率
L= length(s1);
rs = zeros(1,L);
prs = zeros(1,L);
for i = 1 : L
    rs(i) = add_op(s1(i),s2(i),tao,t,mu);
    prs(i) = p1(i);
end
end
    
    
    
