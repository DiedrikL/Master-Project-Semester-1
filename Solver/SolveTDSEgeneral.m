function [tVector, Solution] = SolveTDSEgeneral(Psi, Hamiltonian, options)

% Solves the schrödinger equation with Crank Nicolson for a specified
% Hamiltonian with a startvalue. Gamma is an optional value that must not
% be zero. Time can optionally be set with a specified start, end and
% number of steps.

% Input validation and default values
arguments
   Psi (:,1) double
   Hamiltonian function_handle;
   options.T(1,1) double = 2*pi;
   options.Tstart(1,1) double = 0;
   options.Tsize(1,1) double = 500;
end


% Set timelength
dt = (options.T-options.Tstart)/options.Tsize;
mustBeReal(dt);
tVector = (options.Tstart):dt:(options.T);
tVector(end) = [];

% Find sizes
leng = length(tVector);
psiHeight = size(Psi,1);


% Crank Nicolson solver
I = eye(psiHeight);
Phi = @(t,y) (I + 1i*dt/2*Hamiltonian(t+dt))^(-1) * (I - 1i*dt/2*Hamiltonian(t))*y;

Y = zeros(psiHeight, leng);

for n = 1:leng
    Psi = Phi(tVector(n),Psi);
    for m = 1:psiHeight
        Y(m,n) = Psi(m);
    end
end

Solution = Y;

