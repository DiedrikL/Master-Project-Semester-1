function [Solution] = Crank_Nicolson(Psi, Hamiltonian)

% Solves the schrödinger equation with Crank Nicolson for a specified
% Hamiltonian and startvalues Psi.


% Input validation
arguments
    Psi (:,1) double
    Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface;
end

% Get parameterized hamiltonian 
H = Hamiltonian.createHamiltonian;

% Set timelength
dt = Hamiltonian.TimeStep;
tVector = Hamiltonian.TimeVector;

% Find sizes
leng = length(tVector);
psiHeight = size(Psi,1);


% Crank Nicolson solver
I = eye(psiHeight);
Phi = @(t,y) (I + 1i*dt/2*H(t+dt))^(-1) * (I - 1i*dt/2*H(t))*y;

Y = zeros(psiHeight, leng);

for n = 1:leng
    Psi = Phi(tVector(n),Psi);
end

Solution = Psi;

