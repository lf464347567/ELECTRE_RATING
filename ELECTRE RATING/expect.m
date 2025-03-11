function e = expect(s,p)
e = 0;
for i = 1 : length(s)
    e = e + fun(s(i))*p(i);
end