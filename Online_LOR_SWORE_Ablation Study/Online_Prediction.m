clc
clear
rng(9159)
load('Data.mat')
load('RT.mat')
path('..//libsvm_matlab', path);
ACC = {};
    
K = 25; % BDtable size
G = 10;
T = size(Data, 3);

EEG_data = [];
for k = 1 : size(Data,3)
    temp = Data(:,:,k);
    EEG_data = [EEG_data; temp(:)'];
end

SG_BDtable.EEG = EEG_data(1:K,:);
SG_BDtable.RT = RT(1:K);
BDtable.EEG = Data(:,:,1:K);
BDtable.RT = RT(1:K);
BDtable.ratio = 0.5; % dropout rate
BDtable.AUG = 1; % the number of data augmentation

%Embryonic LOR
LOR =  Embryonic_LOR(SG_BDtable);
LOR_Original = LOR;
%Embryonic SWORE without Steady State
[MC_LOR.mu, MC_LOR.sigma, MC_LOR.alpha] =  Embryonic_MC_LOR(BDtable);
%Embryonic SWORE without dropout
BDtable_zero = BDtable;
BDtable_zero.ratio = 0;
[SWORE0.mu, SWORE0.sigma, SWORE0.alpha] =  Embryonic_MC_LOR(BDtable_zero);
%Embryonic SWORE
[SWORE.mu, SWORE.sigma, SWORE.alpha] =  Embryonic_SWORE(BDtable);
SWORE_Original = SWORE;

% Brain Dynamic Table
ID = randperm(K,G);
SG_BDtable.EEG = EEG_data(ID,:);
SG_BDtable.RT = RT(ID);
BDtable.EEG = Data(:,:,ID);
BDtable.RT = RT(ID);
BDtable.AUG = 3; % the number of data augmentation

ACC = [];
for t = K+1 : T
    X = EEG_data(t,:);
    feat = Data(:,:,t);
    Y =  RT(t); 
    %% LOR
    % offline Evaluation
    ACC(t,1) = Online_LOR_Evaluation (LOR_Original, SG_BDtable, X, Y);
    % online Evaluation
    ACC(t,2) = Online_LOR_Evaluation (LOR, SG_BDtable, X, Y);
    % Online Robust Update
    LOR = Online_LOR_update (LOR, SG_BDtable, X, Y);  
    
    %% SWORE without Steady State only
    % online Evaluation
    ACC(t,3) = Online_SWORE_Evaluation (MC_LOR, BDtable, feat, Y);
    % Online Robust Update
    MC_LOR = Online_SWORE_update (MC_LOR, BDtable, feat, Y); 
    
    %% SWORE without dropout only
    BDtable_zero = BDtable;
    BDtable_zero.ratio = 0;
    % online Evaluation
    ACC(t,4) = Online_SWORE_Evaluation (SWORE0, BDtable_zero, feat, Y);
    % Online Robust Update
    SWORE0 = Online_SWORE_update (SWORE0, BDtable_zero, feat, Y); 
    
    %% SWORE
    % offline Evaluation
    ACC(t,5) = Online_SWORE_Evaluation (SWORE_Original, BDtable, feat, Y);
    % online Evaluation
    ACC(t,6) = Online_SWORE_Evaluation (SWORE, BDtable, feat, Y);
    % Online Robust Update
    SWORE = Online_SWORE_update (SWORE, BDtable, feat, Y);  
    
    %% Brain Dynamic table updated
    [SG_BDtable, BDtable] = Table_update_with_reservoir_sampling (SG_BDtable, BDtable, X, feat, Y, t, G);
end
mean(ACC(K+1:end,:))
save ACC_temp.mat ACC