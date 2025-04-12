clc;
clear;
close all;

% Settings
f = getFunction('4');
xeval = linspace(-1, 1, 200);
y_true = f(xeval);  % true function

% Choose which n values to show in the legend (3 to 12)
n_values = 3:12;
show_in_legend = ismember(n_values, [3, 6, 9, 12]);  % toggle visibility

% Color setup
colors = lines(length(n_values));
legend_entries_err = {'Referentie (nul-lijn)'};
legend_handles_err = [];

legend_entries_approx = {'Originele functie'};
legend_handles_approx = [];

% ==== Figure 1: Error plots ====
figure(1); hold on;
h_zero = plot(xeval, zeros(size(xeval)), 'k--', 'LineWidth', 1.5);  % zero line
legend_handles_err(end+1) = h_zero;

% ==== Figure 2: Approximation plots ====
figure(2); hold on;
h_true = plot(xeval, y_true, 'k--', 'LineWidth', 2);  % true function
legend_handles_approx(end+1) = h_true;

% Loop over n = 3 to 12
for i = 1:length(n_values)
    n = n_values(i);
    t = getKnotsUniform(-1, 1, 10);  % fixed knots
    x_data = linspace(-1, 1, n);
    b = f(x_data)';

    % Compute spline and error
    z = kkb_cubespline(t, x_data, b, xeval);
    err = y_true - z;

    % ==== Plot error ====
    figure(1);
    h_err = plot(xeval, err, '-', 'Color', colors(i,:), 'LineWidth', 1.5);
    if show_in_legend(i)
        legend_handles_err(end+1) = h_err;
        legend_entries_err{end+1} = ['Fout voor n = ', num2str(n)];
    end

    % ==== Plot approximation ====
    figure(2);
    h_approx = plot(xeval, z, '-', 'Color', colors(i,:), 'LineWidth', 1.5);
    if show_in_legend(i)
        legend_handles_approx(end+1) = h_approx;
        legend_entries_approx{end+1} = ['Spline voor n = ', num2str(n)];
    end
end

% Finalize Figure 1
figure(1);
legend(legend_handles_err, legend_entries_err, 'Location', 'Best');
xlabel('x'); ylabel('f(x) - spline(x)');
title('Fout tussen originele functie en B-spline benaderingen');
set(gca, 'YLim', [-0.25 0.2 5]);  
set(gca, 'XLim', [-1 1]); 
grid on;

% Finalize Figure 2
figure(2);
legend(legend_handles_approx, legend_entries_approx, 'Location', 'Best');
xlabel('x'); ylabel('y');
title('Originele functie en B-spline benaderingen voor verschillende n');
set(gca, 'YLim', [-0.25 0.25]);  
set(gca, 'XLim', [-1 1]);
grid on;
