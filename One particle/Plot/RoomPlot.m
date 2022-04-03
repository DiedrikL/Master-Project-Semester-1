% Plots the difference with respect to a gate for different epsilon and
% omega values

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 12;
N = 20;

% Setup space
x = linspace(-L/2,L/2,N);    

epsilon = x;
omegaX = 0;
omegaY = x;

Z = zeros(N,N);

% Finds the distance to the gate selected in MeasureDiff
% Only two variables can be arrays
for n = 1:N
    n %#ok<NOPTS>5
   for m = 1:N
      Z(n,m) = MeasureDiff(epsilon(n), omegaX, omegaY(m));
       
   end
end

% Plot room
pcolor(epsilon, omegaY, Z)

% Finds and prints lowest value with parameters
[M, I] = min(Z,[],'all','linear');
[row, col] = ind2sub(N,I);
LowestEpsilon = epsilon(row)
LowestOmegaX = omegaX
LowestOmegaY = omegaY(col)
LowestValue = MeasureDiff(epsilon(row), omegaX, omegaY(col))
