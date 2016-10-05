clear; close all; clc;

% Define what dt's to test
n_min = 3;
n_max = 60;
n_step = 1;
settings.steps = 30000;
settings.vy0 = 0.2;
settings.

% Initalizations
n_range = n_min:n_step:n_max;
std_Etot = zeros(1,length(n_range));

% Test all the dt's
for i = 1:length(n_range)
	settings.n = n_range(i);
	[~,~,~,~,Etot] = guitarstring(settings);
	std_Etot(i) = std(Etot)/mean(Etot);
	fprintf('%i/%i - %.0f%% done\n',i,length(n_range),round(i/length(n_range)*100));
end

% Plot the relation
plot(n_range,std_Etot,'.-')
title('Normalized Standard Deviation of Total Energy')
xlabel('n')
ylabel('\sigma_{E_{tot}}/\langle E_{tot}\rangle')
