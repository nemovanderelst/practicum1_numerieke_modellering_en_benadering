function [Q, R] = modGS(A)
    [m, n] = size(A);
    assert(m >= n);

    V = A;
    Q = eye(m, n);
    R = eye(n, n);

    for j = 1:n
        for i = 1:(j-1)
            R(i, j) = Q(:, i)'*V(:, j);
            V(:, j) = V(:, j) - R(i, j)*Q(:, i);
        end
        R(j, j) = sqrt(V(:, j)'*V(:, j));
        Q(:, j) = V(:, j) / R(j, j);
    end
end