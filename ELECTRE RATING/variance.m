function deta = variance(s,p)
deta = 0;
ex = expect(s,p);
for i = 1 : length(s)
    deta = deta + ((fun(s(i))-ex)^2)*p(i);
end
deta = deta^(1/2);
end