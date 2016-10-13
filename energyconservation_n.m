% Normalized Standard Deviation of Total Energy as a function of number of nodes
% Runs simulation for different number of nodes
clear; close all; clc;

% Define what n's to test
n_min = 3;								% Minimum number of nodes
n_max = 240;							% Maximum number of nodes
n_step = 1;								% Number of nodes step
settings.steps = 30000;					% Number of simulation time steps

% Initalizations
n_range = n_min:n_step:n_max;			% Generate number of nodes range
std_Etot = zeros(1,length(n_range));	% Initialize normalized std of Etot array

% Test all the n's
for i = 1:length(n_range)				% Loop over all numbers of nodes
	settings.n = n_range(i);			% Apply n in settings
	[~,~,~,~,Etot] = guitarstring(settings);	% Do simulation
	std_Etot(i) = std(Etot)/mean(Etot);	% Calculate norm std of Etot
	
	% Clear console and show progress
	clc
	fprintf('%i/%i - %.0f%% done\n',i,length(n_range),round(i/length(n_range)*100));
end

% Plot the relation
plot(n_range,std_Etot,'.-')
title('Normalized Standard Deviation of Total Energy')
xlabel('n')
ylabel('\sigma_{E_{tot}}/\langle E_{tot}\rangle')
