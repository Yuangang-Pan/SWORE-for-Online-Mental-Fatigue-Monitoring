function ACC = Online_LOR_Evaluation (OnlineLOR, BDtable, X, Y)
%% input 
% OnlineLOR: the LOR model, LOR.mu, LOR.sigma
% BDtable: the maintained reference table, BDtable.EEG, BDtable.RT, Dtable.ratio, BDtable.AUG
% X: the new observed EEG signals from 33 channels
%% Output
% ACC: the prediction accuracy
RT = BDtable.RT;
K_Reference = length(RT); 
ACC = 0;
for k = 1 : K_Reference
    x_new = [X,1]';
    x_old = [BDtable.EEG(k, :),1]';  
    w = OnlineLOR{1,1};
    if (Y > RT(k) && (w'*x_new > w'*x_old)) ||(Y < RT(k) && (w'*x_new < w'*x_old)) 
        ACC = ACC + 1;
    end
end
ACC = ACC / K_Reference;

