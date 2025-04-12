%Figuur voor vraag 1.4 en 1.7
clear;

%Stel matrices Q, D, V en A op.
m = 200; n = 40;

Q = orth(randn(m, n));
D = diag(2.^(1-(1:n)));
V = eye(n); V(1, 1:n) = 1;
A = Q*D*V;

%Voer klassiek en gewijzigd Gramm-Schmidt-algoritme uit en bereken de fout
[Qkl, ~] = klGS(A);
[Qmod, ~] = modGS(A);

Dkl = vecnorm(Q-Qkl, 2, 1);
Dmod = vecnorm(Q - Qmod, 2, 1);

%plot voor vraag 1.4
figure;
semilogy(1:n, Dkl, 'r', 1:n, Dmod, 'g', 'LineWidth', 1); xlabel('j'); ylabel('||q_{j}^{alg} - q_{j}||_{2}');
legend('klassiek', 'gewijzigd');

%Vraag 1.7
%Bereken fout in orthogonaliteit
Qklorth = zeros(1, n);
Qmodorth = zeros(1, n);
for i=1:n
    Qklorth(i) = norm(eye(i, i) - Qkl(:, 1:i)'*Qkl(:, 1:i));
    Qmodorth(i) = norm(eye(i,i) - Qmod(:, 1:i)'*Qmod(:,1:i));
end

%Plot fout in orthogonaliteit erbij
figure;
semilogy(1:n, Dkl, 'r', 1:n, Qklorth, '--r', 1:n, Dmod, 'g', 1:n, Qmodorth, '--g', 'LineWidth', 1); xlabel('j'); ylabel('||q_{j}^{alg} - q_{j}||_{2}');
legend('klassiek', 'orthogonaliteit klassiek', 'gewijzigd', 'orthogonaliteit gewijzgid');
%%
% Vraag 1.8 en 1.9
clear;

%Stel matrices op
m = 200; n = 50;

Qklorth = zeros(1,n);
Qmodorth = zeros(1,n);
Qherorth = zeros(1,n);

%Bereken grootte van de fout in orthogonaliteit voor de drie algoritmes in
%functie van k
for k=1:n
    Q = orth(randn(m,n));
    V = orth(randn(n,n));
    D = diag(2.^linspace(0,k,n));
    A = Q*D*V;
    [Qkl, ~] = klGS(A);
    [Qmod, ~] = modGS(A);
    [Qher, ~] = herGS(A);
    Qklorth(k) = norm(eye(n,n) - Qkl'*Qkl);
    Qmodorth(k) = norm(eye(n,n) - Qmod'*Qmod);
    Qherorth(k) = norm(eye(n,n) - Qher'*Qher);
end

%plot
figure;
semilogy(1:n, Qklorth, 'r', 1:n, Qmodorth,'g' ,1:n ,Qherorth ,'b' ,'LineWidth', 1); xlabel('k'); ylabel('fout op orthogonaliteit');
legend('klassiek', 'gewijzigd', 'herhaald');
%%
% Vraag 1.11
clear;
%laad matrix Amat in en vooer de drie algoritmes uit
load("Amat.mat");
[m, n] = size(Amat);

[Qkl, ~] = klGS(Amat);
[Qmod, ~] = modGS(Amat);
[Qher, ~] = herGS(Amat);

%Test orthogonaliteit
Ekl = Qkl'*Qkl - eye(n, n);
Emod = Qmod'*Qmod - eye(n, n);
Eher = Qher'*Qher - eye(n, n);

%Plot
figure;
tiledlayout(2, 2);
nexttile;
hkl = heatmap(log(abs(Ekl)));
hkl.ColorLimits = [-40, 0];
hkl.Title = 'Klassiek algoritme';
nexttile;
hmod = heatmap(log(abs(Emod)));
hmod.ColorLimits = [-40, 0];
hmod.Title = 'Gewijzigd algoritme';
nexttile;
hher = heatmap(log(abs(Eher)));
hher.ColorLimits = [-40,-30];
hher.Title = 'Herhaald algoritme';
%% 
% Stel je data voor:
t = [0 0 0 0 1 2 3 4 5 5 5 5];  % knooppuntenrij voor kubische spline
x = [0.5 1.5 2.5 3.5 4.5];      % meetpunten
b = [1 2 0 1 3];                % functiewaarden op x
xeval = linspace(0, 5, 100);    % evaluatiepunten

% Bereken spline
z = kkb_cubespline(t, x, b, xeval);

% Plot
figure;
plot(xeval, z, 'b-', x, b, 'ro')
legend('spline', 'meetpunten')


