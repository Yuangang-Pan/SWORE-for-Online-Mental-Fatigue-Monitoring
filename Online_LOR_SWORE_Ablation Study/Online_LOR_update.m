function OnlineLOR = Online_LOR_update (OnlineLOR, BDtable, X, Y)
%% input 
% OnlineLOR: the LOR model, LOR.mu, LOR.sigma
% BDtable: the maintained reference table, BDtable.EEG, BDtable.RT, Dtable.ratio, BDtable.AUG
% X: the new observed EEG signals from 33 channels
% Y: the recorded response time for X
%% Output
% SWORE: the updated model

RT = BDtable.RT;
K_Reference = length(RT); 

for k = 1 : K_Reference
    x_new = [X,1]';
    x_old = [BDtable.EEG(k, :), 1]';  
    if  RT(k) > Y 
        [OnlineLOR{1}, OnlineLOR{2}] = type1_LOR(OnlineLOR{1}, OnlineLOR{2}, x_new, x_old);
    else
        [OnlineLOR{1}, OnlineLOR{2}] = type1_LOR(OnlineLOR{1}, OnlineLOR{2}, x_old, x_new);
    end
end

