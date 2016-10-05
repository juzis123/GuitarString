
% Onderzoeksvragen: Conservation of Energy (fout door simulatie);
% frequency-spectrum: als function van plek van aanslag;
% responsie op aanslag witte ruis (bruine ruis); dispersie-relatie
%Element

function [x,y,vx,vy,Etot] = guitarstring(settings)
	% Does a guitar string simulation
	% When a filename is provided, it will read the values from the file
	% If no argument is provided, standard values will be used
	
	%%%% Ik denk dat we het openen van een bestand beter in een losse functie kunnen doen
	%%%% Dat maakt 't makkelijker om veel simulaties achter elkaar te doen, bijv met 
	%%%% variabele dt
	
	M 	= 20;							% Total mass
	k 	= 3;							% Spring constant
	n 	= 30;							% Number of nodes
	p 	= 0.5;							% relative picking position
	Ltot = 7;                        	% length of string (when stretched)
	L0 	= 4;   							% Length of whole string (at rest)
	dt 	= 0.01; 						% Size of simulation time step
	t 	= 0; 							% Starting time
	steps = 50000;
	vy0 = 0.5;
	
	% If a settings struct argument is given, apply all variables it contains
	if nargin == 1
		if isfield(settings,'M'); 		M = settings.M; 		end;
		if isfield(settings,'k'); 		k = settings.k; 		end;
		if isfield(settings,'n'); 		n = settings.n; 		end;
		if isfield(settings,'p'); 		p = settings.p; 		end;
		if isfield(settings,'Ltot'); 	Ltot = settings.Ltot; 	end;
		if isfield(settings,'L0'); 		L0 = settings.L0; 		end;
		if isfield(settings,'dt'); 		dt = settings.dt;		end;
		if isfield(settings,'t'); 		t = settings.t;			end;
		if isfield(settings,'steps'); 	steps = settings.steps; end;
		if isfield(settings,'vy0');		vy0 = settings.vy0;		end;
	end


	% Calculated constants
	m	= M/n;							% Calculate node mass
	Ls 	= Ltot/(n-1); 					% starting length per spring element
	r0 	= L0/(n+1); 					% Length of each spring
	x 	= zeros(steps,n); 			    % x-coordinates of element
	y 	= zeros(steps,n); 				% y-coordinates of element
	vx 	= zeros(steps,n); 			    % x-velocity of element
	vy 	= zeros(steps,n); 				% y-velocity of element

	x(1,:) = ((1:n)-1).*Ls;				% distribute nodes evenly across length
	Etot = zeros(steps,1);

	% give it a kick
	vy(1,round(n*p)) = vy0;


	for i=1:steps
		Dx = x(i,2:end)- x(i,1:end-1); 			% Spring lengths x components
		Dy = y(i,2:end)- y(i,1:end-1);			% Spring lengths y components
		
		% Krachten
		r = sqrt(Dx.^2 + Dy.^2);				% Spring lengths
		Fd = -k*(1 - (r0./r));
		Fx = Dx.*Fd;							% Force x component
		Fy = Dy.*Fd;							% Force y component
		Fx_tot = [0 Fx(1:end-1)-Fx(2:end) 0];	% Combined forces x component
		Fy_tot = [0 Fy(1:end-1)-Fy(2:end) 0];	% Combined forces y component
		
		dvx = Fx_tot/m * dt; 					% Change of velocity x
		dvy = Fy_tot/m * dt;					% Change of velocity y
		vx(i+1,:) = dvx  + vx(i,:); 			% New velocity x
		vy(i+1,:) = dvy  + vy(i,:); 			% New velocity y
		
		dx = vx(i+1,:) * dt; 					% Displacement of node x component
		dy = vy(i+1,:) * dt;					% Displacement of node y component
		
		x(i+1,:) = x(i, :) + dx;				% New x position
		y(i+1,:) = y(i, :) + dy;				% New y position
		
		% plot(x(i,:),y(i,:),'.-')
		% xlim([0 Ltot])
		% ylim([-0.5 0.55])
		% drawnow
		Etot(i) = sum(0.5 * m * (vx(i,:).^2 + vy(i,:).^2)) + sum(0.5 * k*(r - r0).^2);
	end

	%     drawnow
	% samples = vy(:,floor(n/2));
	% samples = sum(vy,2);
	% samples = samples./(max(samples));
	% sound(samples)
	% plot(abs(fft(samples)))
end