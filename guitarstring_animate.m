close all;
settings.dt = 0.01;
[x,y,vx,vy,Etot] = guitarstring(settings);
[imax,~] = size(x);
xani = downsample(x,10);
yani = downsample(y,10);

figure
for i=1:imax
	plot(xani(i,:),yani(i,:),'.-')
	ylim([-0.05 0.05])
	drawnow
end
