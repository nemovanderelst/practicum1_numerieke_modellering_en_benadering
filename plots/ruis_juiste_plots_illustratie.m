clc;
clear;
close all;

f = getFunction('4');
x = linspace(-1, 1, 200);              
y_true = f(x);                       
y_noisy = y_true + 0.04 * randn(size(x)); 


n_knots_all = 3:100;


norm_fout_true = zeros(size(n_knots_all));
norm_fout_noisy = zeros(size(n_knots_all));


for i = 1:length(n_knots_all)
    n_knots = n_knots_all(i);
    t = getKnotsUniform(-1, 1, n_knots);

    % Bereken splinebenadering
    z = kkb_cubespline(t, x, y_noisy, x);

    % Fouten
    norm_fout_true(i) = norm(y_true - z);
    norm_fout_noisy(i) = norm(y_noisy - z);
end


[~, idx_min_true] = min(norm_fout_true);
[~, idx_min_noisy] = min(norm_fout_noisy);

beste_knopen_true = n_knots_all(idx_min_true);
beste_knopen_noisy = n_knots_all(idx_min_noisy);


t_true = getKnotsUniform(-1, 1, beste_knopen_true);
t_noisy = getKnotsUniform(-1, 1, beste_knopen_noisy);

z_bij_min_true = kkb_cubespline(t_true, x, y_noisy, x);
z_bij_min_noisy = kkb_cubespline(t_noisy, x, y_noisy, x);

% === Plot: beide fouten op 1 grafiek ===
figure(1); clf;
plot(n_knots_all, norm_fout_true, '-o', 'LineWidth', 2, 'DisplayName', '2-norm tov b_{exact}');
hold on;
plot(n_knots_all, norm_fout_noisy, '-s', 'LineWidth', 2, 'DisplayName', '2-norm tov b_{ruis}');
xlabel('Aantal knopen');
ylabel('2-norm van de fout');
title('Vergelijking van splinefouten voor toenemend aantal knopen (tot 100)');
legend('Location', 'northeast');
set(gca, 'YLim', [-1 1]);  
set(gca, 'XLim', [3 100]);  
grid on;

% === Plot: beste benadering tov y_true ===
figure(2); clf;
plot(x, y_true, 'k--', 'LineWidth', 2, 'DisplayName', 'f(x)');
hold on;
plot(x, z_bij_min_true, 'b-', 'LineWidth', 2, 'DisplayName', ...
    ['Beste spline tov b_{exact} (n = ', num2str(beste_knopen_true), ')']);
xlabel('x'); ylabel('y');
title('Beste splinebenadering met b_{exact}');
legend('Location', 'best');
grid on;

% === Plot: beste benadering tov y_noisy ===
figure(3); clf;
plot(x, y_true, 'k--', 'LineWidth', 2, 'DisplayName', 'f(x)');
hold on;
plot(x, z_bij_min_noisy, 'r-', 'LineWidth', 2, 'DisplayName', ...
    ['Beste spline tov b_{ruis} (n = ', num2str(beste_knopen_noisy), ')']);
xlabel('x'); ylabel('y');
title('Beste splinebenadering met b_{ruis}');
legend('Location', 'best');
grid on;
