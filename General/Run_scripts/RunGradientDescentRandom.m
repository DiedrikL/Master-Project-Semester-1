
% Setup time
Time = TimeOptions;

% Setup parameters
range = 10;
minimum = 0.1;
repeats = 1000;
learning = 1e-3;
%HGate = Gates.RandomUnitary;
HGate = Gates.RandomUGate;


% Result matrices
parameters = rand(repeats,6).*range+minimum;
result = ones(repeats, 1);

parfor n=1:repeats
    para = parameters(n,:);
    Hamilt = Hamiltonians.TwoParticleMultiInteractionHamiltonian(Time=Time, Parameters = para);
    [para, result(n)] = GradientDescent.GradientDescent(...
    Hamilt, HGate, learning=learning)    
    parameters(n,:) = para;
end

[m, Index] = min(result);
result(Index)
parameters(Index,:)