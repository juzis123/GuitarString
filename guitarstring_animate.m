% Judith Zissoldt (s1332171) and Daniel Cox (s1228579)
% Script for showing the result as an animation
clear; close all; clc;

% Simulate and prepare data
filename = 'guitarstring_animation.gif';
downsampfac = 12;
settings.dt = 0.01; 						% Set the time step a little bigger
[x,y,vx,vy,Etot] = guitarstring(settings);	% Do the simulation
[imax,~] = size(x);							% fetch the number of frames
xani = downsample(x,downsampfac);			% Downsample x for faster animation
yani = downsample(y,downsampfac);			% Downsample y for faster animation

imax = 500;                                 % Overwrite frame count
delay = 0.03;

% Show animation as a series of plots
figure										% Spawn new figure
for i=1:imax								% Loop over frames
	plot(xani(i,:),yani(i,:),'.-')			% Plot the string
    xlabel('x'); ylabel('y')
    title(sprintf('Guitarstring - frame %i',i))
	ylim([-0.06 0.06])						% Fix y limits of plot
	drawnow									% Force plot drawing priority
    
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1;
        imwrite(imind,cm,filename,'gif','Loopcount',inf,'DelayTime',delay);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',delay);
    end
end
