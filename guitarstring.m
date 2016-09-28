
% Onderzoeksvragen: Conservation of Energy (fout door simulatie);
% frequency-spectrum: als function van plek van aanslag;
% responsie op aanslag witte ruis (bruine ruis); dispersie-relatie
%Element
function [x,y,vx,vy] = guitarstring(filename)
if exist(fullfile(cd, filename),'file') == 2
    disp([filename ' does not exist']);
   return; 
end
fileID = fopen('var.txt','r');
sizeA = [3 Inf];
A = fscanf(fileID,'%d %f', sizeA);

% Parameters
m = A(1,2); 						% Mass of each element
%%%% to do: make mass independent of # of nodes
k = A(2,2); 						% Spring constant
n = A(3,2);                         % Number nodes (including the walls)
L_total = 7;                        % length of string (when stretched)
L0 = 4;   							% Length of whole string (at rest)
dt = 0.2; 							% Size of simulation time step
t = 0; 								% Starting time
t_steps = 10000;

% Calculated constants
Ls = L_total/(n-1); 				% starting length per spring element
r0 = L0/(n+1); 						% Length of each spring
x = zeros(t_steps,n); 				% x-coordinates of element
y = zeros(t_steps,n); 				% y-coordinates of element
vx = zeros(t_steps,n); 				% x-velocity of element
vy = zeros(t_steps,n); 				% y-velocity of element

x(1,:) = ((1:n)-1).*Ls;				% distribute nodes evenly across length
Etot = zeros(t_steps,1);

% give it a kick
for j=2:n/2
    
    vy(1,floor(j))=0.5;


for i=1:t_steps
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
    
%     plot(x(i,:),y(i,:),'.-')
%     xlim([0 L_total])
%     ylim([-0.5 0.55])
%     drawnow
 Etot(i) = sum(0.5 * m * (vx(i,:).^2 + vy(i,:).^2)) + sum(0.5*k*(r(i,:) - r0).^2);
 
end
plot(Etot);

%     drawnow
end
% samples = vy(:,floor(n/2));
samples = sum(vy,2);
samples = samples./(max(samples));
sound(samples)
plot(abs(fft(samples)))