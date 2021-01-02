function model = Embryonic_SVM(EEG, RT, cmd)
% EEG: the EEG signals
% RT: the response time
% cmd: the kernel information
rng(9159)
%% Parameter Setting
BD_preference = task_generation(RT);
feat = EEG(BD_preference(:,3), :) - EEG(BD_preference(:,2), :);
label = BD_preference(:,1);

%% random switch the label of 50% data
id = rand(size(feat,1),1)>0.5;
feat(id==0,:) = -1 * feat(id==0,:);

model = {};
model{1} = svmtrain(double(id), double(feat), cmd);