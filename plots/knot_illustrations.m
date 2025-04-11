% Knot vectors
t_uniform = getKnotsUniform(0, 2*pi, 25);
t_edge_clustered = getKnotsClusteredEdges(0, 2*pi, 25);
t_center_clustered = getKnotsClusteredCenter(0, 2*pi, 25);

% Dummy y-values for vertical offset
y_uniform = ones(size(t_uniform));            % y = 1
y_edge = zeros(size(t_edge_clustered));       % y = 0
y_center = -1 * ones(size(t_center_clustered));% y = -1

% Plot
figure;
hold on;

% Plot everything clearly
p1 = plot(t_uniform, y_uniform, 'go-', 'DisplayName', 'Uniform knopen');
p2 = plot(t_edge_clustered, y_edge, 'ro-', 'DisplayName', 'Rand-geclusterd');
p3 = plot(t_center_clustered, y_center, 'bo-', 'DisplayName', 'Midden-geclusterd');

% Force axis limits
set(gca, 'YLim', [-2 2]);  

% Styling
legend('Location', 'best');
xlabel('knooppuntwaarde');
ylabel('(dummy)');
title('Vergelijking van knoopverdelingen');
grid on;

hold off;
