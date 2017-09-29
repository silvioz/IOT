
rng(1,'twister'); % Fix the random seed

close all

p = 2;
n = 100;

x_true = randn(p,1);
mu_true = randn(1,1);

features = randn(n,p);
labels = ...?;

idx1                = find(labels == -1);
idx2                = find(labels == 1);

figure; hold on
plot(features(idx1,1), features(idx1,2), 'r*');
plot(features(idx2,1), features(idx2,2), 'b*');
xlabel('x_1');
ylabel('x_2');