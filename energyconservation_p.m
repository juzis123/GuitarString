clear; close all; clc;

% Define what dt's to test
settings.n = 125;
p_min = 2;
p_max = settings.n-1;
p_step = 1;
settings.steps = 30000;

% Initalizations
p_range = p_min:p_step:p_max;
n_sims = length(p_range);
std_Etot = zeros(1,n_sims);

% Test all the dt's
for i = 1:length(p_range)
	settings.p = p_range(i);
	[~,~,~,~,Etot] = guitarstring(settings);
	std_Etot(i) = std(Etot)/mean(Etot);
	clc
	fprintf('%i/%i - %.0f%% done\n',i,n_sims,round(i/n_sims*100));
end

% Plot the relation
plot(p_range,std_Etot,'.-')
title('Normalized Standard Deviation of Total Energy')
xlabel('p')
ylabel('\sigma_{E_{tot}}/\langle E_{tot}\rangle')
