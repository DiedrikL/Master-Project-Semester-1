% Test function to see difference with a smoothed out Hamiltonian


% Parametre and start value
% epsilon = 2.4210e+00;
% omegaX = 0;
% omegaY = 1.6971e+00;
epsilon = 1;
omegaX = 1;
omegaY = 1;

Period = 2*pi;
scale = 5;

timeSize = 1e4;

SimpleTime = TimeOptions(Tpulse = Period, Tsize = timeSize);
DoubleTime = TimeOptions(Tstart = -Period, Tpulse = Period, Tsize = timeSize);

% epsilon = 2;
% omegaX = 1;
% omegaY = 0;

gate = Gates.GateOfOne;

parameters = [epsilon, omegaX, omegaY];

H1 = Hamiltonians.SimpleHamiltonian(Time=SimpleTime, Parameters = parameters);
H2 = Hamiltonians.SmoothHamiltonian(Time=SimpleTime, Parameters = parameters, Scale = scale);
H3 = Hamiltonians.SmoothHamiltonian(Time=DoubleTime, Parameters = parameters);

% Solve the schrödinger equation

Dif1 = MeasureDiffGeneral(H1, Gate = gate)

Dif2 = MeasureDiffGeneral(H2, Gate = gate)

Diff3 = MeasureDiffGeneral(H3, Gate = gate)

