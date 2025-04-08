function z = kkb_cubespline(t,x,b,xeval)
    % t is vector met knooppunten
    % x is vector met abscissen
    % b is vector met functiewaarden in abscissen
    % xeval is vector met te evalueren x-waarden met de bekomen benadering
    %       -> evaluatie moet in vector z gezet worden
    
    k = 3;                  % graad (kubisch)
    M = build_M(t, x, k);   % M(j, i) = N_i,3(x_j)
    c = M \ b;
    z = zeros(size(xeval));
    for i = 1:size(xeval)
        z(i) = evaluate_dB(t, c, k, xeval(i));
    end
end

%%%%%%%% HULPFUNCTIES %%%%%%%%%

function M = build_M(t, x, k)
    n = length(t) - (k+1);
    r = length(x);
    M = zeros(r, n);

    for j = 1:r %per rij
        N = deBoor_N(t, k + 1, x(j));  % Orde = graad + 1
        M(j, :) = N;
    end
end

function val = evaluate_dB(t, c, k, x)
    % Evaluatie van splinefunctie s(x) via algoritme van de Boor
    % t: knooppunten
    % c: coëfficiënten
    % k: graad
    % x: evaluatiepunt

    p = k; % graad
    m = length(t);
    n = length(c);

    % Zoek interval waarin x ligt
    i = find(x >= t, 1, 'last');
    if i >= m
        i = m - 1;
    end

    % Zoek index j zodat t_j <= x < t_{j+1}
    j = i - 1;
    if j < p
        j = p;
    elseif j > n
        j = n;
    end

    % Initieer d (de coëfficiënten die je gaat combineren)
    d = c(j - p + 1:j + 1);

    % De Boor algoritme: recursieve combinatie
    for r = 1:p
        for s = p:-1:r
            i1 = j - p + s;
            alpha = (x - t(i1 + 1)) / (t(i1 + p + 1 - r + 1) - t(i1 + 1));
            if isnan(alpha) || isinf(alpha)
                alpha = 0;
            end
            d(s + 1) = (1 - alpha) * d(s) + alpha * d(s + 1);
        end
    end

    val = d(p + 1);
end

function N = deBoor_N(t, k, x)
    % Bereken een rij van M
    % t = knooppunten
    % k = graad, k+1 = orde
    % x = evaluatiepunt

    n = length(t) - (k+1);
    N = zeros(1, n);
   
    % Zoek i zodat t(i) <= x < t(i+1)
    i = tBegin_Index(t, x);

    % Initialisatie van de tabel D voor orde 1
    D = zeros(k+1, k+1);
    for j = 1:k+1
        if t(i - k + j) <= x && x < t(i - k + j + 1)
            D(j,1) = 1;
        end
    end

    % Recursieve opbouw
    for d = 2:k+1
        for j = 1:(k - d + 2)
            t1 = t(i - k + j + d - 2);
            t2 = t(i - k + j + d - 1);
            left = 0;
            if t2 - t1 ~= 0
                left = (x - t1) / (t2 - t1) * D(j, d - 1);
            end

            t3 = t(i - k + j + d);
            t4 = t(i - k + j + d + 1);
            right = 0;
            if t4 - t3 ~= 0
                right = (t4 - x) / (t4 - t3) * D(j + 1, d - 1);
            end

            D(j, d) = left + right;
        end
    end

    % Kopieer laatste kolom naar juiste plaatsen in N
    for j = 1:k
        idx = i - k + j + 1;
        if idx >= 1 && idx <= n
            N(idx) = D(j, k);
        end
    end
end

function index = tBeginIndex(t, x)
    if t(end) < x || t(1) > x
       index = -1;
    else
       index = find(t <= x, 1, 'last');
    end
   
end


