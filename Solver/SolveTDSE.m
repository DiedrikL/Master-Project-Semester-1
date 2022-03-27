function [tVector, Solution] = SolveTDSE(epsilon, omega, psi0)

% Solves the schrödinger equation with Crank Nicolson for a specified 
% Hamiltonian with provided parameters and startvalue.


% Parameters and start value
gamma = 1;
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

