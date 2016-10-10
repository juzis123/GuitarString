% clear; close all; clc;

% Define what dt's to test
settings.n = 90;
p_min = 2;
p_max = round(settings.n);
p_step = 1;
settings.steps = 70000;
settings.dt = 0.005;
settings.M = 20;							% Total mass
settings.k = 3;								% Spring constant
console_text = 'Simulating for different picking positions...';

% Number of theoretical harmonic eigenfrequencies, that fit in the plot.
% As this isn't in fact a harmonic oscillator, this won't be the
% actual number of visible frequencies. It's only a rough measure.
eigfreqs_plot = 4;

% Initalizations
p_range = p_min:p_step:p_max;
n_sims = length(p_range);

% Max frequency to show in the plot
freq_plotmax = eigfreqs_plot*sqrt(settings.k/settings.M)*settings.steps*settings.dt/(2*pi);
starttime = now;

pfreqspec = zeros(length(p_range),round(settings.steps/2));

% Simulate for all the p's
for i = 1:length(p_range)
	settings.p = p_range(i);
	[x,y,vx,vy,Etot] = guitarstring(settings);
	% vsq(i) = vx.^2 + vy.^2;
	
	% Calculate samples
	samples = sum(y,2);						    % Create samples from sum of y position
	samples = samples/max(samples);			    % Normalize samples
	
	fullfreqspec = abs(fft(samples));			% Calculate frequency spectrum (amplitude)
	nff = round(length(fullfreqspec)/2);		% Get length of full freq spec array
	pfreqspec(i,:) = fullfreqspec(1:nff);	    % Chop off mirrored half of the frequency spectrum
	
	gs_eta(i,length(p_range),starttime,'console',console_text,0);
end

% Plot all overtones in one graph
freq_img = log(pfreqspec(:,1:ceil(freq_plotmax)));
xlabel('')
yticks([0 1/4 1/2 3/4 1])
% yticklabels({'0','1/4','1/2','3/4','1'})
ylabel('Relative picking position')
imagesc(freq_img,[3.5 9])
