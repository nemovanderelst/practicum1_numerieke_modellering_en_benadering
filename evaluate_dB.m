function cFinal = evaluate_dB(t, c, k, x)
    % Evaluatie van splinefunctie s(x) via algoritme van de Boor
    % t: knooppunten
    % c: coëfficiënten
    % k: graad
    % x: evaluatiepunt

    i = zoekBeginInterval(t, x);
    if i == -1
        cFinal = 0;
        return;
    end
    C = zeros(k+1, k+1);
    
    start = i - k + 1;
    stop  = i + 1;
        
    c_local = c(max(start, 1) : min(stop, length(c)));
    c_local = [c_local; zeros(k+1 - length(c_local), 1)]; % aanvullen met nullen
    
    C(:,1) = c_local;
    for rij = 1:k+1
        for kolom = rij:k+1
            a = (x-t(rij))/(t(i+k+1-kolom)-t(rij));
            C(rij, kolom) = a*C(rij, kolom-1) + (1-a)*C(rij-1, kolom-1);
        end
    end
    cFinal = C(end, end);
end


