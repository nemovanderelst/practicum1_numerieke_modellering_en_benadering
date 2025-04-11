function t = getKnotsClusteredEdges(start, eind, n)
    u_shifted = linspace(-2, 2, n);  % meer bereik in de hoeken
    u_tanh = (tanh(u_shifted) + 1) / 2;    % tussen 0 en 1
    x_edge_clustered = eind + (start - eind) * u_tanh;
    x_edge_clustered(1) = start;
    x_edge_clustered(end) = eind;
    t = augknt(x_edge_clustered, 3);
end