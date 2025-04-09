function z = kkb_cubespline(t,x,b,xeval)
    % t is vector met knooppunten
    % x is vector met abscissen
    % b is vector met functiewaarden in abscissen
    % xeval is vector met te evalueren x-waarden met de bekomen benadering
    %       -> evaluatie moet in vector z gezet worden
    
    k = 3;                  % graad (kubisch)
    M = build_M(t, x, k);   % M(j, i) = N_i,3(x_j)
    fprintf(size(M));
    fprintf(size(b'));
    c = M \ b(:);
    z = zeros(size(xeval));
    for i = 1:length(xeval)
        z(i) = evaluate_dB(t, c, k, xeval(i));
    end
end