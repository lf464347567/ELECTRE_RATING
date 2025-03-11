function d = l_normalize(x)
d = x;
for i = 1 : size(x,2)
    d(:,i) = (d(:,i)-min(d(:,i)))./(max(d(:,i))-min(d(:,i)));
end