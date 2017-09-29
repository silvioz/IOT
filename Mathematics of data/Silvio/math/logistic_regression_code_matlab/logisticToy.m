% clearvars
rng(1,'twister'); % Fix the random seed

load synthetic-data.mat

A   = [ones(size(features,1), 1) features]; % for bias
b   = labels;
% An example of Matlab anonymous function is below.
% This function computes the sigmoid of each entry of its input x.
sigmoid = @(x) (1./(1+exp(-x)));
% fsx computes the objective (l-2 regularized) of input x
fx      = @(x)(-sum(log(sigmoid(b.* (A*x)))));
% gradfx computes the gradient (l-2 regularized) of input x
gradf  = @(x)(-A' * ((1 - sigmoid(b.*(A*x))) .* b));


%% train the model
maxit     = ...?;
stepsize  = ...?;
x0 = ...?;

[xGD, obj]     = GD(fx, gradf, stepsize, x0, maxit);

%% 2d scatter plot
idx1                = find(labels == -1);
idx2                = find(labels == 1);
separating_line     = @(x, ylim) (-x(1) - ylim*x(3))/x(2);

% close all
figure(1); hold off
plot(features(idx1,1), features(idx1,2), 'r*');
hold on
plot(features(idx2,1), features(idx2,2), 'b*');
xlabel('x_1');
ylabel('x_2');

plot(separating_line(xGD, ylim), ylim, 'b-');
xlim([-2.5,2.5])
ylim([-2.5,2.5])

%% convergence plot
figure(2)
loglog(obj - optval);
ylabel('f(x)-f^*','FontSize',20);
xlabel('iterations','FontSize',20);
ylim([1e-4,1e4])
hold on
