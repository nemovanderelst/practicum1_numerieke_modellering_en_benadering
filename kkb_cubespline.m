function z = kkb_cubespline(t, x, b, xeval)
    % k = splinegraad (kubisch)
    k = 3;

    % Aantal B-splines = length(t) - k - 1
    n = length(t) - k - 1;
    num_basis = n + k;

    % Matrix M opbouwen (r x (n + k))
    M = zeros(length(x), num_basis);
    for j = 1:length(x)
        M(j, :) = bspline_basis_eval(k, t, x(j), num_basis);
    end

    % Los het stelsel M * c = b op in kleinste-kwadratenzin
    c = M \ b(:);

    % Bereken spline in punten xeval via algoritme van de Boor
    z = zeros(size(xeval));
    for j = 1:length(xeval)
        z(j) = de_boor_eval(k, t, c, xeval(j));
    end
end