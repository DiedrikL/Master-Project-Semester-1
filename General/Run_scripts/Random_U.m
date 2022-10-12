% Script to create a random unitary from random parameters

% Setup parameters

range = 10;
minimum = 0;
learning = 1e-3;
HGate = Gates.RandomUnitary;


% Result matrices
% parameters = rand(1,6).*range+minimum
parameters = ones(1,6);

Hamiltonian = Hamiltonians.TwoParticleMultiInteractionHamiltonian(Parameters = parameters);

% Find the unitary the hamiltonian creates
U = FindU(Hamiltonian)

