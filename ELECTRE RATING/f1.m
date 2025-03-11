function y = f1(s,tao,t,mu)
if s < 0
    y = (t^tao-t^(-s))/(2*t^tao-2);
else
    y = (mu^tao+mu^s-2)/(2*mu^tao-2);
end