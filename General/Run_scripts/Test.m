% Test function to see difference with a smoothed out Hamiltonian


% Parametre and start value
epsilon = 2.4210e+00;
omegaX = 0;
omegaY = 1.6971e+00;

Period = 2*pi;

SimpleTime = TimeOptions(Tend = Period, Tsize = 1000);
DoubleTime = TimeOptions(Tstart = -Period, Tend = Period);

% epsilon = 2;
% omegaX = 1;
% omegaY = 0;

psi0 = [1; 0];

parameters = [epsilon, omegaX, omegaY];

Hamiltonian1 = Hamiltonians.SimpleHamiltonian(Time=SimpleTime);
Hamiltonian2 = Hamiltonians.SmoothHamiltonian(Time=SimpleTime);
Hamiltonian3 = Hamiltonians.SmoothHamiltonian(Time=DoubleTime);

% Solve the schrödinger equation
H1 = Hamiltonian1.createHamiltonian(parameters);
H2 = Hamiltonian2.createHamiltonian(parameters);
H3 = Hamiltonian3.createHamiltonian(parameters);

DiffNormal = MeasureDiff(epsilon, omegaX, omegaY)

Dif1 = MeasureDiffGeneral(H1, Time=SimpleTime)

Dif2 = MeasureDiffGeneral(H2, Time=DoubleTime)

Diff3 = MeasureDiffGeneral(H3, Time=DoubleTime)
