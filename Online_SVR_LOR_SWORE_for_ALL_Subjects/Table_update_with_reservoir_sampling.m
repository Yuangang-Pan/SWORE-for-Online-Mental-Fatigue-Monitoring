function [SG_BDtable, BDtable] = Table_update_with_reservoir_sampling (SG_BDtable, BDtable, X, feat, Y, iter, K)
%% input 
% BDtable: the maintained reference table, BDtable.EEG, BDtable.RT, Dtable.ratio, BDtable.AUG
% X: the new observed EEG signals from 33 channels
% Y: the recorded response time for X
%% Output
% BDtable: the updated BDtable

Id1 = rand < K/iter;
if Id1 == 1
    Id2 = randperm(K,1);
    SG_BDtable.EEG(Id2, :) = X;
    SG_BDtable.RT(Id2) = Y;
    BDtable.EEG(:, :, Id2) = feat;
    BDtable.RT(Id2) = Y;
end
