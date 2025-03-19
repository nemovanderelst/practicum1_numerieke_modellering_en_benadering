function [Q, R] = herGS(A)
    [m, n] = size(A);
    assert(m >= n);
    
    V = A;
    W = eye(m, n);
    Q = eye(m, n);
    R = eye(n, n);
    S = eye(m, n);
    
    for j = 1:n
        for i = 1:(j-1)
            R(i, j) = Q(:, i)'*A(:, j);
            V(:, j) = V(:, j) - R(i, j)*Q(:, i);
        end    
        
        W(:, j) = V(:, j);
        for i = 1:(j-1)
            S(i, j) = Q(:, i)'*W(:, j);
            V(:, j) = V(:, j) - S(i, j)*Q(:, i);
            R(i, j) = R(i, j) + S(i, j);
        end
        R(j, j) = sqrt(V(:, j)'*V(:, j));
        Q(:, j) = V(:, j) / R(j, j);
    end
end