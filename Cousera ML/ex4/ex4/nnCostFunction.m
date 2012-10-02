function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% Theta 1 % 25x401
% Theta 2 % 10x26

a_1 = [ones(m, 1) X]; % 5000x401
a_2 = [ones(m, 1) sigmoid(a_1*Theta1')]; % 5000x401 x 401x25 (+ a col) = 5000x26
a_3 = sigmoid(a_2*Theta2'); % 5000x26 x 26x10 = 5000x10

% m = 5000
% y = 5000x1

new_y = y_transform(y, num_labels); % 5000x10

J = (1/m) * sum(sum((-new_y.*log(a_3) - (1-new_y).*log(1-a_3)))) + lambda/(2*m)*(sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)));


s_3 = a_3 - new_y; % 5000x10
z_2 = a_1*Theta1'; % 5000x401 x 401x25 = 5000x25
s_2 = (s_3*Theta2)(:,2:end).*sigmoidGradient(z_2); % 5000x10 x 10x26 = 5000x26 => 5000x25

for t = 1:m
    Theta1_grad += s_2(t,:)'*a_1(t,:); % 25x1 x 1x401 = 25x401    
    Theta2_grad += s_3(t,:)'*a_2(t,:); % 10x1 x 1x26 = 10x26
end

T1_reg_param = lambda/m*Theta1;
T1_reg_param(:,1) *= 0;
T2_reg_param = lambda/m*Theta2;
T2_reg_param(:,1) *= 0;
Theta1_grad = 1/m*Theta1_grad + T1_reg_param;
Theta2_grad = 1/m*Theta2_grad + T2_reg_param;

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end

function [r] = y_transform(y, num_labels)
    t = 1:num_labels;
    r = (t == y);
end
