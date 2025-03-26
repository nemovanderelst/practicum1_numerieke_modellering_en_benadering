function [Q, R] = klGS(A)
    [m, n] = size(A);
    
    Q = zeros(m, n);
    R = zeros(n, n);
    V = A;

    for i = 1:n
        R(i, i) = norm(V(:, i));
        Q(:, i) = V(:, i) / R(i, i);
        R(i, i+1:n) = Q(:, i)'*A(:, i+1:n);
        V(:, i+1:n) = V(:, i+1:n) - Q(:, i)*R(i, i+1:n);
    end
end