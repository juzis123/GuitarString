% Define what dt's to test
dt_min = 1e-4;
dt_max = 4e-2;
dt_step = 4e-4;
settings.steps = 30000;

% Initalizations
dt_range = dt_min:dt_step:dt_max;
std_Etot = zeros(1,length(dt_range));

% Test all the dt's
for i = 1:length(dt_range)
	settings.dt = dt_range(i);
	[x,y,vx,vy,Etot] = guitarstring(settings);
	std_Etot(i) = std(Etot)/mean(Etot);
	fprintf('%i/%i - %.0f%% done\n',i,length(dt_range),round(i/length(dt_range)*100));
end

plot(dt_range,std_Etot,'.-')
title('Dimensionless Standard Deviation of Total Energy')
xlabel('dt')
ylabel('\sigma_{E_{tot}}/\langle E_{tot}\rangle')


%%%% Influence of number of nodes
