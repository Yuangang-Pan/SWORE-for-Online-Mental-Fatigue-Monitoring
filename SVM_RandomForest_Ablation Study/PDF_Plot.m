clc
clear
rng(9159)
load('ACC100.mat')
temp.random_forest = ACC.random_forest(:,26:end);
temp.SVM = ACC.SVM(:,26:end);

random_forest = temp.random_forest(:);
SVM = temp.SVM(:);

random_forest_mu = mean(random_forest)*100;
random_forest_std = std(random_forest)*100;
SVM_mu = mean(SVM)*100;
SVM_std = std(SVM)*100;