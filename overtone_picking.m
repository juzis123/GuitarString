clear; close all; clc;

% Define what dt's to test
settings.n = 60;
p_min = 2;
p_max = settings.n-1;
p_step = 1;
settings.steps = 250000;
settings.dt = 0.01;

% Initalizations
p_range = p_min:p_step:p_max;
n_sims = length(p_range);
% vsq = zeros(1,n_sims);

% % Test all the dt's
% for i = 1:length(p_range)
	% settings.p = p_range(i);
	% [x,y,vx,vy,Etot] = guitarstring(settings);
	% vsq(i) = vx.^2 + vy.^2;
	% clc
	% fprintf('%i/%i - %.0f%% done\n',i,n_sims,round(i/n_sims*100));
% end

% Calculate speed^2
settings.p = round(2);
[x,y,vx,vy,Etot] = guitarstring(settings);
vsq = sum(vy,2);		% Sum of square of all node velocities
% plot(abs(fft(vsq)),'.-')

% x_fast=downsample(x,10); y_fast=downsample(y,10);
% for i=1:settings.steps
	% plot(x_fast(i,:),y_fast(i,:),'.-')
	% ylim([-0.05 0.05])
	% drawnow
% end

samples = downsample(sum(y,2),30);
samples = samples/max(samples);
sound(samples)


