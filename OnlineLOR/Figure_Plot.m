function Figure_Plot(ACC)

X = 1:size(ACC, 1);
y1 = ACC(:,1);
y2 = ACC(:,2);
y3 = ACC(:,3);
y4 = ACC(:,4);

subplot(2,2,1);
plot(X,y1,'b',X,y4,'r','LineWidth',1.2);
l = legend('MO-TO','MN-TN','location','southeast');
set(l,'Fontsize',15);
title('Fixed or Updated Table wiht Fixed Model','Fontsize',10,'FontWeight','normal'); 
xlabel('Sequencial Trials');
ylabel('Prediction Accuracy');

set(get(gca,'XLabel'),'FontSize',8);
set(get(gca,'YLabel'),'FontSize',8);
set(gca,'Xtick',[20 40 60 80 100 120 140 160],'FontSize',10);
set(gca,'Ytick',[0 0.2 0.4 0.6 0.8 1.0],'FontSize',10);
xlim([2 length(X)]);
ylim([0 1]);
grid on
hold on

subplot(2,2,2);
plot(X,y2,'c',X,y4,'r','LineWidth',1.5);
l = legend('MN-TO','MN-TN','location','southeast');
set(l,'Fontsize',15);
title('Fixed or Updated Table with Updated Model','Fontsize',10,'FontWeight','normal'); 
xlabel('Sequencial Trials');
ylabel('Prediction Accuracy');

set(get(gca,'XLabel'),'FontSize',8);
set(get(gca,'YLabel'),'FontSize',8);
set(gca,'Xtick',[20 40 60 80 100 120 140 160],'FontSize',10);
set(gca,'Ytick',[0 0.2 0.4 0.6 0.8 1.0],'FontSize',10);
xlim([2 length(X)]);
ylim([0 1]);
grid on

subplot(2,2,3);
plot(X,y3,'g',X,y4,'r','LineWidth',1.5);
l = legend('MO-TN','MN-TN','location','southeast');
set(l,'Fontsize',15);
title('Fixed or Updated Table with Updated Model','Fontsize',10,'FontWeight','normal'); 
xlabel('Sequencial Trials');
ylabel('Prediction Accuracy');

set(get(gca,'XLabel'),'FontSize',8);
set(get(gca,'YLabel'),'FontSize',8);
set(gca,'Xtick',[20 40 60 80 100 120 140 160],'FontSize',10);
set(gca,'Ytick',[0 0.2 0.4 0.6 0.8 1.0],'FontSize',10);
xlim([2 length(X)]);
ylim([0 1]);
grid on