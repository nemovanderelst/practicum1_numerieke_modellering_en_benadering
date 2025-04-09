clc;

disp("Test: bspline_N");
t = [0 1 2 3 4 5];
x = 2.5;
val = bspline_N(3, 1, t, x);  % controleer B-spline graad 1
disp("Expected value ≈ 0.5, got: " + val);
%%

disp("Test: bspline_basis_eval");
t = linspace(0, 5, 10);
k = 3;
num_basis = length(t) - k - 1 + k;
x = 2.3;
N = bspline_basis_eval(k, t, x, num_basis);
disp("B-spline basis vector at x=2.3:");
disp(N);
disp("Sum of basis values (should be ≈ 1): " + sum(N));
%%

disp("Test: de_boor_eval");
c = [0 1 2 3 4 5 6]; % dummy coëfficiënten
t = [0 0 0 0 1 2 3 4 5 5 5 5]; % met herhaling aan uiteinden
x = 2.5;
s = de_boor_eval(3, t, c, x);
disp("Splinewaarde bij x=2.5 met dummy coëfficiënten: " + s);
%%

disp("Test: M-matrix via bspline_basis_eval");
x_data = [0.5 1.5 2.5 3.5 4.5];
t = [0 0 0 0 1 2 3 4 5 5 5 5];
k = 3;
num_basis = length(t) - k - 1 + k;
M = zeros(length(x_data), num_basis);
for j = 1:length(x_data)
    M(j,:) = bspline_basis_eval(k, t, x_data(j), num_basis);
end
disp("Matrix M:");
disp(M);
%%

disp("Test: geavanceerde spline benadering");

% Functie: sin(x) + 0.5*cos(2x)
f = @(x) sin(x) + 0.5*cos(2*x);

% Gegeven meetpunten
x_data = linspace(0, 2*pi, 25);
b = f(x_data)';  % b moet kolomvector zijn

% Knooppunten: ruim voldoende, met herhaling aan de uiteinden
t = augknt(linspace(0, 2*pi, 15), 4);  % 4 = kubisch (k+1)

% Evaluatiepunten
xeval = linspace(0, 2*pi, 500);
z = kkb_cubespline(t, x_data, b, xeval);

% Plot
plot(xeval, z, 'b-', x_data, b, 'ro', xeval, f(xeval), 'k--')
legend('Splinebenadering', 'Gegevenspunten', 'Originele functie', 'Location', 'Best')
title('B-spline benadering van f(x) = sin(x) + 0.5*cos(2x)')
xlabel('x'); ylabel('y');
grid on;

