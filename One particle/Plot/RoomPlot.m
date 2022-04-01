% Plots the difference with respect to a gate for different epsilon and
% omega values

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 12;
N = 40;

% Setup space
x = linspace(-L/2,L/2,N);    

epsilon = x;
omegaX = 0;
omegaY = linspace(8, 12, N);

Z = zeros(N,N);

% Finds the distance to the gate selected in MeasureDiff
% Only two variables can be arrays
for n = 1:N
    n %#ok<NOPTS>5
   for m = 1:N
      Z(n,m) = MeasureDiff(epsilon(n), omegaX - 1i*omegaY(m));
       
   end
end

pcolor(epsilon, omegaY, Z)
