clc;
clear;
close all;

f = getFunction('4');
xeval = linspace(-1, 1, 200);
x_data = linspace(-1, 1, 200);
f_data = f(x_data);

n_knots_all = 3:49;                      % Voor MAE en alles
n_knots_selected = [3, 12, 48];          % Enkel deze tonen in grafieken
colors = lines(length(n_knots_selected)); % Kleuren voor geselecteerde grafieken

mean_errors_clean = zeros(size(n_knots_all));
mean_errors_noisy = zeros(size(n_knots_all));

for pass = 1:2
    is_noisy = (pass == 2);

    if is_noisy
        case_name = 'met ruis';
        y_eval = f(xeval) + 0.04 * randn(size(xeval));
        y_data = f_data + 0.04 * randn(size(x_data));
    else
        case_name = 'zonder ruis';
        y_eval = f(xeval);
        y_data = f_data;
    end

    fig_err = 10 + pass;
    fig_approx = 20 + pass;

    % foutgrafiek
    figure(fig_err); clf; hold on;
    h_zero = plot(xeval, zeros(size(xeval)), 'k--', 'LineWidth', 1.5);
    legend_handles_err = h_zero;
    legend_entries_err = {'Referentie (nul-lijn)'};

    % benaderingsgrafiek 
    figure(fig_approx); clf; hold on;
    h_true = plot(xeval, f(xeval), 'k--', 'LineWidth', 2);  % Altijd originele f
    legend_handles_approx = h_true;
    legend_entries_approx = {'Originele functie'};


    for i = 1:length(n_knots_all)
        n_knots = n_knots_all(i);
        t = getKnotsUniform(-1, 1, n_knots);
        b = y_data(:);

        z = kkb_cubespline(t, x_data, b, xeval);
        err = f(xeval) - z;  % Altijd fout tov echte functie

        % MAE 
        if is_noisy
            mean_errors_noisy(i) = mean(abs(err));
        else
            mean_errors_clean(i) = mean(abs(err));
        end

        if ismember(n_knots, n_knots_selected)
            idx_color = find(n_knots_selected == n_knots);
            c = colors(idx_color, :);

            figure(fig_err);
            h_err = plot(xeval, err, '-', 'Color', c, 'LineWidth', 1.5);
            legend_handles_err(end+1) = h_err;
            legend_entries_err{end+1} = ['Fout bij ', num2str(n_knots), ' knopen'];

            figure(fig_approx);
            h_approx = plot(xeval, z, '-', 'Color', c, 'LineWidth', 1.5);
            legend_handles_approx(end+1) = h_approx;
            legend_entries_approx{end+1} = ['Spline met ', num2str(n_knots), ' knopen'];
        end
    end

    figure(fig_err);
    legend(legend_handles_err, legend_entries_err, 'Location', 'eastoutside');
    xlabel('x'); ylabel('f(x) - spline(x)');
    title(['Fout t.o.v. originele functie (' case_name ')']);
    xlim([-1 1]); ylim([-0.25 0.25]);
    grid on;

    figure(fig_approx);
    legend(legend_handles_approx, legend_entries_approx, 'Location', 'eastoutside');
    xlabel('x'); ylabel('y');
    title(['Originele functie en B-spline benaderingen (' case_name ')']);
    xlim([-1 1]); ylim([-0.25 0.25]);
    grid on;
end

figure(3); clf;
hold on;
plot(n_knots_all, mean_errors_clean, '-o', 'LineWidth', 2, 'DisplayName', 'Zonder ruis');
plot(n_knots_all, mean_errors_noisy, '-s', 'LineWidth', 2, 'DisplayName', 'Met ruis');
xlabel('Aantal knopen');
ylabel('Gemiddelde absolute fout (MAE)');
title('MAE voor splinebenadering (vergelijking met en zonder ruis)');
legend('Location', 'northeast');
grid on;
