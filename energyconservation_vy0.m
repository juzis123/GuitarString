clear; close all; clc;

% Define what dt's to test
vy0_min = 1e-3;
vy0_max = 1e0;
vy0_step = 1e-3;
settings.steps = 30000;
settings.dt = 2e-3;

% Initalizations
dt_range = dt_min:dt_step:dt_max;
std_Etot = zeros(1,length(dt_range));

% Test all the dt's
for i = 1:length(dt_range)
	settings.dt = dt_range(i);
	[~,~,~,~,Etot] = guitarstring(settings);
	std_Etot(i) = std(Etot)/mean(Etot);
	fprintf('%i/%i - %.0f%% done\n',i,length(dt_range),round(i/length(dt_range)*100));
end

% Plot the relation
plot(dt_range,std_Etot,'.-')
title('Dimensionless Standard Deviation of Total Energy')
xlabel('dt')
ylabel('\sigma_{E_{tot}}/\langle E_{tot}\rangle')
