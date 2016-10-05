close all;
settings.dt = 0.1;
[x,y,vx,vy,Etot] = guitarstring(settings);

[imax,~] = size(x)

for i=1:imax
	plot(x(i,:),y(i,:),'.-')
	ylim([-0.1 0.1])
	drawnow
end
