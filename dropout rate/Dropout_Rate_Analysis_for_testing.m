clc
clear

Log_test_value = [];
id = [0,1,3,5,7,10,15,20];
for i = 1 : length(id)
    file_name = ['Test_Loglikelihood_', num2str(id(i))];
    load(file_name);
    Log_test_value = [Log_test_value; Test_Loglikelihood{1}];
end

x = 100*(1:size(Log_test_value,2))/size(Log_test_value,2); % percentage
y0 = Log_test_value(1,:); % 1
y1 = Log_test_value(2,:); % 1
y3 = Log_test_value(3,:); % 3
y5 = Log_test_value(4,:); % 5
y7 = Log_test_value(5,:); % 7
y10 = Log_test_value(6,:); % 10
y15 = Log_test_value(7,:); % 15
y20 = Log_test_value(8,:); % 20
plot(x,y0,'color',[0.5,0,0],'LineWidth',2); hold on
plot(x,y1,'r',x,y3,'y',x,y5,'k',x,y7,'m',x,y10,'g',x,y15,'c',x,y20,'b', 'LineWidth',2);
l = legend('Augment-0','Augment-1','Augment-3','Augment-5','Augment-7','Augment-10','Augment-15','Augment-20','location','northeast');
set(l,'Fontsize',15);
title('Data Augmentation Analysis','Fontsize',10,'FontWeight','normal'); % Annotations
xlabel('Percentage of samples (in %)');
ylabel('Negative Log-likelihood (in %)');

set(get(gca,'XLabel'),'FontSize',8);
set(get(gca,'YLabel'),'FontSize',8);
set(gca,'Xtick',[0 20 40 60 80 100],'FontSize',10);
xlim([0 100]);
grid on;
