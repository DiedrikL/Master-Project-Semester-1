
% Setup time
Time = TimeOptions;

% Setup parameters
range = 10;
minimum = 0.1;
repeats = 40;
learning = 1e-3;
Gate = HGate.gate
UsedGates = zeros(4,4,repeats);


% Result matrices
parameters = rand(repeats,6).*range+minimum;
result = ones(repeats, 1);

for n=1:repeats
    HGate = Gates.RandomGate;
    para = parameters(n,:);
    Hamilt = Hamiltonians.TwoParticleMultiInteractionHamiltonian(Time=Time, Parameters = para);
    result(n) = MeasureDiffGeneral(Hamilt, Gate = HGate);  
    parameters(n,:) = para;
    UsedGates(:,:,n) = HGate.gate
    clear HGate
end
[m, Index] = max(result);
result(Index)
parameters(Index,:)