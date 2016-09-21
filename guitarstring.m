
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
m = A(1,2); %mass of each element
k = A(2,2); 
n = A(3,2); %number nodes including the walls
t_steps = 10000;
x = zeros(t_steps,n); %x-coordinates of element
y = zeros(t_steps,n); %y-coordinates of element
vx = zeros(t_steps,n); %x-velocity of element
vy = zeros(t_steps,n); %y-velocity of element
L_total = 7; % length string streched
Ls = L_total/(n-1); %length string between elements

L0 = 4;   % rustlengte whole string 
r0 = L0/(n+1); % length of each spring
dt = 0.2; %time...
t = 0; %time initialzied 

x(1,:) = ((1:n)-1).*Ls;
Etot = zeros(t_steps,1);
% give it a kick
for j=2:n/2
    
    vy(1,floor(j))=0.5;


for i=1:t_steps
    Dx = x(i,2:end)- x(i,1:end-1); % n-1
    Dy = y(i,2:end)- y(i,1:end-1);
    
    % Krachten
    r = sqrt(Dx.^2 + Dy.^2);
    Fd = -k*(1 - (r0./r));
    Fx = Dx.*Fd;
    Fy = Dy.*Fd;
    Fx_tot = [0 Fx(1:end-1)-Fx(2:end) 0];
    Fy_tot = [0 Fy(1:end-1)-Fy(2:end) 0];
    
    dvx = Fx_tot/m * dt; %change of speed of displacement 
    dvy = Fy_tot/m * dt;
    vx(i+1,:) = dvx  + vx(i,:); % nieuwe velocity
    vy(i+1,:) = dvy  + vy(i,:); % nieuwe velocity
    % Wanden stilhouden
%     vx(i,1) = 0;
%     vy(i,1) = 0;
    
    dx = vx(i+1,:) * dt; % verplaatsing van blokje vorige tijdstap naar volgende tijdstap 
    dy = vy(i+1,:) * dt;
    
    x(i+1,:) = x(i, :) + dx;
    y(i+1,:) = y(i, :) + dy;
    
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