clc
clear
rng(9159)
load('ACC200.mat')
temp.SVR = ACC.SVR(:,26:end);
temp.LOR = ACC.LOR(:,26:end);
temp.SWORE = ACC.SWORE(:,26:end);

SVR = temp.SVR(:);
LOR = temp.LOR(:);
SWORE = temp.SWORE(:);
[h1,p1,c1] = ttest2(SWORE, LOR, 'Vartype','unequal');
[h2,p2,c2] = ttest2(SWORE, SVR, 'Vartype','unequal');
[h3,p3,c3] = ttest2(LOR, SVR, 'Vartype','unequal');

N = size(SVR, 1);
ySEM = std(SVR)/sqrt(N);                             
CI95 = tinv([0.025 0.975], N-1);                
yCI95 = bsxfun(@times, ySEM, CI95(:));         
SVR_95 = yCI95 + mean(SVR);             

N = size(LOR, 1);
ySEM = std(LOR)/sqrt(N);                              % Compute ?Standard Error Of The Mean? Of All Experiments At Each Value Of ?x?
CI95 = tinv([0.025 0.975], N-1);                    % Calculate 95% Probability Intervals Of t-Distribution
yCI95 = bsxfun(@times, ySEM, CI95(:));              % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ?x?
LOR_95 = yCI95 + mean(LOR);

N = size(SWORE, 1);
ySEM = std(SWORE)/sqrt(N);                              % Compute ?Standard Error Of The Mean? Of All Experiments At Each Value Of ?x?
CI95 = tinv([0.025 0.975], N-1);                    % Calculate 95% Probability Intervals Of t-Distribution
yCI95 = bsxfun(@times, ySEM, CI95(:));              % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ?x?
SWORE_95 = yCI95 + mean(SWORE);