function N = bspline_basis_eval(k, t, x, num_basis)
    % Bereken alle B-spline basisfuncties van graad k op punt x
    N = zeros(1, num_basis);
    for i = 1:num_basis
        if (i + k + 1) <= length(t)  % indexcontrole
            N(i) = bspline_N(i, k, t, x);
        else
            N(i) = 0;
        end
    end
end
