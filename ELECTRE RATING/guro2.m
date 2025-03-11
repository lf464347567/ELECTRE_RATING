%common weight

function result = guro2(w1,data1,data2)
    theta = 0.5;
    fi = 0.5;
    M = 100;
    V = -100;
    len = length(w1);
    m = size(data1,1);
    d = size(data1,2);
    s = size(data2,2);
    n = s+d;
    
    x = zeros(m,s);    %cost type criteria
    for i = 1 : len
        x = x+w1(i)*(data2(:,:,i)); %计算加权平均值
    end
    cha = zeros(m,s,len);
    for i = 1 : len
        cha(:,:,i) = (data2(:,:,i)-x).^2;
    end
    sigma = sqrt((sum(cha,3)/len));
    
    y = zeros(m,d); %benefit type criteria
    for i = 1 : len
        y = y+w1(i)*(data1(:,:,i)); %计算加权平均值
    end
    cha2 = zeros(m,d,len);
    for i = 1 : len
        cha2(:,:,i) = (data1(:,:,i)-y).^2;
    end
    deta = sqrt((sum(cha2,3)/len));
    
    A1 = zeros(1,n);
    A2 = zeros(1,n);
    for i = 1 : n
        if i <= d
            A1(i) = sum((1/(1-theta))*(y(:,i)));
            A2(i) = sum(((1/(1-theta))^2) * (deta(:,i).^2));
        else
            A1(i) = sum((1/(1-fi))*(x(:,i-d)));
            A2(i) = sum((-(1/(fi-1))^2) * (sigma(:,i-d).^2));
        end
    end
     
    k = 0.01;
    A3 = zeros(m,n);
    A4 = zeros(m,n);
    sense3 = [];
    sense4=[];
    for i = 1 : m 
        for j = 1 : d
            A3(i,j) = y(i,j)+k*deta(i,j);
        end
        for j = d+1 : n
            A4(i,j) = x(i,j-d)-k*sigma(i,j-d);
        end
        sense3 = [sense3;'<'];
        sense4 = [sense4;'>'];
    end
    
    obj = zeros(1,n);
    Q1 = zeros(1,d);
    Q2 = zeros(1,s);
    for i = 1 : n
        if i<=d
            obj(i) = 1/(1-theta)*sum(y(:,i))/M;
            Q1(i) = -1/(1-theta)^2*sum(deta(:,i).^2)/V;
        else
            obj(i) = 1/(1-fi)*sum(x(:,i-d))/M;
            Q2(i-d) = sum((-(1/(fi-1))^2) * (sigma(:,i-d).^2))/V;
        end
    end
    
    model.quadcon(1).Qc = sparse(diag(A2));
    model.quadcon(1).q = zeros(n,1);
    model.quadcon(1).rhs = 0;
    model.quadcon(1).name = 'std_cone' ;
    model.quadcon(1).sense = '>';
    A = [A1;A3;A4];
    model.Q = sparse(diag([Q1,Q2]));
    model.A = sparse(A);
    model.obj = obj;
    model.rhs = [0,ones(1,2*m)];
    model.lb = zeros(1,n);
    model.sense = ['>';sense3;sense4];
    model.vtype = 'C';
    params.Nonconvex = 2;
    result = gurobi(model,params);
end
% 
