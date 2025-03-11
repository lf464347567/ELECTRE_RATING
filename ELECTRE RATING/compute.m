%杂乱的中间计算
for i = 1 : 3
    for j = 1 : 5
        part = (max(n_ugc(:,i))-min(n_ugc(:,i)))/5;
        mp(i,j) = min(n_ugc(:,i))+j*part;
    end
end


    for i = 1 : 15
        for j = 1 : 5
            x(i,j) = plts_score(final_s{i,j},final_p{i,j},[0,1],[0.3,0.7]);
        end
    end
    
    
    
    for i = 1 : 3
        for j = 1 : 4
            mp(i,j) = (L(i,j)+L(i,j+1))/2;
        end
    end