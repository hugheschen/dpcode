function [J, grad] = costFunction(theta, X, y)
m = length(y); % number of training examples
J = -(1 / m) * ( log(    sigmoid(X * theta))' * y +
					 log(1 - sigmoid(X * theta))' * (1 - y)
				  );

grad = (1 / m) * X' * ( sigmoid(X * theta) - y );
end

test solution
%!test
%! data = load('ex2data1.txt');
%! X = data(:, [1, 2]); 
%! y = data(:, 3);
%! [m, n] = size(X);
%! X = [ones(m, 1) X];
%! initial_theta = zeros(n + 1, 1);
%! options = optimset('GradObj', 'on', 'MaxIter', 400);
%! [theta, cost] = fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
%! assert(theta, [-25.161537; 0.206233; 0.201474], 1e-6);
%! assert(cost, 0.203498, 1e-6);
