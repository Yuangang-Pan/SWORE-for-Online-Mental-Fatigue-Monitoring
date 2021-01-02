function model = Embryonic_SVR(EEG, RT, cmd)
% EEG: the EEG signals
% RT: the response time
% cmd: the kernel information

%% Parameter Setting
model = {};
Y = RT';
model{1} = svmtrain(double(Y), double(EEG), cmd);