function RT_test = Support_Vector_Regression(Y_train, X_train, Y_test, X_test);

%% libsvm parameters
% -s: 3 | 4  
% -t: 2 | 3
%% for ground_truth
bestcv = inf;
for SVR = 3 : 4
    for log2c = -5 : 5
        for log2g = -5 : 5
            for eps = 0.1 : 0.2 : 1
                for type = 2 : 3
                        cmd = ['-s ',num2str(SVR),' -t ',num2str(type),' -g ',...
                                     num2str(2^log2g),' -c ',num2str(2^log2c),...
                                     ' -p ',num2str(eps),' -b 1 -h 0'];
                    CV = svmtrain(Y_train, X_train, cmd);    
                    [~, ACC, ~] = svmpredict(Y_train, X_train, CV);
                    if (ACC(2) <= bestcv) 
                        bestcv = ACC(2);
                        bests = SVR;
                        bestt = type;
                        bestg = 2^log2g;
                        bestc = 2^log2c;
                        bestp = eps;
                    end
                end
            end
        end
    end
end
cmd = ['-s ',num2str(bests),' -t ',num2str(bestt),' -g ',num2str(bestg),' -c ',num2str(bestc),' -p ',num2str(bestp),' -b 1'];

model = svmtrain(Y_train, X_train, cmd);
[RT_test, ACC, prob] = svmpredict(Y_test, X_test, model);