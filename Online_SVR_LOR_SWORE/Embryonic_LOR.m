function LOR_model = Embryonic_LOR(BDtable)
%% BDtable: the maintained Brain Dynamic Table
% BDtable_EEG: the maintained Brain Dynamic Preferences
% BDtable_RT: the maintained response time
EEG = BDtable.EEG;
RT = BDtable.RT;
BD_preference = LOR_task_generation(RT);

% concatenate features from different channels

n_dim = size(EEG,2)+1;
% initial parameters for scores,
mu = 0.1*(2*rand(n_dim, 1)-1);
sigma = 0.01*(ones(n_dim, 1));
LOR_model = LOR_Update(mu, sigma, EEG, BD_preference);
