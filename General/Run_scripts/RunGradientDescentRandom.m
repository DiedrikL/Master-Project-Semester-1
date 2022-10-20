
% Setup time
Time = TimeOptions;

% Setup parameters
range = 1;
minimum = -0.5;
repeats = 4;
learning = 1e-3;
measure = 1;

% Measure treshold
treshold = 1e-1;

% Gate
HGate = Gates.Identity_Two;
HGate.gate


% create result matrices
parameters = rand(repeats,4).*range+minimum;
result = ones(repeats, 1);

% Setup for waitbar
bar = PoolWaitbar(repeats);
q = parallel.pool.DataQueue;
afterEach(q, @(value)bar.updateBarValue(value));

parfor n=1:repeats
    para = parameters(n,:);
    Hamilt = Hamiltonians.TwoParticleInteractionHamiltonian(Time=Time, Parameters = para);
    Hamilt.Measure = measure;
    [para, result(n)] = GradientDescent.GradientDescent(...
    Hamilt, ...
    HGate, ...
    learning=learning)   
    
    parameters(n,:) = para;
    send(q, result(n));
end

% show best result with parameters
[m, Index] = min(result);
result(Index)
parameters(Index,:)
lowValues = sum(result<treshold)
