clc
clear
rng(9159)
path('..//libsvm_matlab', path);
path('..//EEG_Data', path);
Data_dir=dir(['..//EEG_Data/','Data_*.mat']);
num_subdir = length(Data_dir);
Iter_num = 100;
K = 25; % BDtable size
G = 10;


Full_ACC = {};

for Sub = 41 : 50 %num_subdir
    fprintf('Subject:%3d\n', Sub)

    Data_file = ['Data_', num2str(Sub), '.mat'];
    RT_file = ['RT_', num2str(Sub), '.mat'];

    load(Data_file);
    load(RT_file);
    T = size(data, 3);

    EEG_data = [];
    for k = 1 : size(data,3)
        temp = data(:,:,k);
        EEG_data = [EEG_data; temp(:)'];
    end
    ACC = {};
    for iter = 1 : Iter_num
        fprintf('iter%3d\n', iter)
        SG_BDtable = {};
        BDtable = {};
        SG_BDtable.EEG = EEG_data(1:K,:);
        SG_BDtable.RT = RT(1:K);
        BDtable.EEG = data(:,:,1:K);
        BDtable.RT = RT(1:K);
        BDtable.ratio = 0.5; % dropout rate
        BDtable.AUG = 1; % the number of data augmentation

        %Embryonic SVR
        X0 = EEG_data(1:K,:);
        Y0 = RT(1:K);
        bestCV = '-s 3 -t 2';
        SVR{1} =  Embryonic_SVR(X0, Y0, bestCV);
        %Embryonic LOR
        Online_LOR =  Embryonic_LOR(SG_BDtable);
        %Embryonic SWORE
        [SWORE.mu, SWORE.sigma, SWORE.alpha] =  Embryonic_SWORE(BDtable);


        % Brain Dynamic Table
        ID = randperm(K,G);
        SG_BDtable.EEG = EEG_data(ID,:);
        SG_BDtable.RT = RT(ID);
        BDtable.EEG = data(:,:,ID);
        BDtable.RT = RT(ID);
        BDtable.AUG = 2; % the number of data augmentation

        for t = K+1 : T
            X = EEG_data(t,:);
            feat = data(:,:,t);
            Y =  RT(t);
            %% SVR
            % Prediction
            EST_Y  = svmpredict(double(Y), double(X), SVR{1}{1});
            % Evaluation
            ACC.SVR(iter,t) = SVR_Evaluation (EST_Y, SG_BDtable,  Y);
    
            %% Online LOR
            % Online Evaluation
            ACC.LOR(iter,t) = Online_LOR_Evaluation (Online_LOR, SG_BDtable, X, Y);
            % Online Robust Update
            Online_LOR = Online_LOR_update (Online_LOR, SG_BDtable, X, Y);  
    
            %% Online Learning for SWORE
            % Online Evaluation
            ACC.SWORE(iter,t) = Online_SWORE_Evaluation (SWORE, BDtable, feat, Y);
            % Online Robust Update
            SWORE = Online_SWORE_update (SWORE, BDtable, feat, Y);  
    
            %% Brain Dynamic table updated
           [SG_BDtable, BDtable] = Table_update_with_reservoir_sampling (SG_BDtable, BDtable, X, feat, Y, t, G);
        end
    end
    Full_ACC{Sub} = ACC;
end

save Full_ACC50.mat Full_ACC