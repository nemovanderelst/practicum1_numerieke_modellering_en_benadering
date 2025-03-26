%Figuur voor vraag 1.4
m = 200; n = 40;

Q = orth(randn(m, n));

D = zeros(n);
D(1:n, 1:n) = 2^(1-(1:n));

V = eye(n);
V(1, 1:n) = 1;

A = Q*D*V;

[Qkl, Rkl] = klGS(A);
[Qmod, Rmod] = modGS(A);

Dkl = zeros(1, n);
Dkl(1:n) = norm(Q(:, 1:n) - Qkl(:, 1:n));

Dmod = zeros(1, n);
Dmod(1:n) = norm(Q(:, 1:n) - Qmod(:, 1:n));

J = zeros(1, n);
J(1:n) = 1:n;

figure;
semilogy(J, Dkl, J, Dmod); xlabel('j'); ylabel(['||q_{j}^{alg} - q_{j}||_{2}']);
legend('klassiek', 'gewijzigd');

