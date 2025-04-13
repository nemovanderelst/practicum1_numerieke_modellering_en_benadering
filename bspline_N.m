function val = bspline_N(i, k, t, x)
    % basisgeval
    if k == 0
        if t(i) <= x && x < t(i+1)
            val = 1;
        else
            val = 0;
        end
    else
        denom1 = t(i+k) - t(i);
        denom2 = t(i+k+1) - t(i+1);

        term1 = 0;
        term2 = 0;

        if denom1 ~= 0
            term1 = (x - t(i)) / denom1 * bspline_N(i, k-1, t, x);
        end
        if denom2 ~= 0
            term2 = (t(i+k+1) - x) / denom2 * bspline_N(i+1, k-1, t, x);
        end

        val = term1 + term2;
    end
end
