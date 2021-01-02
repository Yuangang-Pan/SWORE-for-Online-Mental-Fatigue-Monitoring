clc
clear
rng(194)
addpath(genpath('/home/yuangang/Yuangang-NeCo2020/Online_SWORE/EEGLab'));

load('SWORE_Results.mat')
load('Pis.mat')
load('chanlocs.mat')

%% Channel Reliability Showcase
Pi = SWORE.alpha;
Pi = Pi./ repmat(sum(Pi,2), 1, size(Pi,2));
Pi = Pi';
Idx = [1:22, 24:28, 30:32];
[~,id] = max(mean(Pi,2));
value = 2*Pi(id,:)'-1;
value = 1./ (1 + ((1-value)./value).^2);
channel_value = value(Idx);
topoplot(channel_value, EEG.chanlocs)
colormap('jet')
colorbar
caxis([0,1]);

figure
load('s01_051017m_epoch.mat')
label = {chanlocs.labels};
label{33} = 'VP';
a = ((value +1)/2)';
Pi = [a;1-a];
[M,N] = size(Pi);
imagesc(Pi); % plot the matrix
xlabel('Channel index');
set(get(gca,'XLabel'),'FontSize',25);
ylabel('Channel reliability');
set(get(gca,'YLabel'),'FontSize',25);
set(gca, 'XTick', 1:N); % center x-axis ticks on bins
set(gca, 'YTick', 1:M); % center y-axis ticks on bins
set(gca, 'XTickLabel', label, 'FontSize',15, 'XTickLabelRotation', 90); % set x-axis labels
L = {'Positive', 'Negative'};
set(gca, 'YTickLabel', L, 'FontSize',25, 'YTickLabelRotation', 90); % set y-axis labels
colormap('jet')
colorbar

caxis([0,1]);

