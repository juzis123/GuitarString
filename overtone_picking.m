% Judith Zissoldt (s1332171) and Daniel Cox (s1228579)
% Overtone picking
% Runs the simulation several times for different picking positions
% and shows a heatmap of the frequency spectrum
clear; close all; clc;

% Define what dt's to test
settings.n = 150;							% Set number of nodes to 100
p_min = 2;									% Set first picking position
p_max = round(settings.n-1);				% Set last picking position
p_step = 1;									% Set picking position step
settings.steps = 25e4;						% Set number of simulation time steps
settings.dt = 0.002;						% Set size of time step
settings.M = 3;								% Total mass of spring
settings.k = 6;								% Spring constant
console_text = 'Simulating for different picking positions...'; % Text in console during simulations

% Number of theoretical harmonic eigenfrequencies, that fit in the plot.
% As this isn't in fact a harmonic oscillator, this won't be the
% actual number of visible frequencies. It's only a rough measure.
eigfreqs_plot = 5;


% Initalizations
p_range 	= p_min:p_step:p_max;			% Generate range of picking positions
n_sims 		= length(p_range);				% Get number of simulations
ypfreqspec 	= zeros(length(p_range),round(settings.steps/2));	% Initialize <y^2>-samples
vypfreqspec = zeros(length(p_range),round(settings.steps/2));	% Initialize <vy^2>-samples

% Max frequency to show in the plot
freq_plotmax = eigfreqs_plot*sqrt(settings.k/settings.M)*settings.steps*settings.dt/(2*pi);
starttime = now;


% Simulate for all the p's
for i = 1:length(p_range)
	settings.p = p_range(i);					% Set picking position in settings
	[x,y,vx,vy,Etot] = guitarstring(settings);	% Do simulation
	
	% Calculate samples of average y(t)
	ysamples = mean(y.^2,2);					% Create samples from average y position
	ysamples = ysamples/max(ysamples);			% Normalize samples
	
	yfullfreqspec = abs(fft(ysamples));			% Calculate frequency spectrum (amplitude)
	ynff = round(length(yfullfreqspec)/2);		% Get length of full freq spec array
	ypfreqspec(i,:) = yfullfreqspec(1:ynff);	% Chop off mirrored half of the spectrum
	
	% Calculate samples of average vy(t)
	vysamples = mean(vy.^2,2);					% Create samples from average y velocity
	vysamples = vysamples/max(vysamples);		% Normalize samples
	
	vyfullfreqspec = abs(fft(vysamples));		% Calculate frequency spectrum (amplitude)
	vynff = round(length(vyfullfreqspec)/2);	% Get length of full freq spec array
	vypfreqspec(i,:) = vyfullfreqspec(1:vynff); % Chop off mirrored half of the spectrum
	
	% Show estimated time left in console
	gs_eta(i,length(p_range),starttime,'console',console_text,0);
end


% Plot spectra in one heat map - y position samples
figure														% Spawn new figure
freq_img = log(ypfreqspec(:,1:ceil(freq_plotmax)));			% Chop off interesting bit and take log()
xfreq = linspace(0,2*pi/(settings.steps*settings.dt),1000); % Generate x-axis ticks
yfreq = linspace(0,1,1000);									% Generate y-axis ticks
imagesc(xfreq,yfreq,freq_img,[4 9])							% Plot heat map with saturated color map
ylabel('Relative picking position')							% Set y-label
xlabel('\omega [s^{-1}]')									% Set x-label
title('\langle y^2\rangle Frequency Spectrum for Picking Position - Heat Map')

% Plot spectra in one heat map - y velocity samples
figure														% Spawn new figure
freq_img = log(vypfreqspec(:,1:ceil(freq_plotmax)));		% Chop off interesting bit and take log()
xfreq = linspace(0,2*pi/(settings.steps*settings.dt),1000);	% Generate x-axis ticks
yfreq = linspace(0,1,1000);									% Generate y-axis ticks
imagesc(xfreq,yfreq,freq_img,[1 8])							% Plot heat map with saturated color map
ylabel('Relative picking position')							% Set y-label
xlabel('\omega [s^{-1}]')									% Set x-label
title('\langle v_y^2\rangle Frequency Spectrum for Picking Position - Heat Map')
