
epsilon = 2.4210e+00;
omegaX = 0;
omegaY = 1.6971e+00;

parameters = [epsilon, omegaX, omegaY];

Hamiltonian = Hamiltonians.LindbladOne(Parameters = parameters, Gamma = 1000);
Gate = Gates.Hadamard;
MeasureDiffGeneral(Hamiltonian, Gate = Gate)

SimpleHam = Hamiltonians.SimpleHamiltonian(Parameters = parameters);
MeasureDiffGeneral(SimpleHam, Gate = Gate)


