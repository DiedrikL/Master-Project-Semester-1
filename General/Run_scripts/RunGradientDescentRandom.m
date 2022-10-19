
% Setup time
Time = TimeOptions;

% Setup parameters
range = 10;
minimum = 0.1;
repeats = 100;
learning = 1e-3;
measure = 1;

% Gate
HGate = Gates.OnesGate;
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
    Hamilt, HGate, learning=learning)    
    parameters(n,:) = para;
    send(q, result(n));
end

% show best result with parameters
[m, Index] = min(result);
result(Index)
parameters(Index,:)
lowValues = sum(result<1e-1)
