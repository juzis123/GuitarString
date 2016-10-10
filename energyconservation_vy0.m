clear; close all; clc;

% Define what dt's to test
vy0_min = 1e-3;
vy0_max = 2e0;
vy0_step = 1e-2;
settings.steps = 30000;
settings.dt = 1e-3;

% Initalizations
vy0_range = vy0_min:vy0_step:vy0_max;
n_sims = length(vy0_range);
std_Etot = zeros(1,n_sims);

% Test all the dt's
for i = 1:n_sims
	settings.vy0 = vy0_range(i);
	[~,~,~,~,Etot] = guitarstring(settings);
	std_Etot(i) = std(Etot)/mean(Etot);
	fprintf('%i/%i - %.0f%% done\n',i,n_sims,round(i/n_sims*100));
end

% Plot the relation
plot(vy0_range,std_Etot,'.-')
title('Dimensionless Standard Deviation of Total Energy')
xlabel('v_{y,0}')
ylabel('\sigma_{E_{tot}}/\langle E_{tot}\rangle')
