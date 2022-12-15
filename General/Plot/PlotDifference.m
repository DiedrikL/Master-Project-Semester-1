% Script that plots the difference of a Lindbladian from a Hamiltonian for
% different strength of intereference, given by gamma.

% parameters, should give 0 for the given gate

% Parameters for TestGate
% epsilon = 5;
% omegaX = 4;
% omegaY = 2;

% Parameters for Hadamard
epsilon = 2.4210e+00;
omegaX = 3.1426e-16;
omegaY = -1.6971e+00;
% result = 1.2130e-09;

% Parameters for Hadamard
% epsilon = 2.6561;
% omegaX = 0.1953;    
% omegaY = 7.9577;
% result = 2.0797e-04;




% The gate to target
% Gate = Gates.TestGateOne;
Gate = Gates.Hadamard;


% variables
N = 1e2;
goal = 0.2;

deltaGamma = goal/N;
gamma = 0:deltaGamma:goal;
gamma(end) = [];

% Setting up arrays
Choi = ones(1,N);
parameters = [epsilon, omegaX, omegaY];

% Setting up the hamiltonians
Lindbladian = Hamiltonians.LindbladOne(Parameters = parameters);
SimpleHam = Hamiltonians.SimpleHamiltonian(Parameters = parameters);

% Finding the reference
Avg = MeasureDiffGeneral(SimpleHam, Gate = Gate);

for n = 1:N
    Lindbladian.Gamma = gamma(n);
    Choi(n) = MeasureDiffGeneral(Lindbladian, Gate = Gate);
end

figure
hold on

plot(gamma, Choi);
refline([0,Avg]);

hold off