function [value,index] = topsis(d,w)

%% plts-topsis

alter = 15; %方案
cri = 8; %准则
%% 计算权重
% BO = zeros(ex,cri);
% OW = zeros(ex,cri);
% for k = 1 : 4
%     for i = 1 : 9
%         BO(k,i) = distance(f4(pl(k,i),2),f1(ps(k,i),2),f4(0,2),f1(4,2)); 
%         OW(k,i) = distance(f4(wpl(k,i),2),f1(wps(k,i),2),f4(0,2),f1(4,2)); 
%     end
% end
% [w1,bwm,w3,CC1] = CC(ex,cri,alter,l,s); %相关系数
% wr = w1./max(w1')';

%% 
y = zeros(alter,cri); 
z = zeros(alter,cri); 
best = max(d);
worst = min(d);
for i = 1 : alter
    for j = 1 : cri
        y(i,j) = abs(d(i,j)-best(j));
        z(i,j) = abs(d(i,j)-worst(j));
    end
end

q1 = zeros(1,alter);
q2 = zeros(1,alter);
for i = 1 : alter
    q1(i) = sum(w.*y(i,:));
    q2(i) = sum(w.*z(i,:));
end
% for k = 1 : alter
%     q3(k) = we*q1(:,k);
%     q4(k) = we*q2(:,k);
% end

R = q2./max(q2) - q1./min(q1);
[value, index]= sort(R,'descend')
end
    
    
    