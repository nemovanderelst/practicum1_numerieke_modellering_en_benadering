function [Q, R] = herGS(A)
    [m, n] = size(A);
    
    V = A;
    W = zeros(m, n);
    Q = zeros(m, n);
    R = zeros(n, n);
    S = zeros(m, n);


    for i = 1:n
        R(i, i) = norm(V(:, i));
        Q(:, i) = V(:, i) / R(i, i);
        R(i, i+1:n) = Q(:, i)'*A(:, i+1:n);
        V(:, i+1:n) = V(:, i+1:n) - Q(:, i)*R(i, i+1:n);
    
        W(:, i) = V(:, i);
        S(i, i+1:n) = Q(:, i)'*W(:, i+1:n);
        V(:, i+1:n) = V(:, i+1:n) - Q(:, i)*S(i, i+1:n);
        R(i, i+1:n) = R(i, i+1:n) + S(i, i+1:n);
    end
end

