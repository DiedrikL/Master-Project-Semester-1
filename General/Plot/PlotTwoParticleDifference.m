% Script that plots the difference of a Lindbladian from a Hamiltonian for
% different strength of intereference, given by gamma.

% Parameters for GateOfOneTwoParticles
epsilon = 1;
omegaX = 1;
omegaY = 1;
U = 1;

% The gate to target
Gate = Gates.GateOfOneTwoParticles;


% variables
N = 1e2;
goal = 0.2;

gamma = 0;

% Setting up arrays
Choi = ones(1,N);
parameters = [epsilon, omegaX, omegaY, U];

% Setting up the hamiltonians
Lindbladian = Hamiltonians.LindbladRhoTwo(Parameters = parameters, Gamma = gamma);
Hamiltonian = Hamiltonians.TwoParticleInteractionHamiltonian(Parameters = parameters);

% Finding the reference
Avg = MeasureDiffGeneral(Hamiltonian, Gate = Gate);

for n = 1:N
    Lindbladian.Gamma = gamma(n);
    Choi(n) = MeasureDiffGeneral(Lindbladian, Gate = Gate);
end

figure
hold on

plot(lambda, Choi);
refline([0,Avg]);

hold off