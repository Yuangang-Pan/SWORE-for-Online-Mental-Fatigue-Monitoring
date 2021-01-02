function LoR = LOR_Update(mu, sigma, Data, pair)
%% input
% mu: the weight vector
% sigma: the diag variance matrix of the weight vector
% data: EEG Signals
% pair: preference proposition
%% output
% LoR
pair = repmat(pair, 20, 1);
pair = pair(randperm(size(pair,1)), :);
for n = 1 : size(pair,1)
    type = pair(n,1);
    
    ID1 = pair(n,2);
    ID2 = pair(n,3);
    
    X1 = [Data(ID1, :), 1]';
    X2 = [Data(ID2, :), 1]';
        
    [mu, sigma] = type1_LOR(mu, sigma, X1, X2);
  
end

LoR{1} = mu;
LoR{2} = sigma;