function [theta] = normalEqn(X, y)
%NORMALEQN Computes the closed-form solution to linear regression 
%   NORMALEQN(X,y) computes the closed-form solution to linear 
%   regression using the normal equations.

theta = zeros(size(X, 2), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the code to compute the closed form solution
%               to linear regression and put the result in theta.
%

% ---------------------- Sample Solution ----------------------

% X % nx3
% X'*X % 3*3
% pinv(X'*X)*X' % 3*n
% y % n*1
% theta % 3x1
theta = pinv(X'*X)*X'*y

% -------------------------------------------------------------


% ============================================================

end
