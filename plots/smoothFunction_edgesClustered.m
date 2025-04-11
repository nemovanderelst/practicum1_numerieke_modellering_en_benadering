%%
clc;
n = 25;
f = getFunction('smooth');
t = getKnotsClusteredEdges(0, 2*pi,25);
x_data = linspace(0, 2*pi, n);
b = f(x_data)';
xeval = linspace(0, 2*pi, 500);

z = kkb_cubespline(t, x_data, b, xeval);

%%
% Plot
plot(xeval, z, 'b-', x_data, b, 'gd', xeval, f(xeval), 'k--', t, zeros(length(t)), 'rx')
legend('Splinebenadering', 'Gegevenspunten', 'Originele functie', 'Knooppunten', 'Location', 'Best')
title('B-spline benadering van f(x) = sin(x) + 0.5*cos(2x)')
xlabel('x'); ylabel('y');
% Force axis limits
set(gca, 'YLim', [-1.5 1]);  
set(gca, 'XLim', [0 7]);  

grid on;