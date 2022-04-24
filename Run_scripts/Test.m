% Test function to see difference with a smoothed out Hamiltonian

% Parametre and start value
epsilon = 2;
omegaX = 1.6;
omegaY = 0;
psi0 = [1; 0];


% Solve the schrödinger equation
H = Hamiltonians.smoothedHamiltonian(epsilon, omegaX, omegaY);



Diff = MeasureDiffGeneral(H)
DiffNormal = MeasureDiff(epsilon, omegaX, omegaY)
