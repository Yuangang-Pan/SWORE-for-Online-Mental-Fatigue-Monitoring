function BDtable = Table_update_with_reservoir_sampling(BDtable, X, Y, iter, K)
%% input 
% BDtable: the maintained reference table, BDtable.EEG, BDtable.RT, Dtable.ratio, BDtable.AUG
% X: the new observed EEG signals from 33 channels
% Y: the recorded response time for X
%% Output
% BDtable: the updated BDtable

Id1 = rand < K/iter;
if Id1 == 1
    Id2 = randperm(K,1);
    BDtable.EEG(Id2, :) = X;
    BDtable.RT(Id2) = Y;
end
