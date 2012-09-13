function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

% theta 3x1
% X 100x3
% y 100x1
% h_theta(X) = sigmoid(X*theta) % 100x1
% m = 100
h_theta = sigmoid(X*theta);

J = (1/m) * (-y'*log(h_theta) - (1-y')*log(1-h_theta)) + lambda/(2*m)*sum(theta(2:end).^2);
morph = ones(size(theta));
morph(1) = 0;
grad = (1/m) * X' *(h_theta - y) + (lambda/m)* theta .* morph;




% =============================================================

end
