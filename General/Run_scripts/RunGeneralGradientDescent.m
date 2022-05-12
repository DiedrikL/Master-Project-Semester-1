
T = 2*pi;

Time = TimeOptions(Tstart = -T, Tend = T);

Hamilt = Hamiltonians.SmoothHamiltonianOffsets(Time = Time);
HGate = Gates.Hadamard;

epsilon = 1;
omegaX = 0.6;
omegaY = 0;

Beta = 0.1;

learning = 1e-2;

parameters = [epsilon, omegaX, omegaY, 0, 0, 0];


[para, result] = GradientDescent.GradientDescent(parameters, Hamilt, HGate, Beta=Beta, learning=learning)