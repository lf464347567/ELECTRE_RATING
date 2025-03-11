function y = fun(x)
%语义标度函数
tao = 2; fi = 2;
if x <= 0 
    y = (fi^tao-fi.^(-x))/(2*fi^tao-2);
else
    y = (fi^tao+fi.^(x)-2)/(2*fi^tao-2); 
end
