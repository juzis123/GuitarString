% Script for showing the result as an animation
clear; close all; clc;

% Simulate and prepare data
settings.dt = 0.01; 						% Set the time step a little bigger
[x,y,vx,vy,Etot] = guitarstring(settings);	% Do the simulation
[imax,~] = size(x);							% fetch the number of frames
xani = downsample(x,10);					% Downsample x for faster animation
yani = downsample(y,10);					% Downsample y for faster animation

% Show animation as a series of plots
figure										% Spawn new figure
for i=1:imax								% Loop over frames
	plot(xani(i,:),yani(i,:),'.-')			% Plot the string
	ylim([-0.08 0.08])						% Fix y limits of plot
	drawnow									% Force plot drawing priority
end
