function [tVector, Solution] = SolveTDSE(epsilon, omega, psi0, gamma)

% Solves the schrödinger equation with Crank Nicolson for a specified 
% Hamiltonian with provided parameters and startvalue. Gamma is an optional
% value that must not be zero.

% Input validation and default values
arguments
   epsilon(1,:) double
   omega(1,:) double
   psi0 (2,1) double
   gamma double {mustBeNonzero} = 1;
end

% Parameters and start value
Psi = psi0;

% Set timelength
T = 4*pi/gamma;
dt = T/1000;
tVector = 0:dt:T;
tVector(end) = [];
leng = length(tVector);

% Formula for hamilton operator
H = @(t)[-epsilon/2                omega*sin(gamma*t);...
         conj(omega)*sin(gamma*t)  epsilon/2];

% Crank Nicolson solver
I = eye(2);
Phi = @(t,y) (I + 1i*dt/2*H(t+dt))^-1 * (I - 1i*dt/2*H(t))*y;

Y = zeros(2, leng);

for n = 1:leng
    Psi = Phi(tVector(n),Psi);
    Y(1, n) = Psi(1);
    Y(2, n) = Psi(2);
end

Solution = Y;

