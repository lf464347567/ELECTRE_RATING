function p = senti_inte(w,d)
y = zeros(75,4);
p = y;
for i = 1 : 15
    for j = 1 : 4
        y((i-1)*5+1:i*5,j) = sum((d((i-1)*5+1:i*5,j:4:20).*w')')';
    end
    p((i-1)*5+1:i*5,:) = y((i-1)*5+1:i*5,:)./sum(y((i-1)*5+1:i*5,:));
end
end