
epsilon = 1;
omegaX = 1;
omegaY = 1;
% epsilon = 2.42122268156879;
% omegaX = -7.22876276613933e-06;
% omegaY = -1.69707213380438;
% epsilon = 0.808031091653885;
% omegaX = 0.727038453078781;
% omegaY = 0.716575238588071;

gamma = 0e-2;

parameters = [epsilon, omegaX, omegaY];
Gate = Gates.GateOfOne;
% Gate = Gates.Hadamard;



Lindbladian = Hamiltonians.LindbladOne(...
    Parameters = parameters,...
    Gamma = gamma);
Choi = MeasureDiffGeneral(Lindbladian, Gate = Gate)

LindbladianTwo = Hamiltonians.LindbladRhoOne(...
    Parameters = parameters,...
    Gamma = gamma);
ChoiTwo = MeasureDiffGeneral(LindbladianTwo, Gate=Gate)

SimpleHam = Hamiltonians.SimpleHamiltonian(Parameters = parameters);
Avg = MeasureDiffGeneral(SimpleHam, Gate = Gate)

% FindU(Lindbladian)
FindU(SimpleHam)
