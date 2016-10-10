clear; close all; clc;

% Define what dt's to test
settings.n = 100;
p_min = 2;
p_max = round(settings.n-1);
p_step = 1;
settings.steps = 25e4;
settings.dt = 0.002;
settings.M = 20;							% Total mass
settings.k = 3;								% Spring constant
console_text = 'Simulating for different picking positions...';

% Number of theoretical harmonic eigenfrequencies, that fit in the plot.
% As this isn't in fact a harmonic oscillator, this won't be the
% actual number of visible frequencies. It's only a rough measure.
eigfreqs_plot = 5;

% Initalizations
p_range 	= p_min:p_step:p_max;
n_sims 		= length(p_range);
ypfreqspec 	= zeros(length(p_range),round(settings.steps/2));
vypfreqspec = zeros(length(p_range),round(settings.steps/2));

% Max frequency to show in the plot
freq_plotmax = eigfreqs_plot*sqrt(settings.k/settings.M)*settings.steps*settings.dt/(2*pi);
starttime = now;


% Simulate for all the p's
for i = 1:length(p_range)
	settings.p = p_range(i);
	[x,y,vx,vy,Etot] = guitarstring(settings);
	
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
	
	gs_eta(i,length(p_range),starttime,'console',console_text,0);
end


% Plot spectra in one heat map - y position samples
figure
freq_img = log(ypfreqspec(:,1:ceil(freq_plotmax)));
xfreq = linspace(0,2*pi/(settings.steps*settings.dt),1000);
yfreq = linspace(0,1,1000);
imagesc(xfreq,yfreq,freq_img,[3 9])
ylabel('Relative picking position')
xlabel('\omega [s^{-1}]')
title('\langle y^2\rangle Frequency Spectrum for Picking Position - Heat Map')

% Plot spectra in one heat map - y velocity samples
figure
freq_img = log(vypfreqspec(:,1:ceil(freq_plotmax)));
xfreq = linspace(0,2*pi/(settings.steps*settings.dt),1000);
yfreq = linspace(0,1,1000);
imagesc(xfreq,yfreq,freq_img,[1 7])
ylabel('Relative picking position')
xlabel('\omega [s^{-1}]')
title('\langle v_y^2\rangle Frequency Spectrum for Picking Position - Heat Map')
