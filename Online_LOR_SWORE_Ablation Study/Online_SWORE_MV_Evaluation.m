function ACC = Online_SWORE_MV_Evaluation (BDmodel, BDtable, X, Y)
%% input 
% BDmodel: the SWORE model, BDmodel.mu, BDmodel.sigma, BDmodel.alpha
% BDtable: the maintained reference table, BDtable.EEG, BDtable.RT, Dtable.ratio, BDtable.AUG
% X: the new observed EEG signals from 33 channels
%% Output
% ACC: the prediction accuracy
Pi = BDmodel.alpha;
N_Channel = size(Pi,1);
K_Reference = length(BDtable.RT); 
Pi = Pi./ repmat(sum(Pi,2), 1, size(Pi,2));
ACC = 0;
for k = 1 : K_Reference
    ACC_temp = 0;
    for n = 1 : N_Channel   
        x_new = [X(n,:),1]';
        x_old = [BDtable.EEG(n, :, k), 1]';   
        if Pi(n) > 0.8 
           if (Y > BDtable.RT(k) && (BDmodel.mu'*x_new > BDmodel.mu'*x_old)) ||...
                (Y < BDtable.RT(k) && (BDmodel.mu'*x_new < BDmodel.mu'*x_old)) 
               ACC_temp = ACC_temp + 1;
           elseif (Y > BDtable.RT(k) && (BDmodel.mu'*x_new < BDmodel.mu'*x_old)) ||...
                (Y < BDtable.RT(k) && (BDmodel.mu'*x_new > BDmodel.mu'*x_old)) 
               ACC_temp = ACC_temp - 1;
           end
        end
        
        if Pi(n) < 0.2
           if (Y > BDtable.RT(k) && (BDmodel.mu'*x_new < BDmodel.mu'*x_old)) ||...
                (Y < BDtable.RT(k) && (BDmodel.mu'*x_new > BDmodel.mu'*x_old)) 
               ACC_temp = ACC_temp + 1;
           elseif (Y > BDtable.RT(k) && (BDmodel.mu'*x_new > BDmodel.mu'*x_old)) ||...
                (Y < BDtable.RT(k) && (BDmodel.mu'*x_new < BDmodel.mu'*x_old))
               ACC_temp = ACC_temp - 1;
           end
        end
    end
    ACC =  ACC + (ACC_temp > 0) + 0.5 * (ACC_temp==0);
end
ACC = ACC / K_Reference;

