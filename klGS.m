function [Q, R] = klGS(A)
    [m, n] = size(A);
    
    Q = zeros(m, n);
    R = zeros(n, n);
    V = A;

    for i=1:n
        R(1:(i-1),i) = Q(:,1:(i-1))'*A(:,i);
        V(:,i) = V(:,i) - Q(:,1:(i-1))*R(1:(i-1),i);

        R(i,i) = norm(V(:,i));
        Q(:,i) = V(:,i)/R(i,i);
    end
end