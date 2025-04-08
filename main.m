%Figuur voor vraag 1.4
clear;
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

figure;
semilogy(1:n, Dkl, 1:n, Dmod); xlabel('j'); ylabel('||q_{j}^{alg} - q_{j}||_{2}');
legend('klassiek', 'gewijzigd');

%Vraag 1.7
Qklorth = zeros(1, n);
Qmodorth = zeros(1, n);
for i=1:n
    Qklorth(i) = norm(eye(i, i) - Qkl(:, 1:i)'*Qkl(:, 1:i));
    Qmodorth(i) = norm(eye(i,i) - Qmod(:, 1:i)'*Qmod(:,1:i));
end

figure;
semilogy(1:n, Dkl, 1:n, Qklorth, 1:n, Dmod, 1:n, Qmodorth); xlabel('j'); ylabel('||q_{j}^{alg} - q_{j}||_{2}');
legend('klassiek', 'orthogonaliteit klassiek', 'gewijzigd', 'orthogonaliteit gewijzgid');
%%
% Vraag 1.8 en 1.9
clear;
m = 200; n = 50;

Qklorth = zeros(1,n);
Qmodorth = zeros(1,n);
Qherorth = zeros(1,n);

for k=1:n
    Q = orth(randn(m,n));
    V = orth(randn(n,n));
    D = diag(2.^linspace(0,k,n));
    A = Q*D*V;
    [Qkl, Rkl] = klGS(A);
    [Qmod, Rmod] = modGS(A);
    [Qher, Rher] = herGS(A);
    Qklorth(k) = norm(eye(n,n) - Qkl'*Qkl);
    Qmodorth(k) = norm(eye(n,n) - Qmod'*Qmod);
    Qherorth(k) = norm(eye(n,n) - Qher'*Qher);
end


figure;
semilogy(1:n, Qklorth, 'r-', 1:n, Qmodorth, 1:n, Qherorth); xlabel('k'); ylabel('fout op orthogonaliteit');
legend('klassiek', 'gewijzigd', 'herhaald');
%% 
% Stel je data voor:
t = [0 0 0 0 1 2 3 4 5 5 5 5];  % knooppuntenrij voor kubische spline
x = [0.5 1.5 2.5 3.5 4.5];      % meetpunten
b = [1 2 0 1 3];                % functiewaarden op x
xeval = linspace(0, 5, 100);    % evaluatiepunten

% Bereken spline
z = kkb_cubespline(t, x, b, xeval);

% Plot
plot(xeval, z, 'b-', x, b, 'ro')
legend('spline', 'meetpunten')


