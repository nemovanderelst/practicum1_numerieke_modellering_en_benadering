function f = getFunction(type)
    if strcmp(type, 'smooth')
        f = @(x) sin(x) + 0.5*cos(2*x);
    elseif strcmp(type, 'sharp')
        f = @(x) ...
            (x < 2) .* (x) + ...
            (x >= 2 & x < 4) .* sin(5.*x) + ...
            (x >= 4 & x < 6) .* (-25+5.*x) + ...
            (x >= 6) .* ((cos(x) - 1));
    end  
end
