para = [2,2,2];

Hamilt = Hamiltonians.SimpleHamiltonian(Parameters=para);
HGate = Gates.Hadamard;


CalculateGradients(Hamilt, HGate)