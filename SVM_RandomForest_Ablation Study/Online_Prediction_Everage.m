clc
clear
rng(9159)
load('Data.mat')
load('RT.mat')
path('..//libsvm_matlab', path);
ACC = {};

Iter_num = 100;
K = 25; % BDtable size
G = 10;
T = size(Data, 3);

EEG_data = [];
for k = 1 : size(Data,3)
    temp = Data(:,:,k);
    EEG_data = [EEG_data; temp(:)'];
end

for iter = 1 : Iter_num
fprintf('iter%3d\n', iter)

BDtable.EEG = EEG_data(1:K,:);
BDtable.RT = RT(1:K);

%Embryonic SVM
random_forest =  Embryonic_random_forest(BDtable.EEG, BDtable.RT);
%Embryonic SVM
bestCV = '-t 2';
Online_SVM{1} =  Embryonic_SVM(BDtable.EEG, BDtable.RT, bestCV);

% Brain Dynamic Table
ID = randperm(K,G);
BDtable.EEG = EEG_data(ID,:);
BDtable.RT = RT(ID);

for t = K+1 : T
    X = EEG_data(t,:);
    Y =  RT(t);
    
    %% Random Forest
    ACC.random_forest(iter,t) = Online_random_forest_Evaluation(random_forest, BDtable, X, Y);
     
    %% SVM
    ACC.SVM(iter,t) = Online_SVM_Evaluation (Online_SVM{1}{1}, BDtable, X, Y);
    
    %% Brain Dynamic table updated
    BDtable = Table_update_with_reservoir_sampling(BDtable, X, Y, t, G);
end
end
save ACC100.mat ACC

PDF_Plot