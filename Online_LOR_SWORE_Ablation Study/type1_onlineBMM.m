function [mu_new, sigma, alpha] = type1_onlineBMM(mu, var, Beta, x1, x2, r, K)
% m: the weight vector% v: the variance matrix
% beta: [a,b] Gamma bariable of the channel reliability
% x1: the first EEG signal
% x2: the second EEG signal
% r: dropout rate
% K: data augment

% mu: the updated mean
% sigma: the updated variance matrix
% alpha: the updated worker quality
mu_new = mu;
sigma = var;
kappa1 = 1e-6;
kappa2 = 1e-4;

for k = 1 : K
ID = rand(size(mu)) > r;

dx = (x1-x2) .* ID;
%% Mean mu
A = 1 / (1 + Beta(2)/Beta(1) * exp( -mu' * dx));
a = 1 / (1 +                   exp( -mu' * dx));
temp_a = (A-a) * var .* dx;
mu_new(ID) = mu(ID) + temp_a(ID);

%% variance Sigma
b = A*(1-A) - a*(1-a);
temp_b = var + (var.^2) .* (dx.^2) * b;
sigma(ID) = max(temp_b(ID), kappa1);

%% worker quality 
a = 1 / (1 +                   exp( -mu_new' * dx));
Temp3 = a*(1-a)*(1-2*a)*(dx.^2);
Temp4 = -Temp3;
C1 = max(  a + 1/2 * sigma' * Temp3, kappa2);
C2 = max(1-a + 1/2 * sigma' * Temp4, kappa2);
C_sum = C1 + C2;
C1 = C1/C_sum; C2 = C2/C_sum;
    
C=(C1*Beta(1)+C2*Beta(2))/sum(Beta);

m=( C1*(Beta(1)+1)+C2*Beta(2) )*Beta(1)   /   (   C*(sum(Beta)+1)  *  sum(Beta)  );
v=( C1*(Beta(1)+2)+C2*Beta(2) )  *  ( Beta(1)+1)*Beta(1)  /  (  C*(sum(Beta)+2)  *  (sum(Beta)+1)  *  sum(Beta)  );
     
alpha(1) = (m-v)*m/(v-m^2);
alpha(2) = (m-v)*(1-m)/(v-m^2);

mu = mu_new;
var = sigma;
Beta = alpha;
end