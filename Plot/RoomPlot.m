% Plots the difference with respect to a gate for different epsilon and
% omega values

% Clear memory and set format for output to screen
clear all
format short e

% Parameter size and resolution
L = 10;
N = 50;

% Setup space
x = linspace(0,L,N);    

%[epsilon,omega]=meshgrid(x,x);
%omega=omega+1;
epsilon = x;
omega = x;

Z = zeros(N,N);

for n = 1:length(epsilon)
    n
   for m = 1:length(omega)
      Z(n,m) = MeasureDiff(5.5621, omega(m) + 1i*epsilon(n));
       
   end
end

pcolor(epsilon, abs(omega), Z)
