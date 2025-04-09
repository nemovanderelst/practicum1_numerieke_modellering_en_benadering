clc;
disp("Test: zoekBeginInterval");
t = [0 0 0 0 1 2 3 4 5 5 5 5];
x = 2.3;
index = zoekBeginInterval(t, x);
disp("Expected index ≈ 6, got: " + index);
%%

disp("Test: deBoor_Mrow");
k = 3;
t = [0 0 0 0 1 2 3 4 5 5 5 5];
x = 2.5;
row = deBoor_Mrow(t, k, x);
disp("M-row (B-spline values at x=2.5):");
disp(row);
%%

disp("Test: build_M");
x_data = [0.5 1.5 2.5 3.5 4.5];
M = build_M(t, x_data, 3);
disp("Matrix M:");
disp(M);
%%
disp("Test: evaluate_dB");
x_data = [0.5 1.5 2.5 3.5 4.5];
b = [1 2 0 1 3];

M = build_M(t, x_data, 3);
c = M \ b(:);  % Solve least squares

x_val = 2.7;
y = evaluate_dB(t, c, 3, x_val);
disp("spline(2.7) = " + y);

%%

disp("Test: full spline");
xeval = linspace(0, 5, 100);
z = kkb_cubespline(t, x_data, b, xeval);
plot(xeval, z, "b-", x_data, b, "ro")
title("Spline test")