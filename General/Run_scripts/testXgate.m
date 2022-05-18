% Test function to see difference with a smoothed out Hamiltonian


% Parametre and start value
epsilon = 0;
omegaX = 1;
omegaY = 0;

Period = pi/2;

SimpleTime = TimeOptions(Tpulse = Period, Tsize = 500);
DoubleTime = TimeOptions(Tpulse = Period, Tsize = 1000);

gate = Gates.Xgate;

% epsilon = 2;
% omegaX = 1;
% omegaY = 0;

psi0 = [1; 0];

parameters = [epsilon, omegaX, omegaY];

H1 = Hamiltonians.SimpleHamiltonian(Time=SimpleTime, Parameters = parameters);
H2 = Hamiltonians.SmoothHamiltonian(Time=SimpleTime, Parameters = parameters, Scale = 1);
H3 = Hamiltonians.SmoothHamiltonian(Time=SimpleTime, Parameters = parameters, Scale = 10);

% Solve the schrödinger equation

% DiffNormal = MeasureDiff(epsilon, omegaX, omegaY)

Dif1 = MeasureDiffGeneral(H1, Gate = gate)

Dif2 = MeasureDiffGeneral(H2, Gate = gate)

Diff3 = MeasureDiffGeneral(H3, Gate = gate)

