% Test function to see difference with a smoothed out Hamiltonian


% Parametre and start value
epsilon = 2.4210e+00;
omegaX = 0;
omegaY = 1.6971e+00;

Period = 2*pi;

SimpleTime = TimeOptions(Tpulse = Period, Tsize = 1000);
DoubleTime = TimeOptions(Tstart = -Period, Tpulse = Period);

% epsilon = 2;
% omegaX = 1;
% omegaY = 0;

psi0 = [1; 0];

parameters = [epsilon, omegaX, omegaY];

H1 = Hamiltonians.SimpleHamiltonian(Time=SimpleTime, Parameters = parameters);
H2 = Hamiltonians.SmoothHamiltonian(Time=SimpleTime, Parameters = parameters);
H3 = Hamiltonians.SmoothHamiltonian(Time=DoubleTime, Parameters = parameters);

% Solve the schrödinger equation

DiffNormal = MeasureDiff(epsilon, omegaX, omegaY)

Dif1 = MeasureDiffGeneral(H1)

Dif2 = MeasureDiffGeneral(H2)

Diff3 = MeasureDiffGeneral(H3)

