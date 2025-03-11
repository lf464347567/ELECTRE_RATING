function y = f2(theta,tao,t,mu,alpha)
if alpha < 0
    y = -(log(t^tao-theta*(2*t^tao-2))/log(t));
else
    y = log((2*mu^tao-2)*theta-(mu^tao-2))/log(mu);
end