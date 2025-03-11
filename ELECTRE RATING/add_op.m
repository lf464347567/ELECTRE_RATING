function s3 = add_op(s1,s2,tao,t,mu)
%% PTLS加法运算
w1 = 0.5;
w2 = 0.5;

y1 = f1(s1,tao,t,mu);
y2 = f1(s2,tao,t,mu);

y3 = w1*y1+ w2*y2;

alpha = w1*s1+w2*s2;

s3 = f2(y3,tao,t,mu,alpha);










