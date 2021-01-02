clc
clear
rng(9159)
load('Data.mat')
load('RT.mat')
load('bestCV.mat')
path('..//libsvm_matlab', path);

K = 20; % BDtable size
G = 10;
T = size(Data, 3);

EEG_data = [];
for k = 1 : size(Data,3)
    temp = Data(:,:,k);
    EEG_data = [EEG_data; temp(:)'];
end

%Embryonic SVR
X0 = EEG_data(1:K,:);
Y0 = RT(1:K);
bestCV = '-s 3 -t 2';
Online_SVR{1} =  Embryonic_SVR(X0, Y0, bestCV);

% Brain Dynamic Table
ID = randperm(K,G);
BDtable.EEG = EEG_data(ID,:);
BDtable.RT = RT(ID);

% kernel defination
kernel.gamma = 0.03125;
kernel.cost = 32;
kernel.type = 2;
kernel.eps = 0.5;
kernel.alpha = 0.55;
ACC = zeros(1,K);
Online_ACC = zeros(1,K);
for t = K+1 : T
    X = EEG_data(t,:);
    Y =  RT(t);
    

    %% offline Prediction
    EST_Y0  = svmpredict(double(Y), double(X), Online_SVR{1}{1});
    %% offline Mental Fatigue Evaluation
    ACC(t) = Online_SVR_Evaluation (EST_Y0, BDtable,  Y);
    
    %% Online Prediction
    EST_Y1 = Online_SVR_Prediction(Online_SVR, X, Y, kernel);
    %% Online Mental Fatigue Evaluation
    Online_ACC(t) = Online_SVR_Evaluation (EST_Y1, BDtable,  Y);

    %% Online Robust Update
    Online_SVR = Online_SVR_update (Online_SVR, X, EST_Y1, Y, kernel);  
    BDtable = Table_update_with_reservoir_sampling (BDtable, X, Y, t, G);
end
plot(1:T, Online_ACC-ACC)
Online_ACC = mean(Online_ACC(K+1:end))
ACC = mean(ACC(K+1:end))
