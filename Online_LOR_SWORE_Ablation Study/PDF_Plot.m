clc
clear
rng(9159)
load('ACC100.mat')
temp.OffLOR = ACC.OfflineLOR(:,26:end);
temp.LOR = ACC.LOR(:,26:end);
temp.MC_LOR = ACC.MC_LOR(:,26:end);
temp.MC_LOR0 = ACC.MC_LOR0(:,26:end);
temp.SWORE0 = ACC.SWORE0(:,26:end);
temp.OffSWORE = ACC.OffSWORE(:,26:end);
temp.SWORE = ACC.SWORE(:,26:end);

OffLOR = temp.OffLOR(:);
LOR = temp.LOR(:);
MC_LOR = temp.MC_LOR(:);
MC_LOR0 = temp.MC_LOR0(:);
SWORE0 = temp.SWORE0(:);
OffSWORE = temp.OffSWORE(:);
SWORE = temp.SWORE(:);

OffLOR_mu = mean(OffLOR)*100;
OffLOR_std = std(OffLOR)*100;
LOR_mu = mean(LOR)*100;
LOR_std = std(LOR)*100;
MC_LOR_mu = mean(MC_LOR)*100;
MC_LOR_std = std(MC_LOR)*100;
MC_LOR0_mu = mean(MC_LOR0)*100;
MC_LOR0_std = std(MC_LOR0)*100;
SWORE0_mu = mean(SWORE0)*100;
SWORE0_std = std(SWORE0)*100;
OffSWORE_mu = mean(OffSWORE)*100;
OffSWORE_std = std(OffSWORE)*100;
SWORE_mu = mean(SWORE)*100;
SWORE_std = std(SWORE)*100;