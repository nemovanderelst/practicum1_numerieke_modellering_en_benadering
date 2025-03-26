%Figuur voor vraag 1.4
m = 200; n = 40;

Q = orth(randn(m, n));

D = diag(2.^(1-(1:n)));

V = eye(n);
V(1, 1:n) = 1;

A = Q*D*V;

[Qkl, Rkl] = klGS(A);
[Qmod, Rmod] = modGS(A);


Dkl = vecnorm(Q-Qkl, 2, 1);

Dmod(1:n) = vecnorm(Q - Qmod, 2, 1);

J = zeros(1, n);
J(1:n) = 1:n;

figure;
semilogy(J, Dkl, J, Dmod); xlabel('j'); ylabel('||q_{j}^{alg} - q_{j}||_{2}');
legend('klassiek', 'gewijzigd');

