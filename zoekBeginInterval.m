function index = zoekBeginInterval(t, x)
    if t(end) < x || t(1) > x
       index = -1;
    else
       index = find(t <= x, 1, 'last');
    end
   
end