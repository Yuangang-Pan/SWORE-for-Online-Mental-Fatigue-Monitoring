function ACC = SVR_Evaluation (EST_Y, BDtable, Y)
%% input 
% EST_Y: the estimated response time
% BDtable: the maintained reference table, BDtable.EEG, BDtable.RT
% Y: the response time
%% Output
% ACC: the prediction accuracy
RT = BDtable.RT;
K = length(RT); 
ACC = 0;
for k = 1 : K
    if (Y > RT(k) && (EST_Y > RT(k))) || (Y < RT(k) && (EST_Y < RT(k)))
       ACC = ACC + 1;
    end
end
ACC = ACC / K;
