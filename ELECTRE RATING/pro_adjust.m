function [a,pa,b,pb] = pro_adjust(a1,pa1,b1,pb1)
%% 基于概率法调整PLTS
% pa1 = round(pa1*10000);pb1 = round(pb1*10000);
pa1 = round(pa1,4);
pb1 = round(pb1,4);
if sum(round(pa1,4))~=1 
    pa1(end) = pa1(end) + 1-sum(pa1);
end
if sum(round(pb1,4))~=1
    pb1(end) = pb1(end) + 1-sum(pb1);
end
if length(pa1) == length(pb1) 
    if sum(round(pa1,4) == round(pb1,4)) < max(length(pa1),length(pb1))
        c = 1; dem = 0;
        while round(dem,4) < 1
            if round(pa1(c),4) < round(pb1(c),4)
                b1 = [b1(1:c),b1(c),b1(c+1:end)];
                pb1=[pa1(1:c),pb1(c)-pa1(c),pb1(c+1:end)];
                dem = dem + pb1(c);
                c = c + 1;
            elseif round(pa1(c),4) > round(pb1(c),4)
                a1 = [a1(1:c),a1(c),a1(c+1:end)];
                pa1=[pb1(1:c),pa1(c)-pb1(c),pa1(c+1:end)];
                dem = dem + pa1(c);
                c = c + 1;
            else
                dem = dem + pa1(c);
                c = c + 1;
            end
        end
    end
else
    c = 1; dem = 0;
    while round(dem,4) < 1
        if round(pa1(c),4) < round(pb1(c),4)
            b1 = [b1(1:c),b1(c),b1(c+1:end)];
            pb1=[pa1(1:c),pb1(c)-pa1(c),pb1(c+1:end)];
            dem = dem + pb1(c);
            c = c + 1;
        elseif round(pa1(c),4) > round(pb1(c),4)
            a1 = [a1(1:c),a1(c),a1(c+1:end)];
            pa1=[pb1(1:c),pa1(c)-pb1(c),pa1(c+1:end)];
            dem = dem + pa1(c);
            c = c + 1;
        else
            dem = dem + pa1(c);
            c = c + 1;
        end
    end
end
if sum(pb1(1:end-1)) == 1
    pb1 = pb1(1:end-1);
    b1 = b1(1:end-1);
end
if sum(pa1(1:end-1)) == 1
    pa1 = pa1(1:end-1);
    a1 = a1(1:end-1);
end
a = a1; b = b1; pa = pa1; pb = pb1;
end


