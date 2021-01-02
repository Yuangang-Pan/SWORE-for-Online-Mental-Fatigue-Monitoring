clc
clear
rng(9159)
load('Data.mat')
load('RT.mat')

K = 20; % BDtable size
G = 10;
T = size(Data, 3);

EEG_data = [];
for k = 1 : size(Data,3)
    temp = Data(:,:,k);
    EEG_data = [EEG_data; temp(:)'];
end

%Embryonic SVM
X0 = EEG_data(1:K,:);
Y0 = RT(1:K);
random_forest =  Embryonic_random_forest(X0, Y0);

% Brain Dynamic Table
ID = randperm(K,G);
BDtable.EEG = EEG_data(ID,:);
BDtable.RT = RT(ID);

% kernel defination
ACC = zeros(1,K);
for t = K+1 : T
    X = EEG_data(t,:);
    Y =  RT(t);
 
    %% offline Mental Fatigue Evaluation
    ACC(t) = Online_random_forest_Evaluation(random_forest, BDtable, X, Y);
    
    %% Online Robust Update
    BDtable = Table_update_with_reservoir_sampling(BDtable, X, Y, t, G);
end
plot(1:T, ACC)
ACC = mean(ACC(K+1:end))
