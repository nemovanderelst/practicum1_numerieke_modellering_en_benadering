function M = build_M(t, x, k)
    n = length(t) - (k+1);
    r = length(x);
    M = zeros(r, n);

    for j = 1:r %per rij
        row = deBoor_Mrow(t, k, x(j));  % Orde = graad + 1
        M(j, :) = row;
    end
end

