
epsilon = 5;
omegaX = 4;
omegaY = 2;
% epsilon = 2.4210e+00;
% omegaX = 3.1426e-16;
% omegaY = -1.6971e+00;
lambda = 0.01;

parameters = [epsilon, omegaX, omegaY];

Lindbladian = Hamiltonians.LindbladOne(Parameters = parameters, Lambda = lambda);
% Gate = Gates.Hadamard;
Gate = Gates.TestGateOne;
Choi = MeasureDiffGeneral(Lindbladian, Gate = Gate)

SimpleHam = Hamiltonians.SimpleHamiltonian(Parameters = parameters);
Avg = MeasureDiffGeneral(SimpleHam, Gate = Gate)

% FindU(Hamiltonian)
% FindU(SimpleHam)
