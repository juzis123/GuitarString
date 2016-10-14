% Judith Zissoldt (s1332171) and Daniel Cox (s1228579)
% Normalized Standard Deviation of Total Energy as a function of picking position
% Runs simulation for different picking positions
clear; close all; clc;

% Define what p's to test
settings.n = 125;						% Set custom number of nodes
p_min = 2;								% Minimum picking position
p_max = settings.n-1;					% Maximum picking position
p_step = 1;								% Picking position step
settings.steps = 30000;					% Number of simulation time steps

% Initalizations
p_range = p_min:p_step:p_max;			% Generate picking position range 
n_sims = length(p_range);				% Get number of simulations
std_Etot = zeros(1,n_sims);				% Initialize norm std of Etot array

% Test all the p's
for i = 1:length(p_range)				% Loop over picking positions
	settings.p = p_range(i);			% Apply picking position in settings
	[~,~,~,~,Etot] = guitarstring(settings);	% Run simulation
	std_Etot(i) = std(Etot)/mean(Etot);	% Calculate norm std of Etot
	
	% Clear console and show progress
	clc
	fprintf('%i/%i - %.0f%% done\n',i,n_sims,round(i/n_sims*100));
end

% Plot the relation
plot(p_range,std_Etot,'.-')
title('Normalized Standard Deviation of Total Energy')
xlabel('p')
ylabel('\sigma_{E_{tot}}/\langle E_{tot}\rangle')
