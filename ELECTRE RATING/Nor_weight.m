function normalizedWeights = Nor_weight(H)
% 基于正态分布生成时间序列权重
% 输入参数：H - 时间周期数（如5年、4季度等）
% 输出参数：normalizedWeights - 归一化后的权重数组（1×H）

    % 1. 计算均值μ_H
    mu_H = (1 + H) / 2;

    % 2. 生成时间点集合k = [1, 2, ..., H]
    k = 1:H;

    % 3. 计算标准差σ_H（公式20）
    variance = sum((k - mu_H).^2) / H;
    sigma_H = sqrt(variance);

    % 4. 计算未归一化的权重（公式18）
    rawWeights = (1 / (sigma_H * sqrt(2*pi))) * ...
                 exp(-(k - mu_H).^2 / (2 * sigma_H^2));

    % 5. 归一化权重（公式21）
    normalizedWeights = rawWeights / sum(rawWeights);
end

% % ------------------- 示例与验证 -------------------
% % 示例1：H=5（奇数，最大值在中间）
% H_odd = 5;
% weights_odd = generateTimeWeights(H_odd);
% fprintf('H=%d时权重分布：\n', H_odd);
% disp(round(weights_odd, 4));
% [~, max_pos] = max(weights_odd);
% fprintf('最大值位置：k=%d\n\n', max_pos);
% 
% % 示例2：H=4（偶数，最大值在中间两个位置）
% H_even = 4;
% weights_even = generateTimeWeights(H_even);
% fprintf('H=%d时权重分布：\n', H_even);
% disp(round(weights_even, 4));
% max_vals = find(weights_even == max(weights_even));
% fprintf('最大值位置：k=%d 和 k=%d\n', max_vals(1), max_vals(2));