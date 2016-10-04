clear; close all; clc;

% Define what dt's to test
n_min = 4;
n_max = 50;
n_step = 1;
settings.steps = 30000;

% Initalizations
n_range = n_min:n_step:n_max;
std_Etot = zeros(1,length(n_range));

% Test all the dt's
for i = 1:length(n_range)
	settings.n = n_range(i);
	[x,y,vx,vy,Etot] = guitarstring(settings);
	std_Etot(i) = std(Etot)/mean(Etot);
	fprintf('%i/%i - %.0f%% done\n',i,length(dt_range),round(i/length(dt_range)*100));
end

plot(dt_range,std_Etot,'.-')
title('Dimensionless Standard Deviation of Total Energy')
xlabel('n')
ylabel('\sigma_{E_{tot}}/\langle E_{tot}\rangle')
