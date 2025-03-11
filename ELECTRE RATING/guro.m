%time weight

function result = guro(lambda, T)
    A1 = (T-(0:T))/T;
    A2 = ones(1,T+1);
    A = [A1;A2];
    x =  linspace (10e-5 , 1.0 , 10000);
    y = x.*log(x);
%     obj = 0;
    sense = ['=';'='];
    for i = 1 : T+1
        sense = [sense;'>'];
    end
    for i = 1 : T+1
        sense = [sense;'<'];
    end
    model.A = sparse(A);
    for i = 1 : T+1
        model.pwlobj(i).var = i;
        model.pwlobj(i).x = x;
        model.pwlobj(i).y = y;
    end
    model.obj = zeros(1,T+1);
    model.rhs = [lambda,1];
    model.lb = zeros(1,T+1);
    model.ub = ones(1,T+1);
    model.sense = '=';
    model.vtype = 'C';
    result = gurobi(model);
end
% 
