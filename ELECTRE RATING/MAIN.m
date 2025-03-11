% ELECTRE TRI rating

% load  data
% load demo
load data_f %(lambda=0.2)
% load data3
% load data5
% load data4
% load data6 %(lambda=0.5)
load data_normal_distribution
% load data_exp_smoothing
m=15;n=8; %方案与属性数量

% lambda = 0.5; %相当于共识参数，越大越难以达成
cor = zeros(m,n,7);
discor = zeros(m,n,7);
% L = zeros(3,5); %属性级别分类阈值
% L_s = cell(5,5); L_p = cell(5,5);%属性级别分类阈值
% mp = zeros(3,5); %否决条件
% mp_s = cell(5,5); mp_p = cell(5,5);%否决条件


% compute dynamic criteria weights
% tp = 0.5; %时间偏好参数，越小越偏好于现在
% T = 4;
% w1 = guro(tp,T); %maximum time entropy : time weights
% w = guro2(w1,data1,data2); %DEA with common weights
% p = senti_inte(w1.x,res); %概率语言
% result=cell(1,10000);
w_r = zeros(10000,8);
% for iter = 1 : 10000
%Compute concordance and disconcordance 
    for i = 1 : m
        for j = 1 : n
            for k = 1 : size(L,2)+1
                if  j <= 5 %属性值类型不同
                    if k > 5
                        if plts_score(final_s{i,j},final_p{i,j},L_s{j,k-1},L_p{j,k-1}) == 1 || plts_score(final_s{i,j},final_p{i,j},L_s{j,k-1},L_p{j,k-1}) == 3 
                            cor(i,j,k) = 0.5;
                        else
                            cor(i,j,k) = 0;
                        end                
                    else                        
                        if plts_score(final_s{i,j},final_p{i,j},L_s{j,k},L_p{j,k}) == 1 || plts_score(final_s{i,j},final_p{i,j},L_s{j,k},L_p{j,k}) == 3 
                            cor(i,j,k) = 1;
                        else
                            if k>1 && (plts_score(final_s{i,j},final_p{i,j},L_s{j,k-1},L_p{j,k-1}) == 1 ||plts_score(final_s{i,j},final_p{i,j},L_s{j,k-1},L_p{j,k-1}) == 3)
                                cor(i,j,k) = 0.5;
                            elseif k > 2 && plts_score(final_s{i,j},final_p{i,j},L_s{j,k-1},L_p{j,k-1}) == 2
                                cor(i,j,k) = 0;
                            end
                        end
                        if plts_score(final_s{i,j},final_p{i,j},mp_s{j,k},mp_p{j,k}) == 1 || plts_score(final_s{i,j},final_p{i,j},mp_s{j,k},mp_p{j,k}) == 3 %discondorce 计算
                            discor(i,j,k)= 0;
                        else
                            discor(i,j,k)= 1;
                        end
                    end
                else 
                    if k > 5
                        if n_ugc(i,j-5) >=  L(j-5,k-1)
                            cor(i,j,k) = 0.5;
                        else
                            cor(i,j,k) = 0;
                        end
                    else
                        if n_ugc(i,j-5) >=  L(j-5,k)
                            cor(i,j,k) = 1;
                        else
                            if k > 1 && (n_ugc(i,j-5) >=  L(j-5,k-1))
                                cor(i,j,k) = 0.5;
                            elseif  k > 2 && (n_ugc(i,j-5) <  L(j-5,k-1))
                                cor(i,j,k)= 0;
                            end
                        end
                        if n_ugc(i,j-5) >= mp(j-5,k)
                            discor(i,j,k) = 0;
                        else
                            discor(i,j,k) = 1;
                        end
                    end
                end
            end
        end
    end
%     cor1 = zeros(15,8,5);
%     discor1 = zeros(15,8,5);
%     p=[0.01,0.005,0.005,0.01,0.02,0.0224,0.02,0.0362];
% %     v =  [0.033,0.0167,0.0167,0.033,0.0833,0.1119,0.0999,0.181];
%     v =  [0.033,0.0167,0.0167,0.00001,10e-5,10e-5,10e-5,10e-5];
%     u = p+0.75*(v-p);
%     for i = 1 : 15
%         for j = 1 : 8
%             if j <= 5
%                 for k = 1 : 5
%                     cor1(i,j,k) = (p(j) - min(expect(L_s{j,k},L_p{j,k})-expect(final_s{i,j},final_p{i,j}),p(j)))/ (p(j) - min(expect(L_s{j,k},L_p{j,k})-expect(final_s{i,j},final_p{i,j}),0));
%                     discor1(i,j,k) = 1-((v(j) - min(expect(L_s{j,k},L_p{j,k})-expect(final_s{i,j},final_p{i,j}),v(j)))/ (v(j) - min(expect(L_s{j,k},L_p{j,k})-expect(final_s{i,j},final_p{i,j}),u(j))));
%                 end
%             else
%                 for k = 1 : 5
%                     cor1(i,j,k) = (p(j)-min((L(j-5,k) - n_ugc(i,j-5)),p(j)))/(p(j)-min((L(j-5,k) - n_ugc(i,j-5)),0));
%                     discor1(i,j,k) = 1-((v(j)-min((L(j-5,k) - n_ugc(i,j-5)),v(j)))/(v(j)-min((L(j-5,k) - n_ugc(i,j-5)),u(j))));
%                 end
%             end
%         end
%     end
%     discor(:,:,:)=0;
% 	result = electre(cor,discor,profile);
    r = rand(1,8);
    w2 = r/sum(r);
%     w2 = (result.x(3:end))';
    %Compute overall concordance
        o_con = zeros(size(L,2),m);
        for l = 1 : size(L,2)
            for i = 1 : m
                o_con(l,i) = sum((w2.*cor(i,:,l))'); 
            end
        end


        % Define the credibility of the outranking
        cre = zeros(size(L,2),m);
        for l = 1 : size(L,2)
            for i = 1 : m
                cre(l,i) = o_con(l,i).*(prod((1-discor(i,:,l))'))';
            end
        end

        re = zeros(2,m); %第一行为等级  %第二行为cre
        for i = 1 : m
            sa = find(cre(:,i)>=cl);
            re(1,i) = sa(end);
            re(2,i) = cre(sa(end),i);
        end


        data = [re(1,:)', re(2,:)'];
        [sortedData,rank] = sortrows(data, [-1,-2]);
        result1 = [sortedData,rank];
        re = re';
    
%     result{iter} = [sortedData,rank];
%     w_r(iter,:) = w2;
% end
% rank1 = zeros(15,5);
% for i = 1 : 10000
%     for j = 1 : 15
%         rank1(result{i}(j,3),result{i}(j,1)) = rank1(result{i}(j,3),result{i}(j,1))+1;
%     end
% end