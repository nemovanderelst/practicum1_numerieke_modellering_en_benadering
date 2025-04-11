function t = getKnotsClusteredCenter(start, eind, n)
    x = linspace(0, 1, n);
    x_clustered = abs(x - 0.5).^2;                  % quadratic shape
    x_clustered = x_clustered / max(x_clustered);  % normalize
    x_clustered = (start+eind)/2 - (start+eind)/2*x_clustered;   %invert
    x_clustered(13:end) = abs(pi-x_clustered(13:end)) + (start+eind)/2;
    t = augknt(x_clustered, 3);
end