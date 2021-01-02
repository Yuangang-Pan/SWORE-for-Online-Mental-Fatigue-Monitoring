clc
clear
subplot(1,2,1)
n = 6;
t = 0.5;
x00 = [-n : 0.001 : -0.01];
x01 = [0.01 : 0.001 : n];
x1 = [-n : 0.001 : -(t -0.01)];
x2 = [(t -0.01) : 0.001 : n];
x3 = [-t : 0.01 : t];
x4 = [-t : 0.01 : t];
x50 = [-t : 0.001 :  t];
x51 = [t : -0.001 : -t];

y00 = 0 * ones(size(x00));
y01 = 1 * ones(size(x01));
y1 = 1 ./ (1 + exp(-x1));
y2 = 1 ./ (1 + exp(-x2));
y3 = 1 ./ (1 + exp(-x3));
y4 = sqrt(y3 .* (1-y3));
y50 = 1/(1+exp((t -0.01)))* ones(size(x50));
y51 = 1/(1+exp(-(t -0.01)))* ones(size(x50));

plot(x00, y00, 'k-', x1, y1, 'b-',  x4, y4, 'r-', 'LineWidth',2.75);
hold on;
fill([x50, x51], [y50, y51],'r','EdgeColor','none','facealpha',0.25)
hold on;
plot(x01, y01, 'k-', x2, y2, 'b-',x3, y3, 'g--', 'LineWidth',2.75);
%plot(x01, y01, 'k-', x2, y2, 'b-', 'LineWidth',2.75);
hold on
plot(0, 0, 'ko','LineWidth',2.75);
hold on;
plot(-t, 1/(1+exp(t)), 'bo','LineWidth',2.75);
hold on;
plot(t, 1/(1+exp(-t)), 'bo','LineWidth',2.75);
hold on;

l1 = legend('\ \ Optimal Classifier', ['$$\sigma(x) = \frac{1}{1 + exp(-x)}$$'],['\quad $$\sqrt{\sigma(x)\sigma(-x)}$$'],...
    '\quad Insensitive Zone', 'location','northwest');
set(l1,'interpret','latex','Fontsize',18);
hold on;

ax = gca;
ax.Box = 'off';

annotation('arrow',[0.131 0.131],[0.89 1]); 
annotation('arrow',[0.89 0.96],[0.111 0.111]);
text(6.3,0.04,'x' ,'FontSize',25)
text(-5.8,1.04,'P(y|x)' ,'FontSize',25)
grid on;
axis on;

set(gca,'Xtick', [-6, -4, -2, 0, 2, 4, 6], 'FontSize',25);
set(gca,'Ytick',[0 : 0.2 : 1], 'FontSize',25);
xlim([-n, n]);
ylim([0 1]);


subplot(1,2,2)
n = 6;
t = 0.5;
x00 = [-n : 0.001 : -0.01];
x01 = [0.01 : 0.001 : n];
x1 = [-n : 0.001 : -(t -0.01)];
x2 = [(t -0.001) : 0.01 : n];
x3 = [-t : 0.01 : t];
x4 = [-t : 0.01 : t];
x50 = [-t : 0.001 :  t];
x51 = [t : -0.001 : -t];

y00 = 0 * ones(size(x00));
y01 = 0 * ones(size(x01));
y1 = 1 ./ (1 + exp(-x1));
y1 = y1 .* (1-y1);
y2 = 1 ./ (1 + exp(-x2));
y2 = y2 .* (1-y2);
y3 = 1 ./ (1 + exp(-x3));
y3 = y3 .* (1-y3);
y4 = - 0.5 * sqrt(y3) .* y3;
y50 = -0.07* ones(size(x50));
y51 = 0.255* ones(size(x50));

plot(x00, y00, 'k-', x1, y1, 'b-',  x4, y4, 'r-', 'LineWidth',2.75);
hold on;
fill([x50, x51], [y50, y51],'r','EdgeColor','none','facealpha',0.25)
hold on;
plot(x01, y01, 'k-', x2, y2, 'b-',x3, y3, 'g--', 'LineWidth',2.75);
%plot(x01, y01, 'k-', x2, y2, 'b-', 'LineWidth',2.75);
hold on
plot(0, 0, 'ko','LineWidth',2.75);
hold on;
plot(-t, 1/(1+exp(t)) * 1/(1+exp(-t)), 'bo','LineWidth',2.75);
hold on;
plot(t, 1/(1+exp(t)) * 1/(1+exp(-t)), 'bo','LineWidth',2.75);
hold on;

l1 = legend('\ \ Optimal Classifier', ['$$\sigma(x) = \frac{1}{1 + exp(-x)}$$'],['\quad $$\sqrt{\sigma(x)\sigma(-x)}$$'],...
    '\quad Insensitive Zone', 'location','northwest');
set(l1,'interpret','latex','Fontsize',18);
hold on;

ax = gca;
ax.Box = 'off';

text(6.3,0.04,'x' ,'FontSize',25)
text(-5.8,0.365,'dP(y|x)/dx','FontSize',25)
grid on;
axis on;

set(gca,'Xtick', [-6, -4, -2, 0, 2, 4, 6], 'FontSize',25);
set(gca,'Ytick',[-0.1: 0.1 : 4], 'FontSize',25);
xlim([-n, n]);
ylim([-0.1 0.35]);

