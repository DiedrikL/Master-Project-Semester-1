% Plots the difference with respect to a gate for different epsilon and
% omega values

% Clear memory and set format for output to screen
clear all
format short e

% Parameter size and resolution
L = 4;
N = 20;

% Setup space
x = linspace(0,L,N);    

[epsilon,omega,omegaImag]=meshgrid(x,x,x);
omegaImag = omegaImag*1i;

V = zeros(size(epsilon));

for m = 1:length(x)
   for n = 1:length(x)
       for o = 1:length(x)
           V(m,n,o) = MeasureDiff(epsilon(m,n,o), omega(m,n,o)+omegaImag(m,n,o));
                  
       end
   end
end

xSlice = [0 2];
ySlice = 4;
zSlice = [0 2];

slice(epsilon, omega, abs(omegaImag), V, xSlice, ySlice, zSlice);
view(-34,24)

cb = colorbar;

%pcolor(epsilon, abs(omega), Z)
