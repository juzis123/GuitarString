% clear; close all; clc;

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
% [x,y,vx,vy,Etot] = guitarstring(settings);

% x_fast=downsample(x,10); y_fast=downsample(y,10);
% for i=1:settings.steps
	% plot(x_fast(i,:),y_fast(i,:),'.-')
	% ylim([-0.05 0.05])
	% drawnow
% end

% Calculate samples
samples = sum(y,2);
samples = samples/max(samples);

% Isolate base tone and overtones
freqspec = abs(fft(samples));
% nf = length(freqspec);
[freqsort,ifs] = sort(freqspec);
% pks = zeros(1,nf);
% pks(freqspec>mean(freqsort(nf*0.998:nf))) = 1;
% peakstend = pks(2:end) - pks(1:end-1);

plot(freqspec)
hold on
plot(ifs(end-10,end),freqsort(end-10,end),'or')
hold off

ntones = 10;
tonesize = zeros(1,ntones);





