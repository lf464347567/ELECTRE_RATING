function [value,ranking] = todim(d,w)
%% lz-todim
alter = 15; %方案
cri = 8; %准则
w1 = w/max(w);
%% 计算dominance degree
domin = cell(1,4);
loss = cell(1,4);
dis = cell(1,4);
% for j = 1 : cri
%     for i = 1 : alter
%         for h = i + 1 : alter
%             dis{j}(i,h) = d(i,j)-d(h,j); %% 每个准则下不同方案的距离
%             dis{j}(h,i) = dis{j}(i,h);
%         end
%     end
% end
 
for j = 1: cri
    for i = 1 : alter
        for h = i+1 : alter
            if d(i,j) > d(h,j)
                domin{j}(i,h) = sqrt(w1(j)*(d(i,j) - d(h,j))/sum(w1));
                domin{j}(h,i) = (-1/1) * sqrt(sum(w1)*(d(i,j) - d(h,j))/w1(j));
            elseif d(i,j) == d(h,j)
                domin{j}(i,h) = 0;
                domin{j}(h,i) = 0;
            else
                if sum(w1)*(d(h,j) - d(i,j))/w1(j)<0
                    b=0
                end
                    
                domin{j}(i,h) = (-1/1) * sqrt(sum(w1)*(d(h,j) - d(i,j))/w1(j));
                domin{j}(h,i) = sqrt(w1(j)*(d(h,j) - d(i,j))/sum(w1));
            end
        end
    end
end

%根据准则权重聚合dominance degree

for j = 1 : cri
    if j == 1
        dg = w(j)*(domin{j});
    else
        dg = dg + w(j)*(domin{j});
    end
end

                    
% Calculate the comprehensive evaluation value ofeach alternative
cev = zeros(1,15);
cc = sum(dg');
for i = 1 : alter
    cev(i) = (cc(i)-min(cc))/(max(cc)-min(cc));
end
fds = cev;
[value,ranking] = sort(fds,'descend')
end
                    