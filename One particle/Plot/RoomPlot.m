% Plots the difference with respect to a gate for different epsilon and
% omega values

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 10;
N = 50;

% Setup space
x = linspace(0,L,N);    

epsilon = 5.5621;
omegaX = x;
omegaY = 1i*x;

Z = zeros(N,N);

% Finds the distance to the gate selected in MeasureDiff
% Only two variables can be arrays
for n = 1:N
    n %#ok<NOPTS>
   for m = 1:N
      Z(n,m) = MeasureDiff(epsilon, omegaX(n) + omegaY(m));
       
   end
end

pcolor(omegaX, abs(omegaY), Z)
