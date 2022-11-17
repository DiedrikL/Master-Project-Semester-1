
epsilon = 2.4210e+00;
omegaX = 0;
omegaY = 1.6971e+00;

parameters = [epsilon, omegaX, omegaY];

Hamiltonian = Hamiltonians.LindbladOne(Gamma = 1);
Gate = Gates.Hadamard;
MeasureDiffGeneral(Hamiltonian, Gate = Gate)

SimpleHam = Hamiltonians.SimpleHamiltonian();
MeasureDiffGeneral(SimpleHam, Gate = Gate)

FindU(Hamiltonian)
FindU(SimpleHam)
