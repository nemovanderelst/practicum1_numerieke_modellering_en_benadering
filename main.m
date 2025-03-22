m = 200; n = 40;

Q = orth(randn(m, n));

D = eye(n);
V = eye(n);
for i = 1:n
    D(i, i) = 2^(1-i);
    V(1, i) = 1;
end

A = Q*D*V;

[Qkl, Rkl] = klGS(A);
[Qmod, Rmod] = modGS(A);
[Qher, Rher] = herGS(A);

Dkl = zeros(1, n);
Dmod = zeros(1, n);
J = zeros(1, n);
for i = 1:n
    Dkl(i) = norm(Q(:, i) - Qkl(:, i));
    Dmod(i) = norm(Q(:, i) - Qmod(:, i));
    J(i) = i;
end

figure;
semilogy(J, Dkl, J, Dmod); xlabel('j'); ylabel(['||q_{j}^{alg} - q_{j}||_{2}']);
legend('klassiek', 'gewijzigd');