
epsilon = 5;
omegaX = 4;
omegaY = 2;
gamma = 1e-4;

parameters = [epsilon, omegaX, omegaY];

Hamiltonian = Hamiltonians.LindbladOne(Parameters = parameters, Gamma = gamma);
% Gate = Gates.Hadamard;
Gate = Gates.TestGateOne;
MeasureDiffGeneral(Hamiltonian, Gate = Gate)

SimpleHam = Hamiltonians.SimpleHamiltonian(Parameters = parameters);
MeasureDiffGeneral(SimpleHam, Gate = Gate)

% FindU(Hamiltonian)
FindU(SimpleHam)
