% Plots the difference with respect to a gate for different epsilon and
% omega values

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 4;
N = 20;

% Setup space
x = linspace(0,L,N);    

epsilon = x;
omegaX = x;
omegaY = x;

V = zeros(N);

% Finds the distance to the gate selected in MeasureDiff for three
% variables
for m = 1:N
    m %#ok<NOPTS>
   for n = 1:N
       for o = 1:N
           V(m,n,o) = MeasureDiff(epsilon(m), omega(n), omegaY(o));
                  
       end
   end
end

% Sets the slices visible
xSlice = [0 2];
ySlice = 4;
zSlice = [0 2];

% Plots the slices
figure
slice(epsilon, omega, omegaY, V, xSlice, ySlice, zSlice);
view(34,24)

cb = colorbar;

%pcolor(epsilon, abs(omega), Z)
