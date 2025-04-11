function t = getKnotsUniform(start, eind, n) 
    x_uniform = linspace(start, eind, n);
    t = augknt(x_uniform, 3);
end