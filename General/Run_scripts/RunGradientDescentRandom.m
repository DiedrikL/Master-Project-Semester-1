
% Setup time
Time = TimeOptions;

% Setup parameters
range = 10;
minimum = 0.1;
repeats = 5;
learning = 1e-2;
HGate = Gates.SquareRootSwap;


% Result matrices
parameters = rand(repeats,4).*range+minimum;
result = zeros(repeats, 1);

for n=1:repeats
    para = parameters(n,:);
    Hamilt = Hamiltonians.TwoParticlesHamiltonian(Time=Time, Parameters = para);
    [para, result(n)] = GradientDescent.GradientDescent(...
    Hamilt, HGate, learning=learning)    
    parameters(n,:) = para;
end

[m, Index] = min(result);
result(Index)
parameters(index,:)