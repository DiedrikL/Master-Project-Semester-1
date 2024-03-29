
% Setup time
Time = TimeOptions;

% Setup parameters
range = 10;
minimum = 0;
repeats = 50;
learning = 1e-3;
measure = Measure.AvgFidelity;

% Measure treshold
treshold = 1e-1;

% Gate
HGate = Gates.Ygate;
HGate.gate


% create result matrices
parameters = rand(repeats,3).*range+minimum;
result = ones(repeats, 1);

% Setup for waitbar
bar = PoolWaitbar(repeats);
q = parallel.pool.DataQueue;
afterEach(q, @(value)bar.updateBarValue(value));

parfor n=1:repeats
    para = parameters(n,:);
    Hamilt = Hamiltonians.SimpleHamiltonian(Time=Time, Parameters = para);
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
