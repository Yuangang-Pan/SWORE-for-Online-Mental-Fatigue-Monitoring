clc
clear
subplot(2,1,1)
%% training likelihood
Log_train_value = [];
id = [0,1,3,5];
for i = 1 : length(id)
    file_name = ['Train_Loglikelihood_', num2str(id(i))];
    load(file_name);
    Log_train_value = [Log_train_value; Train_Loglikelihood{1}];
end

x = 100*(1:size(Log_train_value,2))/size(Log_train_value,2); % percentage
y0 = Log_train_value(1,:); % 1
y1 = Log_train_value(2,:); % 1
y3 = Log_train_value(3,:); % 3
y5 = Log_train_value(4,:); % 5
% y7 = Log_train_value(5,:); % 7
% y10 = Log_train_value(6,:); % 10
% y15 = Log_train_value(7,:); % 15
% y20 = Log_train_value(8,:); % 20
plot(x,y0, 'r-', x,y1,'k-',x,y3,'b-',x,y5,'g-', 'LineWidth',2);
l = legend('Aug-0','Aug-1','Aug-3','Aug-5','location','northeast');
set(l,'Fontsize',15);
xlabel('Percentage of samples (in %)');
ylabel('Negative Log-likelihood (Train)');

set(get(gca,'XLabel'),'FontSize',16);
set(get(gca,'YLabel'),'FontSize',16);
set(gca,'Xtick',[0 20 40 60 80 100],'FontSize',14);
xlim([0 100]);
grid on;
hold on;

subplot(2,1,2)
%% test likelihood
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
% y7 = Log_test_value(5,:); % 7
% y10 = Log_test_value(6,:); % 10
% y15 = Log_test_value(7,:); % 15
% y20 = Log_test_value(8,:); % 20
plot(x,y0, 'r-', x,y1,'k-',x,y3,'b-',x,y5,'g-', 'LineWidth',2);
%l = legend('Augment-0','Augment-1','Augment-3','Augment-5','Augment-7','Augment-10','Augment-15','Augment-20','location','northeast');
set(l,'Fontsize',15);
xlabel('Percentage of samples (in %)');
ylabel('Negative Log-likelihood (Test)');

set(get(gca,'XLabel'),'FontSize',16);
set(get(gca,'YLabel'),'FontSize',16);
set(gca,'Xtick',[0 20 40 60 80 100],'FontSize',14);
xlim([0 100]);
grid on;