function [Q,R] = herGS(A)
    [m,n] = size(A);

    V = A;
    W = zeros(m, n);
    Q = zeros(m, n);
    R = zeros(n, n);
    S = zeros(m, n);

    for i=1:n
        R(1:(i-1), i) = Q(:,1:(i-1))'*A(:,i);
        V(:,i) = V(:,i) - Q(:,1:(i-1))*R(1:(i-1), i);

        W(:,i) = V(:,i);

        S(1:(i-1), i) = Q(:,1:(i-1))'*W(:,i);
        V(:,i) = V(:,i) - Q(:,1:(i-1))*S(1:(i-1), i);
        R(1:(i-1), i) = R(1:(i-1), i) + S(1:(i-1), i);

        R(i,i) = norm(V(:,i));
        Q(:,i) = V(:,i)/R(i,i);
    end
end

