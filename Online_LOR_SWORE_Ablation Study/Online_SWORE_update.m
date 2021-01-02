function BDmodel = Online_SWORE_update (BDmodel, BDtable, X, Y)
%% input 
% BDmodel: the SWORE model, BDmodel.mu, BDmodel.sigma, BDmodel.alpha
% BDtable: the maintained reference table, BDtable.EEG, BDtable.RT, Dtable.ratio, BDtable.AUG
% X: the new observed EEG signals from 33 channels
% Y: the recorded response time for X
%% Output
% SWORE: the updated model

N_Channel = size(BDmodel.alpha,1);
K_Reference = length(BDtable.RT); 
RT = BDtable.RT;
for k = 1 : K_Reference
    for n = 1 : N_Channel   
        x_new = [X(n,:),1]';
        x_old = [BDtable.EEG(n, :, k), 1]';   
        if  RT(k) > Y 
            if RT(k) > min(Y+0.15, 1.2*Y)
                [BDmodel.mu, BDmodel.sigma, BDmodel.alpha(n, :)] = type1_onlineBMM(BDmodel.mu, BDmodel.sigma, ...
                     BDmodel.alpha(n, :), x_old, x_new, BDtable.ratio, BDtable.AUG);
            end
            if RT(k) < min(Y+0.1, 1.1*Y)
                [BDmodel.mu, BDmodel.sigma] = type2_onlineBMM(BDmodel.mu, BDmodel.sigma, x_old, x_new, BDtable.ratio, BDtable.AUG);
            end
        else
            if min(RT(k)+0.15, 1.2*RT(k)) < Y
                [BDmodel.mu, BDmodel.sigma, BDmodel.alpha(n, :)] = type1_onlineBMM(BDmodel.mu, BDmodel.sigma, ...
                    BDmodel.alpha(n, :), x_new, x_old, BDtable.ratio, BDtable.AUG);
            end
            if min(RT(k)+0.1, 1.1*RT(k)) > Y 
                [BDmodel.mu, BDmodel.sigma] = type2_onlineBMM(BDmodel.mu, BDmodel.sigma, x_old, x_new, BDtable.ratio, BDtable.AUG);
            end
            
        end
    end
end

