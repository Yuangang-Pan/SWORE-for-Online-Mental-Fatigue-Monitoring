function [mu_new, sigma] = type2_onlineBMM(mu, var, x1, x2, r, K)
% m: the weight vector% v: the variance matrix
% x1: the first EEG signal
% x2: the second EEG signal
% r : dropout rate
% K: data augment

% mu: the updated mean
% sigma: the updated variance matrix
mu_new = mu;
sigma = var;
kappa = 1e-6;

for k = 1 : K
ID = rand(size(mu)) > r;

dx = (x1-x2) .* ID;
%% Mean mu
a = 1 / (1 + exp( -mu' * dx));
temp_a = 0.5*(1-2*a)* var .* dx;
mu_new(ID) = mu(ID) + temp_a(ID);

%% variance Sigma
b = -a*(1-a);
temp_b = var + (var.^2) .* (dx.^2) * b;
sigma(ID) = max(temp_b(ID), kappa);

mu = mu_new;
var = sigma;
end
