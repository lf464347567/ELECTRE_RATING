function d = v_normalize(x)
d = x;
for i = 1 : size(x,2)
    if i == 7 %cost类型 
        d(:,i) = 1 - d(:,i)./sqrt(sum(d(:,i).^2));
    else
        d(:,i) = d(:,i)./sqrt(sum(d(:,i).^2));
    end
end