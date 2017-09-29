clearvars

load breast-cancer.mat

A   = [ones(size(features_train,1), 1) features_train]; % for bias
b   = labels_train;

% First order oracle
% An example of Matlab anonymous function is below.
% This function computes the sigmoid of each entry of its input x.
sigmoid = @(x) (1./(1+exp(-x)));
% fx computes the objective (l-2 regularized) of input x
fx      = @(x)(-sum(log(sigmoid(b.* (A*x)))));
% gradfx computes the gradient (l-2 regularized) of input x
gradf  = @(x)(-A' * ((1 - sigmoid(b.*(A*x))) .* b));

%% Parameters
maxit   = ...?;
x0      = ...?;
stepsize  = ...?;

%% Gradient descent
[xGD, obj] = GD(fx, gradf, stepsize, x0, maxit);

%% Plot the convergence
figure(3)
loglog((obj - optval)/optval)
ylabel('f(x)-f^*','FontSize',20);
xlabel('iterations','FontSize',20);
hold on

