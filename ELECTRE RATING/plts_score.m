% 比较两个PLTS的大小(y=1,s1>s2;y=2,s1<s2;y=3,s1=s2)
function y = plts_score(s1,p1,s2,p2)
exc1 = expect(s1,p1);%期望计算
exc2 = expect(s2,p2);%期望计算
var1 = variance(s1,p1);%方差计算
var2 = variance(s2,p2);%方差计算
if exc1 > exc2
    y=1;
elseif exc1 == exc2
    if var1 > var2
        y=1;
    elseif var1 < var2
        y=2;
    else
        y=3;
    end
else
    y=2;
end
        
    
