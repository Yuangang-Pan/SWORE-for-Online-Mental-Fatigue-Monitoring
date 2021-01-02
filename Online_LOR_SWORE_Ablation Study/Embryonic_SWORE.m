function [mu, sigma, alpha] = Embryonic_SWORE(BDtable)
%% BDtable: the maintained Brain Dynamic Table
% BDtable_EEG: the maintained Brain Dynamic Preferences
% BDtable_RT: the maintained response time

%% Parameter Setting
n_worker = size(BDtable.EEG,1);        % the number of worker
n_dim = size(BDtable.EEG,2)+1;           % the feature dimention + 1 offset

% initial parameters for scores,
mu = 0.1*(2*rand(n_dim, 1)-1);
sigma = 0.01*(ones(n_dim, 1)); 
   
% reliability for each channel
pi = [5,5]; 
alpha = repmat(pi, n_worker, 1); 

BD_preference = task_generation(BDtable.RT);
[mu, sigma, alpha] = BMM_Update(mu, sigma, alpha, BDtable.EEG, BD_preference, BDtable.ratio, BDtable.AUG);
