% clear; close all; clc;

% Define what dt's to test
settings.n = 60;
p_min = 2;
p_max = round(settings.n/2);
p_step = 1;
settings.steps = 120000;
settings.dt = 0.005;
console_text = 'Simulating for different picking positions...';

% Initalizations
p_range = p_min:p_step:p_max;
n_sims = length(p_range);
povertones = [];
starttime = now;

% Simulate for all the p's
for i = 1:length(p_range)
	settings.p = p_range(i);
	[x,y,vx,vy,Etot] = guitarstring(settings);
	% vsq(i) = vx.^2 + vy.^2;
	
	% Calculate samples
	samples = sum(y,2);						    % Create samples from sum of y position
	samples = samples/max(samples);			    % Normalize samples
	
	povertones{i} = overtone_peaks(samples); 	% Determine overtone sizes
	
	gs_eta(i,length(p_range),starttime,'console',console_text,0);
end

% Plot all overtones in one graph
