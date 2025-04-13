function s = de_boor_eval(k, t, c, x)
    i = find(t <= x, 1, 'last') - 1;
    if i < k
        i = k;
    elseif i > length(t) - k - 1
        i = length(t) - k - 1;
    end

    D = zeros(k+1, k+1);
    D(:, 1) = c(i-k+1:i+1);

    for r = 1:k
        for j = k:-1:r
            idx = i - k + j + 1;
            denom = t(idx+k+1-r) - t(idx);
            if denom ~= 0
                alpha = (x - t(idx)) / (denom);
            else
                alpha = 0;
            end
            D(j+1,r+1) = (1 - alpha) * D(j,r) + alpha * D(j+1, r);
        end
    end

    s = D(k+1, k+1);
end
