% Test function to see difference with a smoothed out Hamiltonian

% Parametre and start value
epsilon = 2.4210e+00;
omegaX = 0;
omegaY = 1.6971e+00;

% epsilon = 2;
% omegaX = 1;
% omegaY = 0;

psi0 = [1; 0];



% Solve the schrödinger equation
H1 = Hamiltonians.smoothedHamiltonianSimple(epsilon, omegaX, omegaY, scale=5);
H2 = Hamiltonians.smoothedHamiltonian(epsilon, omegaX, omegaY, scale=5);



Diff = MeasureDiffGeneral(H1)

Diff2 = MeasureDiffGeneral(H2)

DiffNormal = MeasureDiff(epsilon, omegaX, omegaY)
