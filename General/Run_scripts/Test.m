% Test function to see difference with a smoothed out Hamiltonian


% Parametre and start value
epsilon = 2.4210e+00;
omegaX = 0;
omegaY = 1.6971e+00;

Time = 2*pi;

% epsilon = 2;
% omegaX = 1;
% omegaY = 0;

psi0 = [1; 0];

parameters = [epsilon, omegaX, omegaY];


% Solve the schrödinger equation
H1 = Hamiltonians.SimpleHamiltonian.createHamiltonian(parameters);
H2 = Hamiltonians.SmoothHamiltonian.createHamiltonian(parameters, scale=5);
H3 = Hamiltonians.SmoothHamiltonian.createHamiltonian(parameters, scale=5);

DiffNormal = MeasureDiff(epsilon, omegaX, omegaY)

Dif1 = MeasureDiffGeneral(H1, T = Time, Tsize=1000)

Dif2 = MeasureDiffGeneral(H2, T = Time, Tstart = -Time)

Diff3 = MeasureDiffGeneral(H3, T = Time, Tstart = -Time)

