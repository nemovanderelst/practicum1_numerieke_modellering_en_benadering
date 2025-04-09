function s = de_boor_eval(k, t, c, x)
    % Vind index i zodat t(i) <= x < t(i+1)
    i = find(t <= x, 1, 'last') - 1;
    if i < k
        i = k;
    elseif i > length(t) - k - 1
        i = length(t) - k - 1;
    end

    % Initialisatie van de de Boor coëfficiënten
    d = c(i-k+1:i+1);

    % Iteratief berekenen
    for r = 1:k
        for j = k:-1:r
            idx = i - k + j;
            alpha = (x - t(idx+1)) / (t(idx+k+1-r+1) - t(idx+1));
            d(j+1) = (1 - alpha) * d(j) + alpha * d(j+1);
        end
    end

    s = d(k+1);
end
