function [value,final] = glds(d,w)

%% glds
num_a = 15;
num_c = 8;

%计算dominance flow
g = cell(1,num_c);
% s1 = zeros(1,4);

for i = 1 : num_c
    for j = 1 : num_a
        for k = 1 : num_a
            g{i}(j,k) = max(d(j,i)-d(k,i),0);
%             s1 = s1+(g{i}(j,k))^2;
        end
    end
end

%正则化
for i = 1 : num_c
    for j = 1 : num_a
%         df{i}(j,:) = g{i}(j,:)./sum(sum(g{i}));
        df{i} = g{i}./sum(sum(g{i}));
    end
end

%gained and lost 
gdf = zeros(num_c,num_a);
ldf = zeros(num_c,num_a);
for i = 1 : num_c
    gdf(i,:) = sum(df{i}');
    ldf(i,:) = max(df{i});
end


% net gained and lost 
ds = zeros(1,num_a);
ls = zeros(1,num_a);
for i = 1 : num_a
    ds(i) = sum(w.*gdf(:,i)');
    ls(i) = max(w.*gdf(:,i)');
end
%     nds(i) = ds/sqrt(sum(ds.^2));
%     nls(i) = ls/sqrt(sum(ls.^2));
%rank
[v1,r1] = sort(ds,'descend');
[v2,r2] = sort(ls);
fds = zeros(1,10);
for i = 1 : num_a
    fds(i) = ds(i)/((sum((ds).^2))^(1/2)) * (num_a-find(r1==i)+1)/(num_a*(num_a+1)/2)-ls(i)/((sum((ls).^2))^(1/2))*find(r2==i)/(num_a*(num_a+1)/2);
end
[value,final] = sort(fds,'descend')


end



