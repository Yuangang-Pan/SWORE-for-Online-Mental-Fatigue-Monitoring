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
SVR_mu = mean(SVR)*100;
SVR_std = std(SVR)*100;
LOR_mu = mean(LOR)*100;
LOR_std = std(LOR)*100;
SWORE_mu = mean(SWORE)*100;
SWORE_std = std(SWORE)*100;
% fix the area
x = 0:0.01:1;
w = 0.055;
f_SVR = ksdensity(SVR, x, 'Bandwidth', w);
f_SVR = f_SVR/sum(f_SVR*0.01);
f_LOR = ksdensity(LOR, x, 'Bandwidth', w);
f_LOR = f_LOR/sum(f_LOR*0.01);
f_SWORE = ksdensity(SWORE, x, 'Bandwidth', w);
f_SWORE = f_SWORE/sum(f_SWORE*0.01);
x = 100*x;

subplot(1,2,1)
plot(x,f_SVR,'r-',x,f_LOR,'g-',x,f_SWORE,'k-','LineWidth',2.5);
l = legend('  SVR','  LOR','SWORE','location','northwest');
set(l,'Fontsize',20);
xlabel('Precition accuracy (in %)');
ylabel('Probability density functon (PDF)');
set(get(gca,'XLabel'),'FontSize',30);
set(get(gca,'YLabel'),'FontSize',30);
set(gca,'Xtick',[0 20 40 60 80 100],'FontSize',20);
hold on
%% Add the maxumum value
[V1,Id1] = max(f_SVR);
str = ['(', num2str(Id1), ',' num2str(V1,3), ')'];
text(Id1-1,V1+0.03, str, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold','HorizontalAlignment', 'center')
[V2,Id2] = max(f_LOR);
str = ['(', num2str(Id2), ',' num2str(V2,3), ')'];
text(Id2-1,V2+0.03, str, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold', 'HorizontalAlignment', 'center')
[V3,Id3] = max(f_SWORE);
str = ['(', num2str(Id3), ',' num2str(V3,3), ')'];
text(Id3-1,V3+0.03, str, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold', 'HorizontalAlignment', 'center')

str1=['SVR=', num2str(SVR_mu,3), '$\pm$', num2str(SVR_std,3),'\%'];
str2=['LOR=', num2str(LOR_mu,3), '$\pm$', num2str(LOR_std,3),'\%'];
str3=['SWORE=', num2str(SWORE_mu,3), '$\pm$', num2str(SWORE_std,3),'\%'];
text(3, 1.75, str1, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold')
text(3, 1.65, str2, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold')
text(3, 1.55, str3, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold')

xlim([0 100]);
ylim([0 2.5]);
hold on;
grid on;

subplot(1,2,2)
C_SVR = cumsum(f_SVR)/100;
C_LOR = cumsum(f_LOR)/100;
C_SWORE = cumsum(f_SWORE)/100;
plot(x,C_SVR,'r-',x,C_LOR,'g-',x,C_SWORE,'k-','LineWidth',2.5);
l = legend('  SVR','  LOR','SWORE','location','northwest');
set(l,'Fontsize',20);
xlabel('Precition accuracy (in %)');
ylabel('Cumulative distribution function (CDF)');
set(get(gca,'XLabel'),'FontSize',30);
set(get(gca,'YLabel'),'FontSize',30);
set(gca,'Xtick',[0 20 40 60 70 80 100],'FontSize',20);
set(gca,'Ytick',[0 0.2 0.4 0.5 0.6 0.8 1],'FontSize',20);
hold on
%% Add the maxumum value
plot([0,100], [0.5, 0.5], 'b--', 'LineWidth',1.7, 'HandleVisibility','off');
plot([70,70], [0, 1], 'b--', 'LineWidth',1.7, 'HandleVisibility','off');
hold on 
Id1 = sum(C_SVR < 0.5);
text(Id1,0.5, '$x_1$', 'FontSize', 25, 'Color', 'red', 'interpreter','latex', 'FontWeight', 'bold', 'HorizontalAlignment', 'center')
Id2 = sum(C_LOR < 0.5);
text(Id2,0.51, '$x_2$', 'FontSize', 25, 'Color', 'red','interpreter','latex', 'FontWeight', 'bold', 'HorizontalAlignment', 'center')
Id3 = sum(C_SWORE < 0.5);
text(Id3,0.49, '$x_3$', 'FontSize', 25, 'Color', 'red','interpreter','latex')
Id4 = C_SVR(70);
text(70, Id4, '$y_1$', 'FontSize', 25, 'Color', 'red','interpreter','latex', 'FontWeight', 'bold' , 'HorizontalAlignment', 'center')
Id5 = C_LOR(70);
text(70, Id5, '$y_2$', 'FontSize', 25, 'Color', 'red','interpreter','latex', 'FontWeight', 'bold', 'HorizontalAlignment', 'center')
Id6 = C_SWORE(70);
text(70, Id6, '$y_3$', 'FontSize', 25, 'Color', 'red','interpreter','latex', 'FontWeight', 'bold', 'HorizontalAlignment', 'center')

str1=['$x_1$=', num2str(Id1), '\%,    $x_2$=', num2str(Id2),'\%,    $x_3$=', num2str(Id3), '\%'];
str2=['$y_1$=', num2str(Id4,2), ', $y_2$=', num2str(Id5,2),', $y_3$=', num2str(Id6,2)];
text(5, 0.65, str1, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold')
text(5, 0.6, str2, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold')


xlim([0 100]);
ylim([0 1]);
hold on;
grid on;