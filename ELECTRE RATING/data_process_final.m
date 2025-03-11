clear;
load orginal_data

tp = 0.2; %时间偏好参数，越小越偏好于现在
T = 4;

% w1 = guro(tp,T); %maximum time entropy : time weights
% w1 = Nor_weight(T+1); %基于正态分布的时间权重确定方法
w1 = exp_smoothing(T+1,tp); %基于指数平滑的时间权重确定方法
% w3 = entropy_time(data); 
%评级融合
p_eff = cell(1,15);s_eff = cell(1,15);
p_att = cell(1,15);s_att = cell(1,15);

% w = flip(w1.x');
w=w1;
for i = 1 : 15
    reco1 = [];reco2=[];
    for r = 1 : 4
        p_eff{i}(r) = sum(w.*f_eff(5-r,(i-1)*5+1:5*i));
        if p_eff{i}(r) ~= 0
            s_eff{i} = [s_eff{i},r-2];
        else
            reco1 = [reco1,r];
        end
        p_att{i}(r) = sum(w.*f_att(5-r,(i-1)*5+1:5*i));
        if p_att{i}(r) ~= 0
            s_att{i} = [s_att{i},r-2];
        else
            reco2 = [reco2,r];
        end
    end
    p_att{i}(reco1) = [];
    p_att{i}(reco2) = [];
    p_eff{i} = p_eff{i}/sum(p_eff{i});
    p_att{i} = p_att{i}/sum(p_att{i});
end


%情感分析融合(d行为第一个时期的4个属性)
p_senti = cell(15,4);
s_senti = cell(15,4);
for i = 1 : 15
    for j = 1 : 4
        p_senti{i,j} = sum((w.*d((i-1)*5+1:5*i,j:4:20))');
        rec = [];
        for k = 1 : 5
            if p_senti{i,j}(k) ~= 0
                s_senti{i,j} = [s_senti{i,j},k-3];
            else
                rec = [rec,k];
            end
        end
        p_senti{i,j}(rec) = [];
        p_senti{i,j} = p_senti{i,j}/sum(p_senti{i,j});
    end
end

%属性c2和c3的融合
p_c23 = cell(15,2);
s_c23 = cell(15,2);
for i = 1 : 15
    [s_c23{i,1},p_c23{i,1}] = integrate_PTLS(s_att{i},p_att{i},s_senti{i,2},p_senti{i,2},2,2,2);
    [s_c23{i,2},p_c23{i,2}] = integrate_PTLS(s_eff{i},p_eff{i},s_senti{i,3},p_senti{i,3},2,2,2);
end

final_s = [s_senti(:,1),s_c23,s_senti(:,4),c5_s];
final_p = [p_senti(:,1),p_c23,p_senti(:,4),c5_p];





