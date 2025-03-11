% plts_s= cell(15,4);
plts_p= cell(15,4);
for i =1 : 15
    for j = 1 : 4
        a = pro_1to4((i-1)*5+1:5*i,j) ~= 0;
        if sum(a)==5
%             plts_s= [-2,-1,0,1,2];
            plts_p{i,j} = pro_1to4((i-1)*5+1:5*i,j);
        else
            index = find(a==0);
            b = pro_1to4((i-1)*5+1:5*i,j);
            b(index) = [];
            plts_p{i,j} = b;
%             c = [-2,-1,0,1,2];
%             c(index) = [];
%             plts_s{i,j} = c;
        end
    end
end

plts_s13 = cell(15,2);
plts_p13 = cell(15,2);
for i =1 : 15
    a = att(:,i) ~= 0;
    e = eff(:,i) ~= 0;
    if sum(a)==5
        s = [-1,0,1,2];
        plts_s13{i,1} = s;
        plts_p13{i,1} = att(:,i)';
    else
        index = find(a==0);
        b = att(:,i)';
        b(index) = [];
        plts_p13{i,1} = b;
        c = [-1,0,1,2];
        c(index) = [];
        plts_s13{i,1} = c;
    end
    if sum(e) == 5
        s = [-1,0,1,2];
        plts_s13{i,2} = s;   
        plts_p13{i,2} = eff(:,i)';
    else
        index = find(e==0);
        b = eff(:,i)';
        b(index) = [];
        plts_p13{i,2} = b;
        c = [-1,0,1,2];
        c(index) = [];
        plts_s13{i,2} = c;
    end
end
