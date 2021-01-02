function EST_Y = Online_SVR_Prediction(FunT, X, Y, kernel)
EST_Y = [];
if length(FunT) == 1
    SVR_V0 = FunT{1};
    EST_Y  = svmpredict(double(Y), double(X), SVR_V0{1});
else
    
    iter = length(FunT);
    eta_t = (iter + 2)^(-kernel.alpha);
    
    SVR_VN = FunT{end};
    temp_Y = []; 
    if isempty(SVR_VN{1,1})
       temp_Y(1) = 0;
    else
        delta_x = SVR_VN{1,2} - X(1,:);
        temp_Y(1)  = SVR_VN{1,1} * exp(-kernel.gamma * delta_x * delta_x' );
    end
    
    Fun_temp = FunT(1:end-1);
    EST_Yt = Online_SVR_Prediction(Fun_temp, X, Y, kernel);
    EST_Y = (1 - eta_t) * EST_Yt + eta_t * temp_Y;
end