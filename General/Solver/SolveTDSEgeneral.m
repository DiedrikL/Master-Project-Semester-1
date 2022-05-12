function [tVector, Solution] = SolveTDSEgeneral(Psi, Hamiltonian, Time)

% Solves the schrödinger equation with Crank Nicolson for a specified
% Hamiltonian with a startvalue. Gamma is an optional value that must not
% be zero. Time can optionally be set with a specified start, end and
% number of steps.
%
% T is time period, default 2*pi
% Tstart is start point, default 0;
% Tsize is number of points, default 500

% Input validation and default values
arguments
    Psi (:,1) double
    Hamiltonian function_handle;
    Time TimeOptions = TimeOptions;
end


% Set timelength
dt = (Time.Tend-Time.Tstart)/Time.Tsize;
mustBeReal(dt);
tVector = (Time.Tstart):dt:(Time.Tend);
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

