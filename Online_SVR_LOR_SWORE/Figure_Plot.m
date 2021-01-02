function Figure_Plot(ACC)

X = 1:size(ACC, 1);
y1 = ACC(:,1);
y2 = ACC(:,2);
y3 = ACC(:,3);

plot(X,y1,'b-X',X,y2,'g-o',X,y3,'r-+','MarkerSize',8, 'LineWidth',1.5);
l = legend('Online SVR','Online LOR', '   SWORE', 'location','southeast');
set(l,'Fontsize',15);
title('Online Mental Fatigue Evaluation','Fontsize',10,'FontWeight','normal'); 
xlabel('Sequencial Trials');
ylabel('Prediction Accuracy');

set(get(gca,'XLabel'),'FontSize',12);
set(get(gca,'YLabel'),'FontSize',12);
set(gca,'Xtick',[26 40 60 80 100 120 140 150],'FontSize',15);
set(gca,'Ytick',[0 0.2 0.4 0.6 0.8 1.0],'FontSize',15);
xlim([26 length(X)]);
ylim([0 1]);
grid on
hold on