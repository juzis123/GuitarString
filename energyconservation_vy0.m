% Normalized Standard Deviation of Total Energy as a function of initial node velocity
% Runs simulation for different initial node velocities
clear; close all; clc;

% Define what vy0's to test
vy0_min = 1e-3;							% Minimum vy0
vy0_max = 2e0;							% Maximum vy0
vy0_step = 1e-2;						% vy0 step
settings.steps = 30000;					% Number of simulation time steps
settings.dt = 1e-3;						% Custom time step size

% Initalizations
vy0_range = vy0_min:vy0_step:vy0_max;	% vy0 range
n_sims = length(vy0_range);				% Get number of simulations to run
std_Etot = zeros(1,n_sims);				% Initialize norm std of Etot

% Test all the vy0's
for i = 1:n_sims						% Loop (for different vy0's)
	settings.vy0 = vy0_range(i);		% Apply vy0 in settings
	[~,~,~,~,Etot] = guitarstring(settings);	% Run simulation
	std_Etot(i) = std(Etot)/mean(Etot);	% Calculate norm std of Etot
	
	% Show progress in console
	fprintf('%i/%i - %.0f%% done\n',i,n_sims,round(i/n_sims*100));
end

% Plot the relation
plot(vy0_range,std_Etot,'.-')
title('Dimensionless Standard Deviation of Total Energy')
xlabel('v_{y,0}')
ylabel('\sigma_{E_{tot}}/\langle E_{tot}\rangle')
