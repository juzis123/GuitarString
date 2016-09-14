%Element
mass = 1; %mass of each element
konstant = 1; 
n = 1; %number elements
t_steps = 1000;
x = zeros(t_steps,n); %x-coordinates of element
y = zeros(t_steps,n); %y-coordinates of element
vx = zeros(t_steps,n); %x-velocity of element
vy = zeros(t_steps,n); %y-velocity of element
L_total = 5; % length string streched
Ls = L_total/(n + 1); %length string between elements

L0 = 4;   % rustlengte whole snar 
r0 = L0/(n+1);
dt = 0.01; % time...
t = 0;


for i=1:t_steps
    r = (0 - x(1))^2 +(0 - y(1))^2;
    F = -konstant*(sqrt(r)-r0);
    dvx = F/m * dt;
    dvy = F/m 
    
    



