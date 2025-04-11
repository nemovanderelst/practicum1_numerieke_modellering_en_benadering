% Define the knot vector and domain
t = [-3 -2 -1 0 1 2 3 4 5 6 7 8];  % Knot vector
x_vals = linspace(t(1), t(end), 1000);  % Evaluation domain

i = 4; % Index of basis function to visualize across degrees

figure;
hold on;

% Loop over degrees and plot one basis function per degree
for k = 0:3    
    % Check if this basis function exists for this degree
    if i + k + 1 > length(t)
        continue;
    end

    % Evaluate basis function
    y_vals = zeros(size(x_vals));
    for j = 1:length(x_vals)
        y_vals(j) = bspline_N(i, k, t, x_vals(j));
    end

    % Plot with label
    plot(x_vals, y_vals, 'LineWidth', 2, 'DisplayName', ['N_{' num2str(i) ',' num2str(k) '}']);
end

% Final plot styling
title(['B-spline Basis Functions N_{' num2str(i) ',k} for k = 0 to 3']);
xlabel('x');
ylabel('Amplitude');
xlim([0 5]);
ylim([0 1]);
grid on;
legend('Location', 'northeast');
hold off;
