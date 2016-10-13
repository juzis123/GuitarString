% Normalized Standard Deviation of Total Energy as a function of time step size
% Runs simulation for different time steps dt
clear; close all; clc;

% Define what dt's to test
dt_min = 1e-4;				            % Set minimum dt value to test
dt_max = 4e-2;				            % Set maximum dt value to test
dt_step = 4e-4;				            % Set dt steps
settings.steps = 30000;		            % Set number of simulation time steps

% Initalizations
dt_range = dt_min:dt_step:dt_max;		% Generate dt-range
std_Etot = zeros(1,length(dt_range));	% Initialize std of total energy array

% Test all the dt's
for i = 1:length(dt_range)				% Loop over dt-range
	settings.dt = dt_range(i);			% Set dt in settings struct
	[~,~,~,~,Etot] = guitarstring(settings);	% Do simulation and get Etot
	std_Etot(i) = std(Etot)/mean(Etot);	% Calculate normalized std of Etot
	
	% Print progress to console
	fprintf('%i/%i - %.0f%% done\n',i,length(dt_range),round(i/length(dt_range)*100));
end

% Plot the relation
plot(dt_range,std_Etot,'.-')
title('Dimensionless Standard Deviation of Total Energy')
xlabel('dt')
ylabel('\sigma_{E_{tot}}/\langle E_{tot}\rangle')
