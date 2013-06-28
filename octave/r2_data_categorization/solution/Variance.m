function Var = Variance(V)
Var = sum((V-mean(V)).^2);
end

%!test
%! assert(Variance([1, 1]), 0)
%! assert(Variance([1, 100]), 4900.5)