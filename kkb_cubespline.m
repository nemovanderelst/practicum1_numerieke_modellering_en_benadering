function z = kkb_cubespline(t, x, b, xeval)
    k = 3;

    n = length(t) - k - 1;
    num_basis = n + k;

    M = zeros(length(x), num_basis);
    for j = 1:length(x)
        M(j, :) = bspline_basis_eval(k, t, x(j), num_basis);
    end

    c = M \ b(:);

    z = zeros(size(xeval));
    for j = 1:length(xeval)
        z(j) = de_boor_eval(k, t, c, xeval(j));
    end
end