% Test function to see difference with effect with two particles

% Parametre and start value


gate = Gates.OnesGate;

epsilon = 0;
omegaX = 0;
omegaY = 0;
u = -0.5;

parameters = [epsilon, omegaX, omegaY, u];

H1 = Hamiltonians.TwoParticleInteractionHamiltonian(Parameters = parameters);

Diff = MeasureDiffGeneral(H1, Gate=gate)
AvgGF = AverageGateFidelity(H1, Gate = gate)