function result = electre(cor,discor,p)

%决策变量 alpha,lambda,和w
kesai=0.0001;
%目标函数
len = size(cor,2)+2;
obj = zeros(1,len);
obj(1) = 1;
cri = 8;

%st1 
A1 = zeros(size(p,1),len);
A1(:,1:2) = 1;
sense1 = [];
for i = 1 : size(p,1)
    for j = 1 : cri 
%         if p(i,2) == 1
%             dis = 0;
%             co = 1;
%         else
%             dis = discor(p(i,1),j,p(i,2)-1);
%             co = cor(p(i,1),j,p(i,2)-1);
%         end
        dis = discor(p(i,1),j,p(i,2));
        co = cor(p(i,1),j,p(i,2));
        A1(i,2+j) = -co*(1-dis);
    end
    sense1 = [sense1,'<'];
end

%st2 
A2 = zeros(size(p,1),len);
A2(:,1) = 1;
A2(:,2) = -1;
sense2 = [];
for i = 1 : size(p,1)
    for j = 1 : cri 
%         if p(i,3) == 5
%             A2(i,2+j) = 0;
%         else
            A2(i,2+j) = cor(p(i,1),j,p(i,3)+1)*min((1-discor(p(i,1),:,p(i,3)+1)));        
%         end
    end
    sense2 = [sense2,'<'];
end


%st3
A3 = zeros(2,len);
A3(:,2)=1;
B3 = [0.5,1];

%st4
A4 = zeros(1+cri,len);
A4(1,3:len) = 1;
B4 = zeros(1,1+cri);
B4(1) = 1;
sense4=['='];
for i = 1 : cri
    A4(i+1,i+2) = 1;
%     if i == 1 || i == 2 || i==3
%         B4(i+1) = 0.125;
%     else
%         B4(i+1) = 0.05;
%     end
    B4(i+1) = 0;
    sense4=[sense4,'>'];
end

% A5 = zeros(1,len);
% A5(1,3) = 1;
% A5(1,4:end) = 01


A = [A1;A2;A3;A4];
model.A = sparse(A);
model.obj = obj;
model.rhs = [zeros(1,size(p,1)),zeros(1,size(p,1))+0.001,B3,B4];
%model.lb = [0,0.5,zeros(1,len)+kesai];
model.sense = [sense1,sense2,'>','<',sense4];
model.modelsense = 'Max';
% model.vtype = 'C';
result = gurobi(model);
w = result.x(3:end);
end