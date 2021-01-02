function [mu_new, sigma_new, alpha_new] = BMM_Update(mu, sigma, alpha, Data, pair, ratio, AUG)
%% input
% mu: the weight vector
% sigma: the diag variance matrix of the weight vector
% alpha: [a,b] Gamma bariable of the worker quality
% data: EEG Signals
% pair: the type-1 and type-2 preference proposition
% ratio: dropout rate for the weight w
% AUG: the number of data augmentation
%% output
% mu_new: the updated weight
% sigma_new: the updated variance matrix
% alpha_new: the updated channel reliability
pair = repmat(pair, 3,1);
pair = pair(randperm(size(pair,1)), :);
for n = 1 : size(pair,1)
    type = pair(n,1);
    ID1 = pair(n,2);
    ID2 = pair(n,3);
    for W_ID = 1 : size(Data, 1)
        X1 = [Data(W_ID, :, ID1), 1]';
        X2 = [Data(W_ID, :, ID2), 1]';
    
        if  type == 1
            [mu, sigma, alpha(W_ID, :)] = type1_onlineBMM(mu, sigma, alpha(W_ID, :), X1, X2, ratio, AUG);
        else
            [mu, sigma] = type2_onlineBMM(mu, sigma, X1, X2, ratio, AUG);
        end
    end
    
end

mu_new = mu;
sigma_new = sigma;
alpha_new = alpha;