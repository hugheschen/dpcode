function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

m = length(y); % number of training examples

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

% Don't want to regularize theta(1)
thetaReg = theta;
thetaReg(1) = 0;

J = -(1 / m) * ( log(    sigmoid(X * theta))' * y +
		 log(1 - sigmoid(X * theta))' * (1 - y)
		) ...
    + ...
      lambda / (2 * m) * thetaReg' * thetaReg;

grad = (1 / m) * X' * ( sigmoid(X * theta) - y ) + (lambda / m * thetaReg);




% =============================================================

end

test solution
%!test
%! theta = [0; 0; 0];
%! X = [1.0000 34.6237 78.0247; 1.0000 30.2867 43.8950; 1.0000 35.8474 72.9022; 1.0000   60.1826   86.3086];
%! y = [0; 0; 0; 1];
%! [J, grad] = costFunctionReg(theta, X, y, 0);
%! assert(J, 0.69315, 1e-4)
%! assert(grad, [0.25000; 5.07190; 13.56416], 1e-4)
%!
%! theta = [-0.1; -0.1; -0.1];
%! X = [1.0000 34.6237 78.0247; 1.0000 30.2867 43.8950; 1.0000 35.8474 72.9022; 1.0000   60.1826   86.3086];
%! y = [0; 0; 0; 1];
%! [J, grad] = costFunctionReg(theta, X, y, 0);
%! assert(J, 3.6874, 1e-4)
%! assert(grad, [-0.24986; -15.04128; -21.57065], 1e-4)
%!
%! theta = [-0.1; -0.1; -0.1];
%! X = [1.0000 34.6237 78.0247; 1.0000 30.2867 43.8950; 1.0000 35.8474 72.9022; 1.0000   60.1826   86.3086];
%! y = [0; 0; 0; 1];
%! [J, grad] = costFunctionReg(theta, X, y, 1);
%! assert(J, 3.6899, 1e-4)
%! assert(grad, [-0.24986; -15.06628; -21.59565], 1e-4)



