function model = Embryonic_random_forest(EEG, RT)
% EEG: the EEG signals
% RT: the response time
rng(9159)
%% Parameter Setting
BD_preference = task_generation(RT);
feat = EEG(BD_preference(:,3), :) - EEG(BD_preference(:,2), :);

%% random switch the label of 50% data
id = rand(size(feat,1),1)>0.5;
feat(id==0,:) = -1 * feat(id==0,:);
model = TreeBagger(5,feat,id,'OOBPred','On','Method','classification');