% Finds local minima for a given epsilon and omegaX varying omegaY

clear vars
format short e

% Parameters
% Parameter size and resolution
L = 100;
N = 5000;

% Setup space
x = linspace(0,L,N);    

epsilon = 5.54;
omegaX = 0;
omegaY = x;

Y = zeros(1,N);

% Finds values
for n=1:N
    Y(n) = MeasureDiff(epsilon, omegaX, omegaY(n));
    
end

% Finds local minima
TF = islocalmin(Y);


plot(omegaY, Y, omegaY(TF), Y(TF),'r*')

