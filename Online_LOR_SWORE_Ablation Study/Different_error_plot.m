clc
clear
rng(9159)
load('ACC_temp.mat')
SVR = ACC_temp(:,1);
LOR = ACC_temp(:,2);
SWORE = ACC_temp(:,3);
load('ACC100.mat')
t=15;
SVR = ACC.SVR(t,:)';
LOR = ACC.LOR(t,:)';
SWORE = ACC.SWORE(t,:)';
base = LOR;
SVR_LOR = 100*(SVR- base);
SWORE_LOR = 100*(SWORE-base);
X = 1:length(SVR);
plot(X,SVR_LOR,'r+',X,SWORE_LOR,'bo','MarkerSize',11, 'LineWidth',2);
l = legend('  SVR','SWORE ', 'location','northeast');
set(l,'Fontsize',20);
%title('Online Mental Fatigue Evaluation','Fontsize',25,'FontWeight','normal'); 
xlabel('Sequencial trials');
ylabel('Improvement over LOR (in %)');

set(get(gca,'XLabel'),'FontSize',35);
set(get(gca,'YLabel'),'FontSize',35);
set(gca,'Xtick',[26 50 75 100 125 150],'FontSize',20);
set(gca,'Ytick',[-100 -50 0 50 100],'FontSize',20);
y_max = round(max(SWORE_LOR)/10)*10 + 10;
y_min = round(min(SVR_LOR)/10)*10 - 10;
xlim([26 length(X)]);
ylim([-y_max y_max]);
set(gca,'Ytick',[-80 -60, -40, -20, 0, 20, 40, 60, 80],'FontSize',20);
grid on
hold on

for i = 26 : length(SVR)
    plot([i,i], [0,SVR_LOR(i)] , 'r--','LineWidth',1.7, 'HandleVisibility','off');
    hold on;
    plot([i,i], [0,SWORE_LOR(i)] , 'b-','LineWidth',1.7, 'HandleVisibility','off');
    hold on;
end

SVR_mu = mean(SVR(26:end))*100;
SVR_std = std(SVR(26:end))*100;
LOR_mu = mean(LOR(26:end))*100;
LOR_std = std(LOR(26:end))*100;
SWORE_mu = mean(SWORE(26:end))*100;
SWORE_std = std(SWORE(26:end))*100;
str1=['SVR=', num2str(SVR_mu,3), '$\pm$', num2str(SVR_std,3),'\%'];
str2=['LOR=', num2str(LOR_mu,3), '$\pm$', num2str(LOR_std,3),'\%'];
str3=['SWORE=', num2str(SWORE_mu,3), '$\pm$', num2str(SWORE_std,3),'\%'];
text(35, 69, str1, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold')
text(35, 62, str2, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold')
text(35, 55, str3, 'FontSize', 20, 'interpreter','latex', 'FontWeight', 'bold')


    