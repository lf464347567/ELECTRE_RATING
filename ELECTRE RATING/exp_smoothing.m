function weights = exp_smoothing(T, lambda)
    % 生成时间衰减权重（指数型）
    t = 1:T;
    raw_weights = exp(-lambda * (T - t));
    weights = raw_weights / sum(raw_weights);
end
