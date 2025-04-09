function Mrow = deBoor_Mrow(t, k, x)
    % Bereken een rij van M
    % t = knooppunten
    % k = graad, k+1 = orde
    % x = evaluatiepunt
   
    % Zoek i zodat t(i) <= x < t(i+1)
    i = zoekBeginInterval(t, x);

    % Initialisatie van de tabel D
    D = zeros(k+1, k+1); % 4x4
    for rij = 1:k+1        % 1-2-3-4
        if t(i - k + rij) <= x && x < t(i - k + rij + 1) % 1ste kolom invullen met 1tjes
            D(rij,1) = 1;
        end
    end
    disp("D = ")
    disp(D);
    % Recurs opbouw matrix met N(i,j) vr bep x. Enkel laatste kolom nodig.
    for kolom = 2:k+1
        for rij = i:i-k
            if t(kolom+rij-1) - t(rij) ~= 0 
                left = (x - t(rij)) / (t(kolom+rij-1) - t(rij)) * D(rij, kolom-1);
            else 
                left = 0;
            end
            if t(rij+kolom) - t(rij+1) ~= 0
                right = (t(rij+kolom) - x) / (t(rij+kolom) - t(rij+1)) * D(rij + 1, kolom - 1);
            else 
                right = 0;
            end
            D(rij, kolom) = left + right;
        end
    end 
    % De laatste kolom van D is een rij van M rxn
    n = length(t)-(k+1);
    Mrow = zeros(1, n);
    start = i - k;
    if start >= 1 && (start + k) <= n
        Mrow(start:start+k) = D(:, end)';
    end
    end

