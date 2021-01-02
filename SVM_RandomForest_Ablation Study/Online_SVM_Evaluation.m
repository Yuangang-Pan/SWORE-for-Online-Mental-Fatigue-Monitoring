function ACC = Online_SVM_Evaluation (SVM, BDtable, X, Y)
%% input 
% SVM: the ore-train SVM model
% BDtable: the maintained reference table, BDtable.EEG, BDtable.RT
% X: the EEG signal
% Y: the response time
%% Output
% ACC: the prediction accuracy
EEG = BDtable.EEG;
RT = BDtable.RT';
feat = EEG - X;
label = RT > Y;
pred_label = svmpredict(double(label), double(feat), SVM);
ACC = sum(pred_label==label)/length(label);
