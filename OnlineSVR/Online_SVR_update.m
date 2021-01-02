function FunT = Online_SVR_update (FunT, X, EST_Y, Y, kernel) 
%% input 
% FunT: the SVR model
% X: the new observed EEG signals from 33 channels
% EST_Y: the estimated response time
% Y: the recorded response time for X
% kernel: kernel parameter
%% Output
% FunT: the updated model

temp_fun = {};
if abs(Y - EST_Y) > kernel.eps
   temp_fun{1,1} = kernel.cost * sign(Y - EST_Y);
   temp_fun{1,2} = X;
else 
   temp_fun{1,1} = {};
end
FunT{end+1} = temp_fun;
