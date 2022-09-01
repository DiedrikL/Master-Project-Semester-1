% Test function to see difference with effect with two particles

% Parametre and start value
epsilon = 0;
omegaX = 1;
omegaY = 0;
u = 0.5;

Period = pi/2;

SimpleTime = TimeOptions(Tpulse = Period, Tsize = 500);
DoubleTime = TimeOptions(Tpulse = Period, Tsize = 1000);

gate = Gates.SquareRootSwap;

% epsilon = 2;
% omegaX = 1;
% omegaY = 0;

parameters = [epsilon, omegaX, omegaY];

H1 = Hamiltonians.TwoParticlesHamiltonian(Time=SimpleTime, Parameters = parameters, U = u);

MeasureDiffGeneral(H1, Gate=gate)