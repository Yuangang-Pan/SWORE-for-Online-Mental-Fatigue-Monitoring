function [mu_new, sigma] = type1_LOR(mu, var, x1, x2)
% mu: the weight vector
% var: the variance matrix
% x1: the first EEG signal
% x2: the second EEG signal

% mu: the updated mean
% sigma: the updated variance matrix

kappa1 = 1e-6;

dx = (x2-x1); % x1 < x2
%% Mean mu
a = 1 / (1 + exp( -mu' * dx));
temp_a = (1-a) * var .* dx;
mu_new = mu + temp_a;

%% variance Sigma
b = - a*(1-a);
temp_b = var + (var.^2) .* (dx.^2) * b;
sigma = max(temp_b, kappa1);
end