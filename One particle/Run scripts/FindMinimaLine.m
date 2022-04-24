% Finds local minima for a one of the parameters epsilon, omegaX, omegaY
% with the two others set

clear vars
format short e

% Parameters
% Parameter size and resolution
L = 12;
N = 500;

% Setup space
x = linspace(0,L,N);    

epsilon = x*sin(1.22); % 2.38191
omegaX = 0;
omegaY = x*cos(1.22);

Y = zeros(1,N);

% Finds values
for n=1:N
    Y(n) = MeasureDiff(epsilon(n), omegaX, omegaY(n));
    
end

% Finds local minima
TF = islocalmin(Y);

YminLoc = epsilon(TF);
YminValue = Y(TF);

plot(epsilon, Y, YminLoc, YminValue,'r*')

disLength = length(YminLoc)-1;
distance = zeros(1,disLength);

for n = 1:disLength
distance(n) = YminLoc(n+1) - YminLoc(n);
end

figure
plot(distance)
